#ifndef AIDL_GENERATED_COM_INTEL_MULTIPLY_I_MULTIPLY_H_
#define AIDL_GENERATED_COM_INTEL_MULTIPLY_I_MULTIPLY_H_

#include <binder/IBinder.h>
#include <binder/IInterface.h>
#include <binder/Status.h>
#include <cstdint>
#include <utils/StrongPointer.h>

namespace com {

namespace intel {

namespace multiply {

class IMultiply : public ::android::IInterface {
public:
DECLARE_META_INTERFACE(Multiply)
virtual ::android::binder::Status multiply(int32_t a, int32_t b, int32_t* _aidl_return) = 0;
enum Call {
  MULTIPLY = ::android::IBinder::FIRST_CALL_TRANSACTION + 0,
};
};  // class IMultiply

}  // namespace multiply

}  // namespace intel

}  // namespace com

#endif  // AIDL_GENERATED_COM_INTEL_MULTIPLY_I_MULTIPLY_H_
