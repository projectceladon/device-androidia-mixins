package com.intel.remoteime;

import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.inputmethodservice.InputMethodService;
import android.view.inputmethod.CompletionInfo;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputMethodManager;
import android.view.inputmethod.InputMethodSubtype;

public class RemoteKeyboard extends InputMethodService {
    private InputMethodManager mInputMethodManager;
    private String TAG = "RemoteKeyboard";
    private boolean DEBUG = false;
    static private RemoteConnectionThread mConnectionThread = null;

    private void debugLog(String str) {
        if (DEBUG) {
            Log.d(TAG, "onInitializeInterface");
        }
    }
    /**
     * Main initialization of the input method component.  Be sure to call
     * to super class.
     */
    @Override
    public void onCreate() {
        super.onCreate();
        mInputMethodManager = (InputMethodManager) getSystemService(INPUT_METHOD_SERVICE);

        if (mConnectionThread == null) {
            mConnectionThread = new RemoteConnectionThread();
            mConnectionThread.start();
        }
    }

    /**
     * This is the point where you can do all of your UI initialization.  It
     * is called after creation and any configuration change.
     */
    @Override
    public void onInitializeInterface() {
        debugLog("onInitializeInterface");
    }

    /**
     * Called by the framework when your view for creating input needs to
     * be generated.  This will be called the first time your input method
     * is displayed, and every time it needs to be re-created such as due to
     * a configuration change.
     */
    @Override
    public View onCreateInputView() {
        debugLog("onCreateInputView");
        return null;
    }

    /**
     * Called by the framework when your view for showing candidates needs to
     * be generated, like {@link #onCreateInputView}.
     */
    @Override
    public View onCreateCandidatesView() {
        debugLog("onCreateCandidatesView");
        return null;
    }

    /**
     * This is the main point where we do our initialization of the input method
     * to begin operating on an application.  At this point we have been
     * bound to the client, and are now receiving all of the detailed information
     * about the target of our edits.
     */
    @Override
    public void onStartInput(EditorInfo attribute, boolean restarting) {
        debugLog("onStartInput");
        super.onStartInput(attribute, restarting);
        mConnectionThread.setInputConnection(getCurrentInputConnection());
    }

    /**
     * This is called when the user is done editing a field.  We can use
     * this to reset our state.
     */
    @Override
    public void onFinishInput() {
        debugLog("onFinishInput");
        super.onFinishInput();
        mConnectionThread.setInputConnection(null);
    }

    @Override
    public void onStartInputView(EditorInfo attribute, boolean restarting) {
        debugLog("onStartInputView");
        super.onStartInputView(attribute, restarting);
    }

    @Override
    public void onCurrentInputMethodSubtypeChanged(InputMethodSubtype subtype) {
        debugLog("onCurrentInputMethodSubtypeChanged");
    }

    /**
     * Deal with the editor reporting movement of its cursor.
     */
    @Override
    public void onUpdateSelection(int oldSelStart, int oldSelEnd,
                                  int newSelStart, int newSelEnd,
                                  int candidatesStart, int candidatesEnd) {
        debugLog("onUpdateSelection");
        super.onUpdateSelection(oldSelStart, oldSelEnd, newSelStart, newSelEnd,
                candidatesStart, candidatesEnd);

    }

    /**
     * This tells us about completions that the editor has determined based
     * on the current text in it.  We want to use this in fullscreen mode
     * to show the completions ourself, since the editor can not be seen
     * in that situation.
     */
    @Override
    public void onDisplayCompletions(CompletionInfo[] completions) {
        debugLog("onDisplayCompletions");
    }

    /**
     * Use this to monitor key events being delivered to the application.
     * We get first crack at them, and can either resume them or let them
     * continue to the app.
     */
    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        debugLog("onKeyDown: keyCode=" + keyCode + " event=" + event.getScanCode());
        return super.onKeyDown(keyCode, event);
    }

    /**
     * Use this to monitor key events being delivered to the application.
     * We get first crack at them, and can either resume them or let them
     * continue to the app.
     */
    @Override
    public boolean onKeyUp(int keyCode, KeyEvent event) {
        debugLog("onKeyUp: keyCode=" + keyCode + " event=" + event.getScanCode());

        // If we want to do transformations on text being entered with a hard
        // keyboard, we need to process the up events to update the meta key
        // state we are tracking.
        return super.onKeyUp(keyCode, event);
    }

}