Binder IPC

# Precondition on Ubuntu host:
1. $ sudo apt-get install aidl
# User case:
1. IPC between AIC and ubuntu which shares the same Linux kernel.
2. IPC in ubuntu.
# The advantage of binder IPC than the socket.
1. One copy. Low latency.
2. If it is used for IPC between AIC and ubuntu, the interface of service in android can be used directly without modification.
# Build sumServiceUbuntu and multiplyClientUbuntu on Ubunutu:
1. cd vendor/intel/cic/host/libbinder_test_ubuntu
2. mkdir build
3. cd build
4. cmake ../
5. make clean
6. make
7. sumServiceUbuntu and multiplyClientUbuntu are in vendor/intel/cic/host/libbinder_test_ubuntu/bin/linux
# Build sumClientAndroid and multiplyServiceAndroid in android.
1. source build/envsetup.sh
2. lunch cic_dev-userdebug
3. mmm vendor/intel/cic/target/apps/libbinder_test/
4. sumClientAndroid and multiplyServiceAndroid are in out/target/product/cic_dev/system/bin/.
# User case 1:
## Sum Service on Ubuntu:
1. Make sure libbinder.so can be found via LD_LIBRARY_PATH. LD_LIBRARY_PATH=$LD_LIBRARY_PATH:<dir-of-libbinder-lib>; export LD_LIBRARY_PATH
2. $ ./sumServiceUbuntu
## Sum Client on Android:
1. $ adb push sumClientAndroid /data/local/tmp/
2. $ adb shell /data/local/tmp/sumClientAndroid
3. Input 2 numbers to sum
## Output of sumServiceUbuntu and sumClientAndroid
### The output of sumServiceUbuntu:
        $ ./sumServiceUbuntu
        SumService is added successfully.
        Incoming two numbers: a = 23 b = 31
        Return the sum(54) to client.
### The output of sumClientAndroid:
        $ adb shell /data/local/tmp/sumClientAndroid
        sum service is obtained
        This test is used to sum of two numbers:
        Input a:23
        Input b:31
        a = 23 b = 31 expected_value = 54
        Pass. actual_value(54) equals expected_value.
# User case 2:
## Multiply Service on Android:
1. $ adb push multiplyServiceAndroid /data/local/tmp/
2. $ adb shell /data/local/tmp/multiplyServiceAndroid
## Multiply Client on Ubuntu:
1. Make sure libbinder.so can be found via LD_LIBRARY_PATH. LD_LIBRARY_PATH=$LD_LIBRARY_PATH:<dir-of-libbinder-lib>; export LD_LIBRARY_PATH
2. $ ./multiplyClientUbuntu
3. Input 2 numbers to multiply.
### The output of multiplyServiceAndroid:
        $ adb shell /data/local/tmp/multiplyServiceAndroid
        MultipyService is added successfully.
        Incoming two numbers: a = 23 b = 31
        Return the multiply(713) to client.
### The output of multiplyClientUbuntu:
        $ ./multiplyClientUbuntu
        multiply service is obtained
        This test is used to multiply of two numbers:
        Input a:23
        Input b:31
        a = 23 b = 31 expected_value = 713
        Pass. actual_value(713) equals expected_value.
# For the IPC between java service and Ubuntu client. Please the developer reference SubtractServiceApplication and subtractClientUbuntu.