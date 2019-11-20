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

#if UBUNTU_SERVICE
String16 serviceName("ubuntuService");
#else
String16 serviceName("androidService");
#endif

static void client(void) {
  int rv;
  sp<IServiceManager> sm = defaultServiceManager();

  // Attach to service
  sp<IBinder> binder;
  do {
    binder = sm->getService(serviceName);
    if (binder != 0)
      break;
    cout << serviceName << " not published, waiting..." << endl;
    usleep(500000);  // 0.5 s
  } while (true);

  // Perform the IPC operations
  Parcel send, reply;
  int expected;

  // Create parcel to be sent.  Will use the iteration cound
  // and the iteration count + 3 as the two integer values
  // to be sent.
  int val1 = 71;
  int val2 = 11;
  expected = val1 + val2;  // Expect to get the sum back
  send.writeInt32(val1);
  send.writeInt32(val2);

  if ((rv = binder->transact(0x1, send, &reply)) != 0) {
    cerr << "binder->transact failed, rv: " << rv << " errno: " << errno
         << endl;
    exit(10);
  }

  int result = reply.readInt32();
  if (result != expected) {
    cerr << "Unexpected result. " << endl;
    cerr << "  result: " << result << endl;
    cerr << "expected: " << expected << endl;
  } else {
    cout << "pass, result: " << result << " expected: " << expected << endl;
  }
}

int main(int argc, char* argv[]) {
  client();
  exit(0);
}