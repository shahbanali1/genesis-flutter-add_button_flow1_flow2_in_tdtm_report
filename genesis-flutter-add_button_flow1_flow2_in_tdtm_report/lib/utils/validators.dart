import 'dart:async';

class Validators {
  final validateMobile = StreamTransformer<String, String>.fromHandlers(
      handleData: (mobileNo, sink) {
    if (mobileNo.length > 9) {
      sink.add(mobileNo);
    } else {
      sink.addError('Enter a valid Mobile No');
    }
  });

  final validateOTP =
      StreamTransformer<String, String>.fromHandlers(handleData: (otp, sink) {
    if (otp.length > 5) {
      sink.add(otp);
    } else {
      sink.addError('Enter a valid OTP');
    }
  });
}
