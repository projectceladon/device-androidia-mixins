#ifndef AIDL_GENERATED_COM_INTEL_SUBTRACT_I_SUBTRACT_H_
#define AIDL_GENERATED_COM_INTEL_SUBTRACT_I_SUBTRACT_H_

#include <binder/IBinder.h>
#include <binder/IInterface.h>
#include <binder/Status.h>
#include <cstdint>
#include <utils/StrongPointer.h>

namespace com {

namespace intel {

namespace subtract {

class ISubtract : public ::android::IInterface {
public:
DECLARE_META_INTERFACE(Subtract)
virtual ::android::binder::Status subtract(int32_t a, int32_t b, int32_t* _aidl_return) = 0;
enum Call {
  SUBTRACT = ::android::IBinder::FIRST_CALL_TRANSACTION + 0,
};
};  // class ISubtract

}  // namespace subtract

}  // namespace intel

}  // namespace com

#endif  // AIDL_GENERATED_COM_INTEL_SUBTRACT_I_SUBTRACT_H_
