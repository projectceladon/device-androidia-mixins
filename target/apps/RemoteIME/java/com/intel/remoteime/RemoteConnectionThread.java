package com.intel.remoteime;

import android.net.LocalServerSocket;
import android.net.LocalSocket;
import android.net.LocalSocketAddress;
import android.util.Log;
import android.view.inputmethod.InputConnection;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Arrays;

public class RemoteConnectionThread extends Thread {
    private String TAG = "RemoteKeyboard";
    private Object syncObject = new Object();
    private InputConnection mInputConnection = null;

    private LocalSocketAddress mImeAddr = null;
    private LocalSocket mSocket = null;
    private LocalSocket mRemoteSocket = null;
    private LocalServerSocket mServerSocket = null;
    private InputStream mInputStream = null;
    private OutputStream mOutputStream = null;

    public RemoteConnectionThread() {
        mSocket = new LocalSocket();
        mImeAddr = new LocalSocketAddress("/ipc/ime", LocalSocketAddress.Namespace.FILESYSTEM);

        try {
            mSocket.bind(mImeAddr);
            Runtime.getRuntime().exec("chmod a+rw " + "/ipc/ime");
            mServerSocket = new LocalServerSocket(mSocket.getFileDescriptor());
        } catch (IOException e) {
            Log.e(TAG, "Failed to open socket /ipc/ime " + e.toString());
        }
    }

    public void setInputConnection(InputConnection connection) {
        synchronized (syncObject) {
            mInputConnection = connection;
        }
    }

    @Override
    public void run() {
        while (true) {
            try {
                Log.d(TAG, "Wait connection...");
                mRemoteSocket = mServerSocket.accept();
                Log.d(TAG, "Connected");
            } catch (Exception e1) {
                Log.e(TAG, "Failed to accept connection " + e1.toString());
            }
            while (true) {
                try {
                    byte[] buffer = new byte[1024];
                    mInputStream = mRemoteSocket.getInputStream();
                    int count = mInputStream.read(buffer);
                    String msg = new String(Arrays.copyOfRange(buffer, 0, count));

                    synchronized (syncObject) {
                        if (mInputConnection != null) {
                            mInputConnection.commitText(msg, msg.length());
                        }
                    }
                } catch (Exception e) {
                    Log.e(TAG, "IME connection error:" + e.toString());
                    break;
                }
            }
        }
    }
}
