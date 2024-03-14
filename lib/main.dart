import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test/Services/DB%20helper/db_helper.dart';
import 'package:machine_test/Utils/Routes/route_manager.dart';
import 'package:machine_test/Utils/shared%20preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyCuTRNZ5JTiAINVeP7z1cTLrNwZ1Ykv9U0',
          appId: '1:150433762164:android:07474f7a981198952c3a21',
          messagingSenderId: '150433762164',
          projectId: 'machinetestnorq'));
  await DBHelper().database;
  await UserPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Machine test',
      initialRoute: RouteManager.splashScreen,
      getPages: RouteManager().routes,
    );
  }
}
