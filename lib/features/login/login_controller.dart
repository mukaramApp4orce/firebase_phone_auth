import '../features.dart';

class LogInController extends GetxController {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController verifyCode = TextEditingController();
  bool isCodeSend = false;

  final validatePhone = GlobalKey<FormState>();
  final validateOtp = GlobalKey<FormState>();

  void sendOrVerifyOtp() {
    if (validateOtp.currentState!.validate() ||
        validatePhone.currentState!.validate()) {
      isCodeSend = !isCodeSend;
      update();
      debugPrint("$isCodeSend");
      if (isCodeSend) {
        Future.delayed(const Duration(seconds: 60), () {
          isCodeSend = false;
          update();
        });
        sendCode();
      } else {
        verifyOTP();
      }
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

  verifyOTP() async {
    await PhoneAuthService.verifyOtp(
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
