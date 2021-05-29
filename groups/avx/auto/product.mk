PRODUCT_COPY_FILES += $(LOCAL_PATH)/extra_files/avx/checkavx.sh:vendor/bin/checkavx.sh

PRODUCT_PACKAGES += libaudioprocessing_avx2 \
		    libneuralnetworks_avx2 \
		    libRSCpuRef_avx2 \
		    libart_avx2.com.android.art.debug \
		    libart_avx2.com.android.art.release \
		    libartd_avx2.com.android.art.debug
