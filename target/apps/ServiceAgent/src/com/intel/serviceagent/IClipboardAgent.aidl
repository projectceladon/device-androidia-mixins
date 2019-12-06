// IClipboardAgent.aidl
package com.intel.serviceagent;

// Declare any non-default types here with import statements
import com.intel.serviceagent.IClipboardListener;

interface IClipboardAgent {
    boolean hasText();
    String getText();
    void setText(String text);

    void addClipboardListener(IClipboardListener listener);
    void removeClipboardListener(IClipboardListener listener);
}
