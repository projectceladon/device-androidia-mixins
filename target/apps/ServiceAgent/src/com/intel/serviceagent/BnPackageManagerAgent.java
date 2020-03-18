package com.intel.serviceagent;

import android.app.Application;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.drawable.Drawable;
import android.os.RemoteException;
import android.util.Log;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class BnPackageManagerAgent extends IPackageManagerAgent.Stub {
    private static final String TAG = "ServiceAgent";
    private static final boolean DEBUG = false;

    private static final int PACKAGE_FLAG_ALL = 0;
    private static final int PACKAGE_FLAG_3RD_PARTY = 1;
    private static final int PACKAGE_FLAG_SYSTEM = 2;

    private static Application mApp = null;
    private static BnPackageManagerAgent mInst = null;
    private IPackageInstallerListener mInstallerListener = null;
    private static PackageManager mPm = null;

    private BnPackageManagerAgent(Application app) {
        mApp = app;
        mPm = mApp.getPackageManager();
        receiveBroadcast(mApp);
    }

    public static BnPackageManagerAgent getPackageManagerAgent(Application app) {
        if (mInst == null) {
            mInst = new BnPackageManagerAgent(app);
        }
        return mInst;
    }

    private Bitmap drawableToBitmap(Drawable drawable) {
        Bitmap bitmap = Bitmap.createBitmap(
                drawable.getIntrinsicWidth(),
                drawable.getIntrinsicHeight(),
                Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(bitmap);
        drawable.setBounds(0, 0, drawable.getIntrinsicWidth(),
                drawable.getIntrinsicHeight());
        drawable.draw(canvas);
        return bitmap;
    }

    private BroadcastReceiver broadcastReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            if (intent == null)
                return;
            if (intent.getAction().equals("android.intent.action.PACKAGE_ADDED")) {
                String packageName = intent.getDataString();
                Log.d(TAG, "安装了 :" + packageName);
                if (mInstallerListener != null) {
                    try {
                        mInstallerListener.onInstalled(packageName);
                    } catch (RemoteException e) {
                        e.printStackTrace();
                    }
                }
            }
            if (intent.getAction().equals("android.intent.action.PACKAGE_REMOVED")) {
                String packageName = intent.getDataString();
                Log.d(TAG, "卸载了 :" + packageName);
                if (mInstallerListener != null) {
                    try {
                        mInstallerListener.onUninstalled(packageName);
                    } catch (RemoteException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    };

    private void receiveBroadcast(Application app) {
        IntentFilter filter = new IntentFilter();
        filter.addAction("android.intent.action.PACKAGE_ADDED");
        filter.addAction("android.intent.action.PACKAGE_REMOVED");
        filter.addDataScheme("package");
        app.registerReceiver(broadcastReceiver, filter);
    }

    @Override
    public List<String> getPackageList(int flags) throws RemoteException {
        Log.d(TAG, "getPackageList");

        List<String> pkgNames = new ArrayList<>();
        List<PackageInfo> pkgInfos = mPm.getInstalledPackages(0);
        for (int i=0; i<pkgInfos.size(); i++) {
            PackageInfo pkgInfo = pkgInfos.get(i);
            final boolean isSystem =
                    (pkgInfo.applicationInfo.flags& ApplicationInfo.FLAG_SYSTEM) != 0;

            if ((flags == PACKAGE_FLAG_3RD_PARTY && !isSystem) ||
                (flags == PACKAGE_FLAG_SYSTEM && isSystem) ||
                (flags == PACKAGE_FLAG_ALL)) {
                pkgNames.add(pkgInfos.get(i).packageName);
                if (DEBUG) {
                    Log.d(TAG, pkgInfos.get(i).packageName);
                }
            }
        }
        return pkgNames;
    }

    @Override
    public String getLaunchIntent(String pkg) throws RemoteException {
        Log.d(TAG, "getApplicationLaunchIntent");
        try {
            StringBuilder sb = new StringBuilder(pkg);
            Intent intent = mPm.getLaunchIntentForPackage(pkg);
            if (intent != null) {
                sb.append("/");
                sb.append(intent.getComponent().getClassName());
                Log.d(TAG, "intent for " + pkg +" " + intent.toString());
            }
            return sb.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public byte[] getIcon(String pkg) throws RemoteException {
        Log.d(TAG, "getApplicationIcon");

        try {
            Drawable applicationIcon = mPm.getApplicationIcon(pkg);
            Bitmap bm = drawableToBitmap(applicationIcon);
            ByteArrayOutputStream os = new ByteArrayOutputStream();
            bm.compress(Bitmap.CompressFormat.PNG, 100, os);
            byte[] data = os.toByteArray();

            if (DEBUG) {
                try {
                    File f = new File(mApp.getFilesDir() + "/2.png");
                    if (!f.exists()) {
                        f.createNewFile();
                    }
                    FileOutputStream fos = new FileOutputStream(f);
                    fos.write(os.toByteArray());
                    fos.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            return data;
        }
        catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }
        return new byte[0];
    }

    @Override
    public void addInstallerListener(IPackageInstallerListener listener) throws RemoteException {
        mInstallerListener = listener;
    }

    @Override
    public void removeInstallerListener(IPackageInstallerListener listener) throws RemoteException {
        mInstallerListener = null;
    }
}
