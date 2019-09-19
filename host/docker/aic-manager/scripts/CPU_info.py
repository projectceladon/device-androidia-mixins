#!/usr/bin/env python

# Use FUSE to create a isolated CPU folder under /sys/devices/system/cpu
# Re-mount the cpu folder in docker, then the container only could see the
# CPU information which matches its CPU affinity

import copy
import errno
import functools
import logging
import os
import stat
import re
import psutil
from itertools import groupby
from operator import itemgetter

import fuse
from fuse import Fuse


if not hasattr(fuse, '__version__'):
    raise RuntimeWarning("Couldn't get the version of fuse!")


fuse.fuse_python_api = (0, 2)
fuse.feature_assert('stateful_files', 'has_init')

SHARED_HOST_STAT = ['st_size', 'st_atime', 'st_mtime', 'st_ctime']
HOST_CPU_INFO_PATH = "/sys/devices/system/cpu/"

LOG = logging.getLogger("CPU_info_v1")
LOG.setLevel(logging.DEBUG)


def dec_check_path(host_path=True, inner_class=False):
    """
    File path check
    :param host_path:
    :param inner_class:
    :return:
    """
    def decorator(func):
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            path = args[1] if inner_class else args[0]
            if path is None:
                raise Exception("No path need to check! Please remove this decorator!")
            if not host_path:
                path = HOST_CPU_INFO_PATH + path
            if not os.path.exists(path):
                LOG.error("Path {0} not exist!".format(path))
                return -errno.ENOENT
            else:
                return func(*args, **kwargs)

        return wrapper

    return decorator


@dec_check_path()
def parse_folder(path):
    """
    Parse the folder
    :param path:
    :return:
    """
    ret = {}

    for root, dirs, files in os.walk(path, topdown=True):
        s_link = {}
        dirs_copy = copy.copy(dirs)
        # Check if it is link
        for _dir in dirs_copy:
            _path = root + '/' + _dir
            if os.path.islink(_path):
                dirs.remove(_dir)
                s_link[_dir] = os.readlink(_path)

        if root.startswith("/sys/devices/system/"):
            root = root[23:]

        ret[root] = {"dir": dirs, "files": files, "links": s_link}

    return ret


def get_cpu_set(pid):
    """
    Return the cpu affinity
    :param pid:
    :return: CPU ID list
    """
    return psutil.Process(pid).cpu_affinity()


def list2str(list_in):
    """

    :param list_in:
    :return:
    """
    return ",".join(list(map(str, list_in)))


def split_path(path):
    """"""
    index = path.rfind('/')
    prefix = '/' if not path[0:index] else path[0:index]
    return prefix, path[index+1:]


def convert_cpu_list(cpu_list):
    """
    Convert CPU list from int to str
    :param cpu_list:
    :return:
    """
    ret = ""
    cpu_list = sorted(cpu_list)

    for k, v in groupby(enumerate(cpu_list), lambda (x, y): x - y):
        data = map(itemgetter(1), v)
        if len(data) > 1:
            ret += "{0}-{1},".format(data[0], data[-1])
        elif len(data) == 1:
            ret += "{0},".format(data[0])
        else:
            LOG.error("Invalid CPU list: {0}".format(cpu_list))
            raise Exception("Wrong CPU list!")

    return ret.rstrip(",")


def filter_dirs_files(i_list, pid):
    """
    Each process should be able to see the cpu/policy folder matches its cpu set
    :param i_list:
    :param pid:
    :return:
    """
    cpu_list = get_cpu_set(pid)
    filter_prefix = ['cpu', 'policy']
    filter_list = []
    ret = []

    for i in filter_prefix:
        filter_list += map(lambda x: i + str(x), cpu_list)

    for each in i_list:
        if re.match(r'cpu\d', each):
            if each in filter_list:
                ret.append(each)
        elif re.match(r'policy\d', each):
            if each in filter_list:
                ret.append(each)
        else:
            ret.append(each)

    return ret


HOST_CPU_INFO = parse_folder(HOST_CPU_INFO_PATH)


class FileStat(fuse.Stat):
    """
    File Stats
    """
    def __init__(self):
        self.st_mode = 0
        self.st_ino = 0
        self.st_dev = 0
        self.st_nlink = 0
        self.st_uid = 0
        self.st_gid = 0
        self.st_size = 0
        self.st_atime = 0
        self.st_mtime = 0
        self.st_ctime = 0


@dec_check_path(host_path=False)
def file_ops_proxy(path):
    """
    Proxy to host files
    :param path:
    :return:
    """
    # For uevent file, it should be created with write access
    if 'uevent' in path:
        ops_mode = os.O_WRONLY
    else:
        ops_mode = os.O_RDONLY
    return os.fdopen(os.open(HOST_CPU_INFO_PATH + path, ops_mode))


