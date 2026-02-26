import 'package:get/get.dart';
import 'package:visitor_app/screen/screens/dashboard/dashboard_view.dart';
import 'package:visitor_app/screen/screens/dashboard/master_screen/add_user_view.dart'
    show AddUserView;
import 'package:visitor_app/screen/screens/dashboard/visitor_screen/add_visitor_view.dart';
import 'package:visitor_app/screen/screens/dashboard/visitor_screen/scanner_view.dart'
    show QrScannerPage;
import 'package:visitor_app/screen/screens/dashboard/visitor_screen/user_detail_view.dart';
import 'package:visitor_app/screen/screens/login_screen/login_screen.dart';
import 'package:visitor_app/splash_screen/noInternet_view.dart';
import 'package:visitor_app/splash_screen/splash_view.dart';

import '../screen/screens/dashboard/visitor_screen/Image_view.dart';

mixin Routes {
  static const defaultTransition = Transition.cupertino;

  // static const downToUpTransition = Transition.downToUp;

  // get started
  static const String splashScreen = '/splashScreen';
  static const String loginScreen = '/loginScreen';
  static const String dashboardView = '/DashboardView';
  static const String userDetailView = '/UserDetailView';
  static const String addVisitorView = '/AddVisitorView';
  static const String qrScannerPage = '/QrScannerPage';
  static const String addUserView = '/AddUserView';
  static const String noInternetScreen = '/NoInternetScreen';
  static const String identityImageVIew = '/IdentityImageVIew';

  static List<GetPage<dynamic>> pages = [
    GetPage<dynamic>(
      name: splashScreen,
      page: () => const SplashView(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: loginScreen,
      page: () => LoginScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: dashboardView,
      page: () => const DashboardView(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: userDetailView,
      page: () => UserDetailView(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: addVisitorView,
      page: () => AddVisitorView(),
      transition: defaultTransition,
    ),
    // GetPage<dynamic>(
    //   name: qrScannerPage,
    //   page: () => QrScannerPage(),
    //   transition: defaultTransition,
    // ),
    GetPage<dynamic>(
      name: addUserView,
      page: () => AddUserView(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: noInternetScreen,
      page: () => NoInternetScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: identityImageVIew,
      page: () => IdentityImageVIew(),
      transition: defaultTransition,
    ),
  ];
}
