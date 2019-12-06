package com.intel.serviceagent;

import android.app.Application;
import android.os.RemoteException;

import java.util.HashMap;
import java.util.Map;

public class BnHostSettingsAgent extends IHostSettingsAgent.Stub {
    private static final String TAG = "ServiceAgent";
    private static BnHostSettingsAgent mInst = null;
    private IHostSettingsListener mHostSettingsListener = null;
    private Map<String, String> mPendingRequest = new HashMap<String, String>();

    public BnHostSettingsAgent() {}

    public static BnHostSettingsAgent getHostSettingsAgent() {
        if (mInst == null) {
            mInst = new BnHostSettingsAgent();
        }
        return mInst;
    }

    public void addHostSettingsListener(IHostSettingsListener listener) throws RemoteException {
        mHostSettingsListener = listener;
        if (mHostSettingsListener != null) {
            for (String key : mPendingRequest.keySet()) {
                String value = mPendingRequest.get(key);
                mHostSettingsListener.setHostSetting(key, value);
            }
            mPendingRequest.clear();
        }
    }

    public void removeHostSettigsListener(IHostSettingsListener listener) {
        if (mHostSettingsListener == listener) {
            mHostSettingsListener = null;
        }
    }

    @Override
    public String getHostSetting(String key) throws RemoteException {
        if (mHostSettingsListener != null) {
            return mHostSettingsListener.getHostSetting(key);
        }
        return null;
    }

    @Override
    public int setHostSetting(String key, String value) throws RemoteException {
        if (mHostSettingsListener != null) {
            mHostSettingsListener.setHostSetting(key, value);
        } else {
            mPendingRequest.put(key, value);
        }
        return 0;
    }
}
