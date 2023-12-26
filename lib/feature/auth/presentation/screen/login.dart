import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/resource/custom_snackbar.dart';
import '../../../../core/resource/data_state.dart';
import '../controller/register_controller.dart';
import '../widget/confirm_button.dart';
import '../widget/input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    return Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        body: SafeArea(
          child: Stack(children: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: width / 3,
                height: height,
                color: CustomColors.foregroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Images.login,
                      height: height/2,
                    ),
                    const Text(
                      'Turkeysh Smart Home',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoginEditText(
                        fieldController: _controller.loginUsername,
                        hint: 'نام کاربری',
                        icon: const Icon(Icons.person),
                        type: TextInputType.name,
                        isPass: false,
                        showPass: false),
                    const SizedBox(
                      height: 4,
                    ),
                    LoginEditText(
                        fieldController: _controller.loginPassword,
                        hint: 'رمز عبور',
                        icon: const Icon(Icons.lock),
                        type: TextInputType.name,
                        isPass: true,
                        showPass: true),
                    const SizedBox(
                      height: 8,
                    ),
                    Obx(() {
                      return SizedBox(
                        child: _controller.isLoading.value
                            ? const CircularProgressIndicator()
                            : LoginButton(onClick: () {
                                _controller.loginUser().then((value) {
                                  if (value is DataSuccess) {
                                    customSuccessSnackBar('خوش آمدید');
                                  } else {
                                    customErrorSnackBar(
                                        value.error ?? 'خطا در ارسال اطلاعات');
                                  }
                                });
                              }),
                      );
                    }),
                  ],
                ),
              ),
            )
          ]),
        ));
  }
}
