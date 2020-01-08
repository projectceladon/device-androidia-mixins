// IInputMethodManagerAgent.aidl
package com.intel.serviceagent;

// Declare any non-default types here with import statements

interface IInputMethodManagerAgent {
    List<String> getInputMethodList();
    List<String> getEnabledInputMethodList();
}
