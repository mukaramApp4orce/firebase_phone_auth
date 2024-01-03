import '../../firebase_phone_auth.dart';

class LoginView extends GetView<LogInController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: GetBuilder<LogInController>(
          builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //* Phone Num Field
                Form(
                  key: controller.validatePhone,
                  child: TextFormField(
                    controller: controller.phoneNumber,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "+923001234567",
                      prefixText: "+92",
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                //* OTP Field
                Visibility(
                  visible: controller.isCodeSend,
                  child: Form(
                    key: controller.validateOtp,
                    child: TextFormField(
                      controller: controller.verifyCode,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "OTP",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                //* send OTP
                ElevatedButton(
                  onPressed: controller.sendOrVerifyOtp,
                  child: Text(controller.isCodeSend ? "Verify" : "Send Code"),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
