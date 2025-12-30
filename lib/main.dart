import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visitor_app/visitor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // LocalStorageServices.initializeSharedPreferences();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.grey,
      ),
    );
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return const VisitorApp();
  }
}