package com.intel.subtract;

import android.app.Application;
import android.os.RemoteException;
import android.util.Log;

public class BnSubtract extends ISubtract.Stub {
    private static final String TAG = "BnSubtract";

    @Override
    public int subtract(int a, int b) throws android.os.RemoteException {
        Log.i(TAG, "Incoming two numbers: a = " + a + " b = " + b);
        int c = a - b;
        Log.i(TAG, "Return the sum(" + c + ") to client.");
        return c;
    }
}