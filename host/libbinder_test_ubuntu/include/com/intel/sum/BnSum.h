#ifndef AIDL_GENERATED_COM_INTEL_SUM_BN_SUM_H_
#define AIDL_GENERATED_COM_INTEL_SUM_BN_SUM_H_

#include <binder/IInterface.h>
#include <com/intel/sum/ISum.h>

namespace com {

namespace intel {

namespace sum {

class BnSum : public ::android::BnInterface<ISum> {
public:
::android::status_t onTransact(uint32_t _aidl_code, const ::android::Parcel& _aidl_data, ::android::Parcel* _aidl_reply, uint32_t _aidl_flags = 0) override;
};  // class BnSum

}  // namespace sum

}  // namespace intel

}  // namespace com

#endif  // AIDL_GENERATED_COM_INTEL_SUM_BN_SUM_H_
