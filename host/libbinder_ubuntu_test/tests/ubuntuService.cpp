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

#include <binder/IPCThreadState.h>
#include <binder/IServiceManager.h>
#include <binder/ProcessState.h>
#include <grp.h>
#include <libgen.h>
#include <sys/syscall.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>
#include <utils/Log.h>
#include <cerrno>
#include <iomanip>
#include <iostream>

using namespace android;
using namespace std;

String16 serviceName("ubuntuService");

class ubuntuService : public BBinder {
 public:
  ubuntuService();
  virtual ~ubuntuService() {}

  enum command {
    ADD_INTS = 0x120,
  };

  virtual status_t onTransact(uint32_t code,
                              const Parcel& data,
                              Parcel* reply,
                              uint32_t flags = 0);

 private:
  int cnt;
};

static bool server(void) {
  int rv;

  // Add the service
  sp<ProcessState> proc(ProcessState::self());
  sp<IServiceManager> sm = defaultServiceManager();
  if ((rv = sm->addService(serviceName, new ubuntuService())) != 0) {
    cerr << "ubuntuService " << serviceName << " failed, rv: " << rv
         << " errno: " << errno << endl;
    return false;
  } else {
    cerr << "ubuntuService " << serviceName << " sucessful, rv: " << rv << endl;
  }

  // Start threads to handle server work
  proc->startThreadPool();
  IPCThreadState::self()->joinThreadPool();
  return true;
}

ubuntuService::ubuntuService() : cnt(0) {}

// Server function that handles parcels received from the client
status_t ubuntuService::onTransact(uint32_t code,
                                   const Parcel& data,
                                   Parcel* reply,
                                   uint32_t /* flags */) {
  int val1, val2;
  status_t rv(0);
  int cpu;

  // Perform the requested operation
  switch (code) {
    case ADD_INTS:
      val1 = data.readInt32();
      val2 = data.readInt32();
      reply->writeInt32(val1 + val2);
      cnt++;
      cerr << "ADD_INTS " << cnt << ": " << val1 << " + " << val2 << endl;
      break;

    default:
      cerr << "server onTransact unknown code, code: " << code << endl;
      exit(21);
  }

  return rv;
}

int main(int argc, char* argv[]) {
  if (server()) {
    cerr << "Sucess to start service" << endl;
  }
  exit(0);
}