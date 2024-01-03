import '../firebase_phone_auth.dart';

class PhoneAuthService {
  static String _verifyId = '';

  static Future<void> isPhoneVerify({required String phoneNumber}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+92$phoneNumber",
      verificationCompleted: (PhoneAuthCredential credential) async {
        return;
      },
      // timeout: const Duration(seconds: 60),
      verificationFailed: (FirebaseAuthException e) {
        debugPrint("$e");
        switch (e.code) {
          case 'invalid-phone-number':
            throw ('Invalid phone number!');
          case 'invalid-verification-code':
            throw ('The entered OTP is invalid!');
          default:
            throw ('Something went wrong!');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        _verifyId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) async {
        return;
      },
    );
  }

  static Future<bool> verifyOtp({required String verifyCode}) async {
    bool isVerified = false;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verifyId,
        smsCode: verifyCode,
      );

      if (credential.verificationId != null) {
        isVerified = true;
      } else {
        isVerified = false;
      }
    } on FirebaseException catch (e) {
      debugPrint("$e");
    } catch (e) {
      debugPrint("$e");
    }
    return isVerified;
  }
}
