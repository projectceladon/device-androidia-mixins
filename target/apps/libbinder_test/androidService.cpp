/*
 * Copyright (C) 2010 The Android Open Source Project
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
 *
 */

/*
 * Binder add integers benchmark (Using google-benchmark library)
 *
 */

#include <cerrno>
#include <grp.h>
#include <iostream>
#include <iomanip>
#include <libgen.h>
#include <time.h>
#include <unistd.h>

#include <sys/syscall.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/wait.h>

#include <binder/IPCThreadState.h>
#include <binder/ProcessState.h>
#include <binder/IServiceManager.h>

#include <utils/Log.h>
#include <testUtil.h>

using namespace android;
using namespace std;

String16 serviceName("androidService");

class androidService : public BBinder
{
  public:
    androidService();
    virtual ~androidService() {}

    enum command {
        C2S = 0x1,
    };

    virtual status_t onTransact(uint32_t code,
                                const Parcel& data, Parcel* reply,
                                uint32_t flags = 0);

  private:
    int cnt;
};

// File scope function prototypes
static bool server(void);
static ostream &operator<<(ostream &stream, const String16& str);

static bool server(void)
{
    int rv;

    // Add the service
    sp<ProcessState> proc(ProcessState::self());
    sp<IServiceManager> sm = defaultServiceManager();
    if ((rv = sm->addService(serviceName,
        new androidService())) != 0) {
        cerr << "androidService " << serviceName << " failed, rv: " << rv
            << " errno: " << errno << endl;
        return false;
    }
    cerr << "Start " << serviceName << " success." << endl;

    // Start threads to handle server work
    proc->startThreadPool();
    IPCThreadState::self()->joinThreadPool();
    return true;
}

androidService::androidService(): cnt(0) {
}

// Server function that handles parcels received from the client
status_t androidService::onTransact(uint32_t code, const Parcel &data,
                                    Parcel* reply, uint32_t /* flags */) {
    int val1, val2;
    status_t rv(0);

    // Perform the requested operation
    switch (code) {
    case C2S:
        val1 = data.readInt32();
        val2 = data.readInt32();
        reply->writeInt32(val1 + val2);
        cnt++;
        cerr << "androidService C2S " << cnt << ": " << val1 << " + " << val2 << endl;
        break;

    default:
      cerr << "server onTransact unknown code, code: " << code << endl;
      exit(21);
    }

    return rv;
}

static ostream &operator<<(ostream &stream, const String16& str)
{
    for (unsigned int n1 = 0; n1 < str.size(); n1++) {
        if ((str[n1] > 0x20) && (str[n1] < 0x80)) {
            stream << (char) str[n1];
        } else {
            stream << '~';
        }
    }

    return stream;
}

int main()
{
    if (server()) {
        cerr << "Sucess to start service" << endl;
    }
    exit(0);
}
