import 'package:flutter/material.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/auth/success_login_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/courses/courses_screen.dart';
import '../screens/courses/course_detail_screen.dart';
import '../screens/courses/course_player_screen.dart';
import '../screens/courses/my_courses_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/messages/messages_screen.dart';
import '../screens/account/account_screen.dart';
import '../screens/subscription/subscription_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String successLogin = '/success-login';
  static const String home = '/home';
  static const String courses = '/courses';
  static const String courseDetail = '/course-detail';
  static const String coursePlayer = '/course-player';
  static const String myCourses = '/my-courses';
  static const String search = '/search';
  static const String messages = '/messages';
  static const String account = '/account';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    signup: (context) => const SignupScreen(),
    successLogin: (context) => const SuccessLoginScreen(),
    home: (context) => const HomeScreen(),
    courses: (context) => const CoursesScreen(),
    courseDetail: (context) => const CourseDetailScreen(),
    coursePlayer: (context) => const CoursePlayerScreen(),
    myCourses: (context) => const MyCoursesScreen(),
    search: (context) => const SearchScreen(),
    messages: (context) => const MessagesScreen(),
    account: (context) => const AccountScreen(),
    '/subscription': (context) => const SubscriptionScreen(),
  };
}
