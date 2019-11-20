Binder IPC

* User case:
    1. IPC between AIC and ubuntu which shares the same Linux kernel. 
    2. IPC in ubuntu.

* The advantage of binder IPC than socket.
    1. One copy. Low latency.
    2. If it is used for IPC between AIC and ubuntu, the interface of service in android can be used directly without modification.

* Build ubunuService and ubunuClient on Ubunutu:
    1. cd vendor/intel/cic/host/libbinder_ubuntu_test/
    2. mkdir build
    3. cd build
    4. cmake ../
    5. make
    6. ubunuService and ubunuClient are in vendor/intel/cic/host/libbinder_ubuntu_test/bin/linux/

* Build androidService and androidClient in android.
    1. source build/envsetup.sh
    2. lunch cic_dev-userdebug
    3. mmm vendor/intel/cic/target/apps/libbinder_test/
    4. androidService and androidClient are in out/target/product/cic_dev/system/bin/.

* Using 1:
    Ubuntu Service: 
        1. Make sure libbinder.so can be found via LD_LIBRARY_PATH.
        2. # sudo ./ubunuService
    Android Client:
        1. adb push androidClient /data/local/tmp/
        2. adb shell
        3. ./data/local/tmp/androidClient
    Output:
        Ubuntu Service:
            binlyd@binlyd[22:16:17]:/work/cic$ sudo ./ubuntuService 
            [sudo] password for binlyd: 
            ubuntuService 0x1e106e8 sucessful, rv: 0
            ADD_INTS 1: 23 + 31
        Android Client:
            cic_dev:/data/local/tmp $ ./androidClient
            pass, result: 54 expected: 54
            cic_dev:/data/local/tmp $ 

* Using 2:
    Android Service: 
        1. adb push androidService /data/local/tmp/
        2. adb shell
        3. ./data/local/tmp/androidService
    Ubuntu Client:
        1. Make sure libbinder.so can be found via LD_LIBRARY_PATH.
        2. # sudo ./ubunuClient
    Output:
        Android Service:
            cic_dev:/data/local/tmp $ ./androidService
            Start androidService success.
            androidService C2S 1: 71 + 11
        Ubuntu Client:
            binlyd@binlyd[22:23:21]:/work/cic$ sudo ./ubuntuClient 
            pass, result: 82 expected: 82
            binlyd@binlyd[22:23:35]:/work/cic$ 
    
