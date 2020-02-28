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
#include <binder/IPCThreadState.h>
#include <binder/IServiceManager.h>
#include <binder/ProcessState.h>
#include <iostream>
#include "com/intel/multiply/BnMultiply.h"

using namespace android;
using namespace com::intel::multiply;
using namespace std;

namespace com
{
namespace intel
{
namespace multiply
{
class MultipyService : public multiply::BnMultiply
{
public:
    android::binder::Status multiply(int32_t a, int32_t b, int32_t *_aidl_return)
    {
        cout << "Incoming two numbers: a = " << a << " b = " << b << endl;
        *_aidl_return = a * b;
        cout << "Return the multiply(" << *_aidl_return << ") to client." << endl;
        return android::binder::Status::ok();
    }
};
} // namespace multiply
} // namespace intel
} // namespace com

int main()
{
    String16 serviceName("multiply");
    int ret;

    sp<MultipyService> ms = new MultipyService();
    if (!ms.get())
    {
        cout << "Error: Fail to new MultipyService." << endl;
        return 0;
    }
    sp<IServiceManager> sm = defaultServiceManager();
    if (!sm.get())
    {
        cout << "Error: Default Service Manager is NULL." << endl;
        return 0;
    }

    ret = sm->addService(serviceName, ms);
    if (ret != 0)
    {
        cout << "Error: Fail to add MultipyService. ret = " << ret << endl;
        return 0;
    }
    else
    {
        cout << "MultipyService is added successfully." << endl;
    }

    sp<ProcessState> proc(ProcessState::self());
    if (!proc.get())
    {
        cout << "Error: Fail to new ProcessState." << endl;
        return 0;
    }
    proc->startThreadPool();
    IPCThreadState::self()->joinThreadPool();
    return 0;
}