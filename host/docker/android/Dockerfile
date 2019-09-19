FROM scratch
Add ./root/ /
COPY ./android-entry /
ENV ANDROID_DATA=/data                 \
    DOWNLOAD_CACHE=/data/cache         \
    LOGNAME=shell                      \
    HOME=/                             \
    ANDROID_BOOTLOGO=1                 \
    ANDROID_ASSETS=/system/app         \
    BOOTCLASSPATH=/system/framework/core-oj.jar:/system/framework/core-libart.jar:/system/framework/conscrypt.jar:/system/framework/okhttp.jar:/system/framework/bouncycastle.jar:/system/framework/apache-xml.jar:/system/framework/ext.jar:/system/framework/framework.jar:/system/framework/telephony-common.jar:/system/framework/voip-common.jar:/system/framework/ims-common.jar \
    ASEC_MOUNTPOINT=/mnt/asec          \
    EXTERNAL_STORAGE=/sdcard           \
    ANDROID_STORAGE=/storage           \
    USER=shell                         \
    PATH=/sbin:/system/sbin:/system/bin:/system/xbin \
    SYSTEMSERVERCLASSPATH=/system/framework/services.jar:/system/framework/ethernet-service.jar:/system/framework/wifi-service.jar:/system/framework/com.android.location.provider.jar \
    ANDROID_ROOT=/system
ENTRYPOINT ["/android-entry"]
