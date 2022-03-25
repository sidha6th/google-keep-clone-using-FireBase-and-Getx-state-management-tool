import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_keep_clone/controller/note_controller.dart';
import 'package:google_keep_clone/screens/views/home_screen/home_screen.dart';
import 'package:google_keep_clone/screens/views/login_page/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NoteController controller = Get.put(
      NoteController(),
    );
    return Scaffold(
      body: FutureBuilder(
          future: controller.checkIsSignedOrNot(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              
              if (controller.isSigned == true) {
                return const HomeScreen();
              } else {
                return const LoginScreen();
              }
            } else {
              return const LoginScreen();
            }
          }),
    );
  }
}
