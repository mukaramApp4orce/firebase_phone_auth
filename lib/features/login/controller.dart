import '../../firebase_phone_auth.dart';

class LogInController extends GetxController {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController verifyCode = TextEditingController();
  bool isCodeSend = false;

  final validatePhone = GlobalKey<FormState>();
  final validateOtp = GlobalKey<FormState>();

  void sendOrVerifyOtp() {
    isCodeSend = !isCodeSend;
    update();
    debugPrint("Is Code is Send $isCodeSend");
    if (isCodeSend) {
      Future.delayed(const Duration(seconds: 60), () {
        isCodeSend = false;
        update();
      });
      sendCode();
    } else {
      verifyOTP();
    }

    update();
  }

  sendCode() async {
    await PhoneAuthService.isPhoneVerify(
      phoneNumber: phoneNumber.text,
    ).then((isVerify) {
      showSnackBar(message: "Code send");
    }).onError((error, stackTrace) {
      showSnackBar(message: error.toString());
    });
  }

  verifyOTP() {
    PhoneAuthService.verifyOtp(
      verifyCode: verifyCode.text,
    ).then((isVerify) {
      if (isVerify) {
        showSnackBar(message: "Verified");
      } else {
        showSnackBar(message: "Unverified");
      }
    }).onError((error, stackTrace) {
      showSnackBar(message: error.toString());
    });
  }

  showSnackBar({required String message}) {
    return ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
