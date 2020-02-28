#ifndef AIDL_GENERATED_COM_INTEL_MULTIPLY_BN_MULTIPLY_H_
#define AIDL_GENERATED_COM_INTEL_MULTIPLY_BN_MULTIPLY_H_

#include <binder/IInterface.h>
#include <com/intel/multiply/IMultiply.h>

namespace com {

namespace intel {

namespace multiply {

class BnMultiply : public ::android::BnInterface<IMultiply> {
public:
::android::status_t onTransact(uint32_t _aidl_code, const ::android::Parcel& _aidl_data, ::android::Parcel* _aidl_reply, uint32_t _aidl_flags = 0) override;
};  // class BnMultiply

}  // namespace multiply

}  // namespace intel

}  // namespace com

#endif  // AIDL_GENERATED_COM_INTEL_MULTIPLY_BN_MULTIPLY_H_
