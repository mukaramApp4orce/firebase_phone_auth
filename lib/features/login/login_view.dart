import '../features.dart';

class Login extends GetView<LogInController> {
  const Login({super.key});

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
                    validator: (val) {
                      return val != null && val.length != 10
                          ? "Invalid Phone"
                          : null;
                    },
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
                      validator: (val) {
                        return val != null && val.length != 6
                            ? "Invalid Otp"
                            : null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                //*
                ElevatedButton(
                  onPressed: () async {
                    controller.sendOrVerifyOtp();
                  },
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
