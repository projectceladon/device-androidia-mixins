# kernel modules must be copied before vendorimage is generated
$(PRODUCT_OUT)/super.img: handle_isa_perf_modules

ISA_PERF_LIB_PATH:= "IA-Perf/avx2"
isa_perf_libs: avx2_libs

avx2_libs: libneuralnetworks_avx2 \
	   libaudioprocessing_avx2 \
	   libRSCpuRef_avx2 \
	   libart_avx2.com.android.art.debug \
	   libart_avx2.com.android.art.release \
	   libartd_avx2.com.android.art.debug

handle_isa_perf_modules: isa_perf_libs
	mv $(PRODUCT_OUT)/system/lib/$(ISA_PERF_LIB_PATH)/libaudioprocessing_avx2.so $(PRODUCT_OUT)/system/lib/$(ISA_PERF_LIB_PATH)/libaudioprocessing.so
	mv $(PRODUCT_OUT)/system/lib64/$(ISA_PERF_LIB_PATH)/libaudioprocessing_avx2.so $(PRODUCT_OUT)/system/lib64/$(ISA_PERF_LIB_PATH)/libaudioprocessing.so
	mv $(PRODUCT_OUT)/system/apex/com.android.neuralnetworks/lib/$(ISA_PERF_LIB_PATH)/libneuralnetworks_avx2.so $(PRODUCT_OUT)/system/apex/com.android.neuralnetworks/lib/$(ISA_PERF_LIB_PATH)/libneuralnetworks.so
	mv $(PRODUCT_OUT)/system/apex/com.android.neuralnetworks/lib64/$(ISA_PERF_LIB_PATH)/libneuralnetworks_avx2.so $(PRODUCT_OUT)/system/apex/com.android.neuralnetworks/lib64/$(ISA_PERF_LIB_PATH)/libneuralnetworks.so
	mv $(PRODUCT_OUT)/system/lib/$(ISA_PERF_LIB_PATH)/libRSCpuRef_avx2.so $(PRODUCT_OUT)/system/lib/$(ISA_PERF_LIB_PATH)/libRSCpuRef.so
	mv $(PRODUCT_OUT)/system/lib64/$(ISA_PERF_LIB_PATH)/libRSCpuRef_avx2.so $(PRODUCT_OUT)/system/lib64/$(ISA_PERF_LIB_PATH)/libRSCpuRef.so
	mv $(PRODUCT_OUT)/system/apex/com.android.vndk.current/lib/$(ISA_PERF_LIB_PATH)/libRSCpuRef_avx2.so $(PRODUCT_OUT)/system/apex/com.android.vndk.current/lib/$(ISA_PERF_LIB_PATH)/libRSCpuRef.so
	mv $(PRODUCT_OUT)/system/apex/com.android.vndk.current/lib64/$(ISA_PERF_LIB_PATH)/libRSCpuRef_avx2.so $(PRODUCT_OUT)/system/apex/com.android.vndk.current/lib64/$(ISA_PERF_LIB_PATH)/libRSCpuRef.so
	mv $(PRODUCT_OUT)/system/apex/com.android.art.release/lib/$(ISA_PERF_LIB_PATH)/libart_avx2.so $(PRODUCT_OUT)/system/apex/com.android.art.release/lib/$(ISA_PERF_LIB_PATH)/libart.so
	mv $(PRODUCT_OUT)/system/apex/com.android.art.release/lib64/$(ISA_PERF_LIB_PATH)/libart_avx2.so $(PRODUCT_OUT)/system/apex/com.android.art.release/lib64/$(ISA_PERF_LIB_PATH)/libart.so
	mv $(PRODUCT_OUT)/system/apex/com.android.art.debug/lib/$(ISA_PERF_LIB_PATH)/libart_avx2.so $(PRODUCT_OUT)/system/apex/com.android.art.debug/lib/$(ISA_PERF_LIB_PATH)/libart.so
	mv $(PRODUCT_OUT)/system/apex/com.android.art.debug/lib64/$(ISA_PERF_LIB_PATH)/libart_avx2.so $(PRODUCT_OUT)/system/apex/com.android.art.debug/lib64/$(ISA_PERF_LIB_PATH)/libart.so
	mv $(PRODUCT_OUT)/system/apex/com.android.art.debug/lib/$(ISA_PERF_LIB_PATH)/libartd_avx2.so $(PRODUCT_OUT)/system/apex/com.android.art.debug/lib/$(ISA_PERF_LIB_PATH)/libartd.so
	mv $(PRODUCT_OUT)/system/apex/com.android.art.debug/lib64/$(ISA_PERF_LIB_PATH)/libartd_avx2.so $(PRODUCT_OUT)/system/apex/com.android.art.debug/lib64/$(ISA_PERF_LIB_PATH)/libartd.so
