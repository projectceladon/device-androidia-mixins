package com.intel.subtract;

import android.app.Application;
import android.os.IBinder;
import android.util.Log;
import java.lang.reflect.Method;

public class SubtractServiceApplication extends Application {
    private static final String TAG = "SubtractServiceApplication";
    private static final String SERVICE_NAME = "subtract";

    public void onCreate() {
        Log.d(TAG, "onCreate");
        super.onCreate();

        Object object = new Object();
        Method addService;
        try {
            addService = Class.forName("android.os.ServiceManager").getMethod("addService", String.class,
                    IBinder.class);
            addService.invoke(object, new Object[] { SERVICE_NAME, new BnSubtract() });
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void onTerminate() {
        super.onTerminate();
    }

}
