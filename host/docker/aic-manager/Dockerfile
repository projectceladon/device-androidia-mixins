# for different build variant
ARG BUILD_VARIANT=normal

FROM ubuntu-bionic-aic:1.2 as build_base

ARG DEBIAN_FRONTEND=noninteractive

FROM build_base as build_normal

# copy MDC resources
COPY bin/graphic/liblxc_util.so /lib/liblxc_util.so
COPY bin/graphic/libutil_drm.so /lib/libutil_drm.so
COPY bin/graphic/libutil_x11.so /lib/libutil_x11.so
COPY bin/graphic/libutil_wayland.so /lib/libutil_wayland.so
COPY bin/graphic/display-daemon-drm /display-daemon-drm
COPY bin/graphic/display-daemon-x11 /display-daemon-x11
COPY bin/graphic/display-daemon-wld /display-daemon-wld

# copy mac80211_hwsim wifi resources
COPY scripts/mac80211_hwsim.sh /mac80211_hwsim.sh
COPY conf/simulated_hostapd.conf /simulated_hostapd.conf

# copy scripts
COPY scripts/CPU_info.py /CPU_info.py

# copy codes
COPY data /data

# copy entry process
COPY bin/aic-manager-entry /aic-manager-entry

# Tini as PID 1
#ENV TINI_VERSION v0.18.0
#ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
#RUN chmod +x /tini

ARG TINI_KILL_PROCESS_GROUP=1
ENV TINI_KILL_PROCESS_GROUP=${TINI_KILL_PROCESS_GROUP}

ARG TINI_VERBOSITY=3
ENV TINI_VERBOSITY=${TINI_VERBOSITY}

# we use Docker's Tini by using --init option
#ENTRYPOINT ["/tini", "--", "/aic-manager-entry"]
ENTRYPOINT ["/aic-manager-entry"]


FROM build_normal as build_loop_mount

ONBUILD COPY images /images
ONBUILD COPY scripts/image-entry /images/entry
RUN apt-get -q -y update && apt-get -q -y install cryptsetup-bin

FROM build_${BUILD_VARIANT}
ARG BUILD_VARIANT
RUN echo build variant: ${BUILD_VARIANT}
