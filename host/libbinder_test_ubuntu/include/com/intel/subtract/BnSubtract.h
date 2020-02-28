#ifndef AIDL_GENERATED_COM_INTEL_SUBTRACT_BN_SUBTRACT_H_
#define AIDL_GENERATED_COM_INTEL_SUBTRACT_BN_SUBTRACT_H_

#include <binder/IInterface.h>
#include <com/intel/subtract/ISubtract.h>

namespace com {

namespace intel {

namespace subtract {

class BnSubtract : public ::android::BnInterface<ISubtract> {
public:
::android::status_t onTransact(uint32_t _aidl_code, const ::android::Parcel& _aidl_data, ::android::Parcel* _aidl_reply, uint32_t _aidl_flags = 0) override;
};  // class BnSubtract

}  // namespace subtract

}  // namespace intel

}  // namespace com

#endif  // AIDL_GENERATED_COM_INTEL_SUBTRACT_BN_SUBTRACT_H_
