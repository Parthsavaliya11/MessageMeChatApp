import 'package:get/get.dart';
import 'package:messageme/screen/view/loginScreen.dart';
import 'package:messageme/screen/view/signupScreen.dart';
import 'package:messageme/screen/view/spleshScreen.dart';

List<GetPage> routeList =[

  GetPage(name: '/', page:() => const SpleshScreen(),),
  GetPage(name: '/login', page:() => const LoginScreen(),),
  GetPage(name: '/signup', page:() => const SignUpScreen(),),

];