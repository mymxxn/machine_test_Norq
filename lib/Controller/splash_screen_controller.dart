import 'dart:async';

import 'package:get/get.dart';
import 'package:machine_test/Utils/Routes/route_manager.dart';
import 'package:machine_test/Utils/shared%20preferences/shared_preferences.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    enterApp();
  }

  enterApp() {
    bool isLoggedIn = UserPreferences.getIsLoggedIn() ?? false;
    Future.delayed(Duration(seconds: 3), () {
      if (isLoggedIn) {
        Get.offNamed(RouteManager.homeScreen);
      } else {
        Get.offNamed(RouteManager.signInScreen);
      }
    });
  }
}
