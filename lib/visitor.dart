import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:visitor_app/utils/app_binding.dart';
import 'package:visitor_app/utils/app_string.dart';
import 'package:visitor_app/utils/navigation.dart';

class VisitorApp extends StatelessWidget {
  const VisitorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppString.appName,
      getPages: Routes.pages,
      theme: ThemeData(splashColor: Colors.transparent),
      initialRoute: Routes.splashScreen,
      initialBinding: AppBidding(),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: InkWell(
              radius: 10,
              onTap: () {
                hideKeyboard(context);
              },
              child: child,
            ),
          ),
        );
      },
    );
  }

  void hideKeyboard(BuildContext context) {
    var currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}

class MyBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
