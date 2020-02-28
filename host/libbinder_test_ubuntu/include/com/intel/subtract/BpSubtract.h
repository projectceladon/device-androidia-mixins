#ifndef AIDL_GENERATED_COM_INTEL_SUBTRACT_BP_SUBTRACT_H_
#define AIDL_GENERATED_COM_INTEL_SUBTRACT_BP_SUBTRACT_H_

#include <binder/IBinder.h>
#include <binder/IInterface.h>
#include <utils/Errors.h>
#include <com/intel/subtract/ISubtract.h>

namespace com {

namespace intel {

namespace subtract {

class BpSubtract : public ::android::BpInterface<ISubtract> {
public:
explicit BpSubtract(const ::android::sp<::android::IBinder>& _aidl_impl);
virtual ~BpSubtract() = default;
::android::binder::Status subtract(int32_t a, int32_t b, int32_t* _aidl_return) override;
};  // class BpSubtract

}  // namespace subtract

}  // namespace intel

}  // namespace com

#endif  // AIDL_GENERATED_COM_INTEL_SUBTRACT_BP_SUBTRACT_H_
