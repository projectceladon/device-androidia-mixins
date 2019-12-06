// IPackageInstallerListener.aidl
package com.intel.serviceagent;

// Declare any non-default types here with import statements

interface IPackageInstallerListener {
    void onInstalled(String pkg);
    void onUninstalled(String pkg);
}
