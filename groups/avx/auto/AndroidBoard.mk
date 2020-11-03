# kernel modules must be copied before vendorimage is generated
$(PRODUCT_OUT)/super.img: HANDLE_AVX_MODULES

HANDLE_AVX_MODULES: libneuralnetworks_avx2 libaudioprocessing_avx2
	mv $(PRODUCT_OUT)/system/lib/IA-Perf/avx2/libaudioprocessing_avx2.so $(PRODUCT_OUT)/system/lib/IA-Perf/avx2/libaudioprocessing.so
	mv $(PRODUCT_OUT)/system/lib64/IA-Perf/avx2/libaudioprocessing_avx2.so $(PRODUCT_OUT)/system/lib64/IA-Perf/avx2/libaudioprocessing.so
	mv $(PRODUCT_OUT)/system/apex/com.android.neuralnetworks/lib/IA-Perf/avx2/libneuralnetworks_avx2.so $(PRODUCT_OUT)/system/apex/com.android.neuralnetworks/lib/IA-Perf/avx2/libneuralnetworks.so
	mv $(PRODUCT_OUT)/system/apex/com.android.neuralnetworks/lib64/IA-Perf/avx2/libneuralnetworks_avx2.so $(PRODUCT_OUT)/system/apex/com.android.neuralnetworks/lib64/IA-Perf/avx2/libneuralnetworks.so
