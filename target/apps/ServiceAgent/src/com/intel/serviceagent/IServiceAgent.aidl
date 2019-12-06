// IServiceAgent.aidl
package com.intel.serviceagent;

// Declare any non-default types here with import statements
import com.intel.serviceagent.IPackageManagerAgent;
import com.intel.serviceagent.IClipboardAgent;
import com.intel.serviceagent.IHostSettingsAgent;
import com.intel.serviceagent.IHostSettingsListener;

interface IServiceAgent {
    IPackageManagerAgent getPackageManagerAgent();
    IClipboardAgent getClipboardAgent();
    IHostSettingsAgent getHostSettingsAgent();
    void addHostSettingsListener(IHostSettingsListener listener);
    void removeHostSettingsListener(IHostSettingsListener listener);
}