class CPUSysFs(Fuse):
    """
    FUSE file system for CPU information of container
    """
    def __init__(self, *args, **kw):
        Fuse.__init__(self, *args, **kw)

    # File system methods

    @dec_check_path(host_path=False, inner_class=True)
    def getattr(self, path):
        """
        Get dir/files attributes
        :param path:
        :return:
        """
        f_stat = FileStat()
        if path == '/':
            f_stat.st_mode = stat.S_IFDIR | 0755
            f_stat.st_nlink = 2
        else:
            path_index, f_name = split_path(path)
            if f_name in HOST_CPU_INFO.get(path_index)["dir"]:
                f_stat.st_mode = stat.S_IFDIR | 0755
                f_stat.st_nlink = 2
            elif f_name in HOST_CPU_INFO.get(path_index)["files"]:
                # For uevent file, it still need the write access
                if 'uevent' in f_name:
                    st_mode = 0644
                else:
                    st_mode = 0444
                f_stat.st_mode = stat.S_IFREG | st_mode
                f_stat.st_nlink = 1
            elif f_name in HOST_CPU_INFO.get(path_index)["links"].keys():
                f_stat.st_mode = stat.S_IFLNK | 0755
                f_stat.st_nlink = 2

        host_stat = os.stat(HOST_CPU_INFO_PATH + path)
        for _attr in SHARED_HOST_STAT:
            setattr(f_stat, _attr, getattr(host_stat, _attr))

        return f_stat

    def readlink(self, path):
        """
        Read the link
        :param path:
        :return:
        """
        path_index, f_name = split_path(path)
        return HOST_CPU_INFO.get(path_index)["links"].get(f_name, -errno.EINVAL)

    def unlink(self, path):
        """
        Unlink the path
        :param path:
        :return:
        """
        pass

    @dec_check_path(host_path=False, inner_class=True)
    def readdir(self, path, offset):
        """
        Read dir contents. For CPU/policy folder, only display
        the folders that match the cpu set
        :param path:
        :param offset:
        :return:
        """
        f_cont = self.GetContext()
        c_list = HOST_CPU_INFO.get(path)
        dir_list = c_list.get("dir")
        file_list = c_list.get("files")
        link_list = c_list.get("links").keys()
        host_dirs_files = dir_list + file_list + link_list

        filter_list = filter_dirs_files(host_dirs_files, f_cont['pid'])
        for c in filter_list:
            if c in dir_list:
                f_type = stat.S_IFDIR
            if c in file_list:
                f_type = stat.S_IFREG
            if c in link_list:
                f_type = stat.S_IFLNK
            yield fuse.Direntry(c, type=f_type)

    def mkdir(self, path, mode):
        """
        Create dir
        :param path:
        :param mode:
        :return:
        """
        os.mkdir("." + path, mode)

    # Files Ops

    @dec_check_path(host_path=False, inner_class=True)
    def read(self, path, length, offset, *args, **kw):
        """"""
        if path in ["/online", "/present"]:
            ret_str = convert_cpu_list(get_cpu_set(self.GetContext()['pid']))
            str_len = len(ret_str)
            if offset < str_len:
                if offset + length > str_len:
                    length = str_len - offset
                buf = ret_str[offset:offset+length]
            else:
                return 0
        elif path == "/offline":
            buf = ""
        else:
            file_proxy = file_ops_proxy(path)
            file_proxy.seek(offset)
            buf = file_proxy.read(length)
            file_proxy.close()

        return buf

    @dec_check_path(host_path=False, inner_class=True)
    def open(self, path, flags):
        """

        :param path:
        :param flags:
        :return:
        """
        access_mode = os.O_RDONLY | os.O_WRONLY | os.O_RDWR
        if (flags & access_mode) != os.O_RDONLY:
            return -errno.EACCES
        return 0

    @dec_check_path(host_path=False, inner_class=True)
    def write(self, path, buf, offset):
        """
        Need the write operation to uevent file
        :param path:
        :param buf:
        :param offset:
        :param fd:
        :return:
        """
        return len(buf)

    def flush(self, path, *args, **kw):
        """"""
        pass

    def release(self, path, *args, **kw):
        return 0

    def fsync(self, path, *args, **kw):
        return 0

    def statfs(self, *args, **kw):
        return 0

    def releasedir(self, *args, **kw):
        return 0

    def fsyncdir(self, *args, **kw):
        return 0

    def utime(self, path, times):
        pass

    @dec_check_path(host_path=False, inner_class=True)
    def access(self, path, mode):
        pass

    def fsinit(self):
        pass

    def main(self, *a, **kw):
        """
        Main entry
        :param a:
        :param kw:
        :return:
        """
        return Fuse.main(self, *a, **kw)


def main():

    server = CPUSysFs(version="%prog " + fuse.__version__)
    server.parse(errex=1)
    # Need allow_other attribute to remount into container
    server.fuse_args.add("allow_other")
    server.main()


if __name__ == '__main__':
    main()

