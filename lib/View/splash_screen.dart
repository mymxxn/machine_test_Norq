import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test/Controller/splash_screen_controller.dart';
import 'package:machine_test/Utils/Constants/app_colors.dart';
import 'package:machine_test/Utils/Constants/asset_paths.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final controller = Get.put(SplashScreenController());
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.greenPrimary, AppColors.bluePrimary])),
      child: Image.asset(
        AssetImagePath.logo,
        scale: 7,
        color: AppColors.lightgrey,
      ),
    );
  }
}
