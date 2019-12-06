package com.intel.serviceagent;

import android.app.Application;
import android.os.RemoteException;

public class BnServiceAgent extends IServiceAgent.Stub {
    private static final String TAG = "ServiceAgent";
    private static Application mApp = null;
    private static BnServiceAgent mInst = null;

    private BnServiceAgent(Application app){
        mApp = app;
    }

    public static BnServiceAgent getServiceAgent(Application app) {
        if (mInst == null) {
            mInst = new BnServiceAgent(app);
        }
        return mInst;
    }

    @Override
    public IPackageManagerAgent getPackageManagerAgent() throws RemoteException {
        return BnPackageManagerAgent.getPackageManagerAgent(mApp);
    }

    @Override
    public IClipboardAgent getClipboardAgent() throws RemoteException {
        return BnClipboardAgent.getClipboardAgent(mApp);
    }

    @Override
    public IHostSettingsAgent getHostSettingsAgent() throws RemoteException {
        return BnHostSettingsAgent.getHostSettingsAgent();
    }

    @Override
    public void addHostSettingsListener(IHostSettingsListener listener) throws RemoteException {
        BnHostSettingsAgent agent = BnHostSettingsAgent.getHostSettingsAgent();
        agent.addHostSettingsListener(listener);
    }

    @Override
    public void removeHostSettingsListener(IHostSettingsListener listener) throws RemoteException {
        BnHostSettingsAgent agent = BnHostSettingsAgent.getHostSettingsAgent();
        agent.removeHostSettigsListener(listener);
    }
}
