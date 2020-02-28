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

#include <binder/IServiceManager.h>
#include <iostream>
#include <com/intel/sum/ISum.h>

using namespace android;
using namespace com::intel::sum;
using namespace std;

int main()
{
    String16 serviceName("sum");
    String8 serviceNameString8(serviceName);
    android::binder::Status ret;
    int retry_count = 360;
    int a = 23;
    int b = 31;
    int expected_value = 0;
    int actual_value = 0;

    sp<IServiceManager> sm = defaultServiceManager();
    if (!sm.get())
    {
        cout << "Error: Default Service Manager is NULL." << endl;
        return 0;
    }

    sp<IBinder> binder;
    do
    {
        binder = sm->getService(serviceName);
        if (binder.get())
        {
            cout << serviceNameString8.string() << " service is obtained" << endl;
            break;
        }
        else if (retry_count > 0)
        {
            cout << "Fail to obtain " << serviceNameString8.string() << " service. "
                 << serviceNameString8.string() << " maybe not published. Or error happen. "
                 << "Sleep 0.5s and try to fetch again(" << 360 - retry_count << ")." << endl;
            usleep(500000); // 0.5 s
        }
        else
        {
            cout << "Error: Fail to obtain " << serviceNameString8.string() << " service." << endl;
            return 0;
        }

    } while (retry_count-- > 0);

    sp<ISum> ss = interface_cast<ISum>(binder);
    if (!ss.get())
    {
        cout << "Error: Fail to cast interface." << endl;
        return 0;
    }

    cout << "This test is used to sum of two numbers: " << endl;
    cout << "Input a:";
    cin >> a;
    cout << "Input b:";
    cin >> b;

    expected_value = a + b;
    cout << "a = " << a << " b = " << b << " expected_value = " << expected_value << endl;

    ret = ss->sum(a, b, &actual_value);
    if (!ret.isOk())
    {
        cout << "Error: Fail to call service's function." << endl;
        return 0;
    }
    else
    {
        if (actual_value == expected_value)
        {
            cout << "Pass. actual_value(" << actual_value << ") equals expected_value." << endl;
        }
        else
        {
            cout << "Fail. actual_value(" << actual_value << ") equals expected_value." << endl;
        }
    }
}
