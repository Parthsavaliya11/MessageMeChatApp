import 'package:get/get.dart';
import 'package:messageme/screen/view/search_userpage.dart';
import 'package:messageme/screen/view/chat_page.dart';
import 'package:messageme/screen/view/home_screen.dart';
import 'package:messageme/screen/view/loginScreen.dart';
import 'package:messageme/screen/view/profile_setup.dart';
import 'package:messageme/screen/view/signupScreen.dart';
import 'package:messageme/screen/view/spleshScreen.dart';

List<GetPage> routeList =[

  GetPage(name: '/', page:() => const SpleshScreen(),),
  GetPage(name: '/login', page:() => const LoginScreen(),),
  GetPage(name: '/signup', page:() => const SignUpScreen(),),
  GetPage(name: '/home', page:() => const HomeScreen(),),
  GetPage(name: '/profileset', page:() => const ProfileSetup(),),
  GetPage(name: '/chatpage', page:() => const Chatpage(),),
  GetPage(name: '/searchuser', page:() => const SearchUser(),),

];