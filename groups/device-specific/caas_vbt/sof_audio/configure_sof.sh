#!/bin/bash
SOFBIN_TPLGS="sof-bin/v2.2.x/sof-tplg/"
SOFBIN_FWS="sof-bin/v2.2.x/sof/"
LIB_TPLG="/lib/firmware/intel/sof-tplg/"
LIB_FW="/lib/firmware/intel/sof/"
SOF_WORK_DIR="$2/sof_audio"
ALSA_CONF="/etc/modprobe.d/alsa-base.conf"
USAGE="Usage : configure_sof.sh install/uninstall WorkingDir"

function setupSof {
     if [[ -z `grep 'options snd-intel-dspcfg' $ALSA_CONF` ]];then
        echo "options snd-intel-dspcfg dsp_driver=3" >> $ALSA_CONF
     else
        sed -i 's/options snd-intel-dspcfg dsp_driver=1/options snd-intel-dspcfg dsp_driver=3/g' $ALSA_CONF
    fi

    cd $SOF_WORK_DIR
    if [ -d "$LIB_FW" ]; then
        if [ ! -d "sof_bkp" ]; then
            sudo mv $LIB_FW "sof_bkp"
        fi
    fi
    if [ -d "$LIB_TPLG" ]; then
        if [ ! -d "sof-tplg_bkp" ]; then
            sudo mv $LIB_TPLG "sof-tplg_bkp"
        fi
    fi
    sudo mkdir $LIB_FW
    sudo mkdir $LIB_TPLG

    rm -rf sof-bin
    git clone https://github.com/thesofproject/sof-bin -b v2.2
    if [ ! -d "sof-bin" ]; then
        echo "Failed to download "
        exit -1
    fi
    sudo cp "${SOFBIN_TPLGS}sof-hda-generic-4ch.tplg" $LIB_TPLG
    sudo cp "${SOFBIN_TPLGS}sof-hda-generic-2ch.tplg" $LIB_TPLG
    sudo cp "${SOFBIN_TPLGS}sof-hda-generic.tplg" $LIB_TPLG
    sudo cp "${SOFBIN_FWS}sof-cml.ri" $LIB_FW
    sudo cp "${SOFBIN_FWS}sof-cnl.ri" $LIB_FW
    sudo cp "${SOFBIN_FWS}sof-adl.ri" $LIB_FW
}

function restore {
    cd $SOF_WORK_DIR
    rm -rf sof-bin
    sudo rm -rf $LIB_FW
    sudo rm -rf $LIB_TPLG
    if [ -d "sof_bkp" ]; then
        sudo mv "sof_bkp" $LIB_FW
    fi
    if [ -d "sof-tplg_bkp" ]; then
        sudo mv "sof-tplg_bkp" $LIB_TPLG
    fi
    cd ..
    rm -rf  $SOF_WORK_DIR
    sed -i 's/options snd-intel-dspcfg dsp_driver=3/options snd-intel-dspcfg dsp_driver=1/g' $ALSA_CONF
}

if [[ ! -d $SOF_WORK_DIR ]]; then
    echo "Error : $SOF_WORK_DIR does not exist"
    echo $USAGE
    exit -1
fi

echo "SOF_WORK_DIR=$SOF_WORK_DIR"

if [[ $1 == "install" ]]; then
    setupSof
else
    if [[ $1 == "uninstall" ]]; then
        restore
    else
        echo $USAGE
        exit -1
    fi
fi

