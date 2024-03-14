import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:machine_test/Controller/signUp_signIn_controller.dart';
import 'package:machine_test/Utils/Constants/app_colors.dart';
import 'package:machine_test/Utils/Routes/route_manager.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final controller = Get.put(SignUpSignInController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.greenPrimary,
                  AppColors.bluePrimary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Column(children: [
              /// Login & Welcome back
              Container(
                height: size.height * 0.25,
                padding: const EdgeInsets.only(left: 10, bottom: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    /// LOGIN TEXT
                    Text('Sign In',
                        style: TextStyle(color: Colors.white, fontSize: 24)),
                  ],
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Stack(children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: ListView(
                        // physics: const NeverScrollableScrollPhysics(),
                        children: [
                          SizedBox(height: size.height * 0.10),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      blurRadius: 20,
                                      spreadRadius: 10,
                                      offset: const Offset(0, 10)),
                                ]),
                            child: TextField(
                              controller: controller.emailTextField.value,
                              style: TextStyle(fontSize: 15),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                border: InputBorder.none,
                                label: Text(
                                  'Email',
                                  style: TextStyle(
                                    color: AppColors.bluePrimary,
                                  ),
                                ),
                                isCollapsed: false,
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      blurRadius: 20,
                                      spreadRadius: 10,
                                      offset: const Offset(0, 10)),
                                ]),
                            child: Obx(
                              () => TextField(
                                controller: controller.passwordTextField.value,
                                obscureText: controller.status.value,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  border: InputBorder.none,
                                  label: Text(
                                    'Password',
                                    style: TextStyle(
                                      color: AppColors.bluePrimary,
                                    ),
                                  ),
                                  isCollapsed: false,
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  suffix: InkWell(
                                    onTap: () {
                                      controller.check();
                                    },
                                    child: Container(
                                      width: 50,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 4),
                                        child: SvgPicture.asset(
                                          controller.icon.value,
                                          height:
                                              controller.status.value == true
                                                  ? 10
                                                  : 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          // InkWell(
                          //   onTap: () {
                          //     controller.rememberPasspasswordTextField();
                          //   },
                          //   splashColor: lightgrey,
                          //   splashFactory: InkRipple.splashFactory,
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Container(
                          //         width: 20,
                          //         height: 20,
                          //         decoration: BoxDecoration(
                          //           shape: BoxShape.circle,
                          //           color: Colors.white,
                          //           border: Border.all(
                          //             color: mutedColor,
                          //             width: 1,
                          //           ),
                          //         ),
                          //         child: Center(
                          //           child: Obx(() => Icon(
                          //                 Icons.check,
                          //                 size: 15,
                          //                 color: controller.isRemember.value
                          //                     ? AppColors.bluePrimary
                          //                     : Colors.transparent,
                          //               )),
                          //         ),
                          //       ),
                          //       SizedBox(
                          //         width: 10,
                          //       ),
                          //       // AutoSizeText(
                          //       //   'Remember me',
                          //       //   minFontSize: 16,
                          //       //   maxFontSize: 20,
                          //       //   style: TextStyle(
                          //       //     fontWeight: FontWeight.w500,
                          //       //     color: mutedColor,
                          //       //   ),
                          //       // ),
                          //     ],
                          //   ),
                          // ),

                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Obx(
                              () => ElevatedButton(
                                onPressed: () => controller.signIn(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.bluePrimary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10), // <-- Radius
                                  ),
                                ),
                                child: controller.isLoading.value == true
                                    ? SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.white),
                                        ),
                                      )
                                    : Text('Sign In',
                                        style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppColors
                              .greenPrimary, // Change the background color here
                          onPrimary: Colors.white, // Change the text color here
                        ),
                        onPressed: () {
                          Get.offNamed(RouteManager.signUpScreen);
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColors.white),
                        ),
                      ),
                    )
                  ]))
            ])));
  }
}
