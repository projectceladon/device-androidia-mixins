// IHostSettingsAgent.aidl
package com.intel.serviceagent;

// Declare any non-default types here with import statements

interface IHostSettingsAgent {
    String getHostSetting(String key);
    int setHostSetting(String key, String value);
}
