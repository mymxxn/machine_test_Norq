import 'package:get/get.dart';
import 'package:machine_test/View/cart_screen.dart';
import 'package:machine_test/View/home_screen.dart';
import 'package:machine_test/View/item_screen.dart';
import 'package:machine_test/View/signIn_screen.dart';
import 'package:machine_test/View/signup_screen.dart';
import 'package:machine_test/View/splash_screen.dart';

class RouteManager {
  static const String splashScreen = '/splash';
  static const String signInScreen = '/signIn';
  static const String signUpScreen = '/signUp';
  static const String homeScreen = '/home';
  static const String cartScreen = '/cart';
  static const String itemViewScreen = '/itemView';
  List<GetPage> routes = [
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: signInScreen,
      page: () => SignInScreen(),
    ),
    GetPage(
      name: signUpScreen,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: homeScreen,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: cartScreen,
      page: () => CartScreen(),
    )
  ];
}
