#!/vendor/bin/sh

echo "Invoking checkavx" > /data/checkavx.txt
IS_AVX2=`cat /proc/cpuinfo | grep -w "avx2" | wc -l`
if [ $IS_AVX2 -gt 0 ]
   then	
     setprop dalvik.vm.isa.x86.variant kabylake
     setprop dalvik.vm.isa.x86_64.variant kabylake
fi     
