package com.intel.serviceagent;

import android.app.Application;
import android.os.IBinder;
import android.util.Log;

import java.lang.reflect.Method;

public class ServiceAgent extends Application {
    private static final String TAG = "ServiceAgent";
    private static final String SERVICE_NAME = "ServiceAgent";

    public void onCreate() {
        Log.d(TAG, "onCreate");
        super.onCreate();

        Object object = new Object();
        Method addService;
        try {
            addService = Class.forName("android.os.ServiceManager").getMethod("addService", String.class, IBinder.class);
            addService.invoke(object, new Object[]{SERVICE_NAME, BnServiceAgent.getServiceAgent(this)});
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void onTerminate() {
        super.onTerminate();
    }

}
