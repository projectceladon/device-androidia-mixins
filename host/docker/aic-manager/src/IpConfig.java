/*
 * Copyright (C) 2014 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

public class IpConfig {
    /* IP and proxy configuration keys */
    private static final String ID_KEY = "id";
    private static final String IP_ASSIGNMENT_KEY = "ipAssignment";
    private static final String LINK_ADDRESS_KEY = "linkAddress";
    private static final String GATEWAY_KEY = "gateway";
    private static final String DNS_KEY = "dns";
    private static final String PROXY_SETTINGS_KEY = "proxySettings";
    private static final String PROXY_HOST_KEY = "proxyHost";
    private static final String PROXY_PORT_KEY = "proxyPort";
    private static final String EXCLUSION_LIST_KEY = "exclusionList";
    private static final String EOS = "eos";

    protected static final int IPCONFIG_FILE_VERSION = 3;

    private static void writeConfig(DataOutputStream out, int index) throws IOException {
        out.writeInt(IPCONFIG_FILE_VERSION);
        out.writeUTF(IP_ASSIGNMENT_KEY);
        out.writeUTF("STATIC");

        String ip = "172.100." + ((index + 2) / 256) + "." + ((index + 2) % 256);
        out.writeUTF(LINK_ADDRESS_KEY);
        out.writeUTF(ip);
        out.writeInt(16);

        out.writeUTF(GATEWAY_KEY);
        out.writeInt(0);  // Default route.
        out.writeInt(1);  // Have a gateway.
        out.writeUTF("172.100.0.1");

        out.writeUTF(DNS_KEY);
        out.writeUTF("172.100.0.1");

        out.writeUTF(ID_KEY);
        out.writeUTF("eth0");
        out.writeUTF(EOS);
    }

    public static void main(String[] args) {
        for (int i = 0; i < 150; i++) {
            String file = "ipconfig" + i;
            try {
                DataOutputStream out = new DataOutputStream(new FileOutputStream(file));
                writeConfig(out, i);
                out.close();
            } catch (FileNotFoundException e) {
            } catch (IOException e) {
            }
        }
    }
}
