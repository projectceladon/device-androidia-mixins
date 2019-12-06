package com.intel.serviceagent;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;
import android.util.Log;

public class HostSettings extends Service {
    private static final String LOG_TAG = "HostSettings";
    private static BnHostSettingsAgent mStub = BnHostSettingsAgent.getHostSettingsAgent();

    public HostSettings() {
    }

    @Override
    public IBinder onBind(Intent intent) {
        Log.d(LOG_TAG, "onBind");

        return mStub;
    }

    @Override
    public void onCreate() {
        Log.d(LOG_TAG, "onCreate");

        super.onCreate();
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        Log.d(LOG_TAG, "onStartCommand:" + intent);

        return super.onStartCommand(intent, flags, startId);
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
    }
}
