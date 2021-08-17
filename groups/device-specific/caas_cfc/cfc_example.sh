#!/bin/bash

function cfc_example_home(){
    #one simple example for cfc client
    #display0 is Android home
    ./LG_B1_Client -M yes -R 16666 -f /dev/shm/looking-glass0 -a true -t "Android Home"
}

function cfc_example_setting(){
    #one simple example for cfc client
    #display1 is Setting
    adb connect localhost
    adb -s localhost:5555 shell am start -n com.android.settings/com.android.settings.homepage.SettingsHomepageActivity --display 1
    ./LG_B1_Client -M yes -R 16666 -f /dev/shm/looking-glass1 -a true -t "Android Setting"
}

function cfc_example_documents(){
    #one simple example for cfc client
    #display2 is Documents
    adb connect localhost
    adb -s localhost:5555 shell am start -n com.android.documentsui/com.android.documentsui.files.FilesActivity --display 2
    ./LG_B1_Client -M yes -R 16666 -f /dev/shm/looking-glass2 -a true -t "Android Documents"
}

function cfc_example_webview(){
    #one simple example for cfc client
    #display3 is Webview
    adb connect localhost
    adb -s localhost:5555 shell am start -n org.chromium.webview_shell/.WebViewBrowserActivity --display 3
    ./LG_B1_Client -M yes -R 16666 -f /dev/shm/looking-glass3 -a true -t "Android WebView"
}

echo "cfc simple example start"

cfc_example_home & sleep 3
cfc_example_setting & sleep 3
cfc_example_documents & sleep 3
cfc_example_webview & sleep 3

echo "one simple example for cfc client"
echo "display0 is Android home"
echo "display1 is Setting"
echo "display2 is Documents"
echo "display3 is Webview"
echo "Known issues: sometimes cfc window crash due to spice issue"
