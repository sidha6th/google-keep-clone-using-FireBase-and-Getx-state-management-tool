 import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_keep_clone/screens/views/home_screen/home_screen.dart';
import 'package:google_keep_clone/screens/views/splash_screen/splash_screen.dart';
 Future main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();  
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
