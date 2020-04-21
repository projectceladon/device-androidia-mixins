import logging
import os
import os.path
import re
import shutil
import sys
import tempfile
import struct
import math
import subprocess

FIXED_SALT = "aee087a5be3b982978c923f566a94613496b417f2af592639bc80d141e34dfe7"

def RunCommand(cmd, verbose=None):
  """Echo and run the given command.

  Args:
    cmd: the command represented as a list of strings.
    verbose: show commands being executed.
  Returns:
    A tuple of the output and the exit code.
  """
  if verbose:
    print("Running: " + " ".join(cmd))
  p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
  output, _ = p.communicate()

  if verbose:
    print(output.rstrip())
  return (output, p.returncode)

def build_verity_metadata(input_img, verity_metadata):
  cmd = ["veritysetup", "format", "-s", FIXED_SALT, input_img,
         verity_metadata]
  output, exit_code = RunCommand(cmd)
  if exit_code != 0:
    print("Could not build verity tree! Error: %s" % output)
    return False
  for line in output.split("\n"):
    if (line.find("Root hash") != -1):
      root = line.split(":")[-1].strip()
    if (line.find("Salt") != -1):
      salt = line.split(":")[-1].strip()

  tree_size = int(os.path.getsize(verity_metadata))
  #print("tree_size=%d" % tree_size)

  header = struct.pack("I64sI",
      len(root),
      root,
      tree_size)
  #print(header)

  with open(verity_metadata, "r+") as f:
    hashtree = f.read()
    f.seek(0)
    f.write(header)
    f.write(hashtree)
    f.flush()

  return True

def main(argv):
	if len(argv) != 2:
		print("Usage: build_verity_img.py system.img verity_metadata")
		sys.exit(1)

	input_file = argv[0]
	output_file = argv[1]
	if os.path.exists(output_file):
		os.remove(output_file)

	# build the verity metadata
	if not build_verity_metadata(input_file, output_file):
		return False

if __name__ == '__main__':
	main(sys.argv[1:])
