import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test/Utils/Constants/asset_paths.dart';
import 'package:machine_test/Utils/Constants/snackbar_services.dart';
import 'package:machine_test/Utils/Routes/route_manager.dart';
import 'package:machine_test/Utils/shared%20preferences/shared_preferences.dart';

class SignUpSignInController extends GetxController {
  var emailTextField = TextEditingController().obs;
  var passwordTextField = TextEditingController().obs;
  var isLoading = false.obs;
  var status = true.obs;
  var icon = AssetIconPath.eye_close.obs;
  signUp() async {
    if (isValidEmail(emailTextField.value.text) == false) {
      SnackBarServices.errorSnackBar('Email Invalid');
      return;
    }
    if (passwordTextField.value.text.length < 6) {
      SnackBarServices.errorSnackBar('Password min length should be 6');
      return;
    }
    isLoading.value = true;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailTextField.value.text,
              password: passwordTextField.value.text);
      SnackBarServices.successSnackbar("User Created Successfully");
      clearData();
      Get.offNamed(RouteManager.signInScreen);
      isLoading.value = false;
    } catch (e) {
      print('Sign up failed: $e');
      isLoading.value = false;
      SnackBarServices.errorSnackBar("Sign up failed: $e");
      // Handle sign-up failure
    }
    update();
  }

  signIn() async {
    if (isValidEmail(emailTextField.value.text) == false) {
      SnackBarServices.errorSnackBar('Email Invalid');
      return;
    }
    if (passwordTextField.value.text.length < 6) {
      SnackBarServices.errorSnackBar('Password min length should be 6');
      return;
    }
    isLoading.value = true;
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextField.value.text,
        password: passwordTextField.value.text,
      );
      UserPreferences.setIsLoggedIn(true);
      isLoading.value = false;
      SnackBarServices.successSnackbar("User Signed In Successfully");
      clearData();
      Get.offNamed(RouteManager.homeScreen);
    } catch (e) {
      print('Sign in failed: $e');
      isLoading.value = false;
      SnackBarServices.errorSnackBar("Sign up failed: $e");
    }
  }

  clearData() {
    emailTextField.value.clear();
    passwordTextField.value.clear();
    status.value = true;
    icon.value = AssetIconPath.eye_close;
    isLoading.value = false;
    update();
  }

  check() {
    if (status.value == true) {
      status.value = false;
      icon.value = AssetIconPath.eye_open;
    } else {
      status.value = true;
      icon.value = AssetIconPath.eye_close;
    }
  }

  bool isValidEmail(String email) {
    final RegExp regex =
        RegExp(r'^[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,7}$');
    return regex.hasMatch(email);
  }
}
