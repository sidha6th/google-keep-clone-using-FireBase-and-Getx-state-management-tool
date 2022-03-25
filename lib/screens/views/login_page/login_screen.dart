import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_keep_clone/controller/note_controller.dart';
import 'package:google_keep_clone/screens/views/home_screen/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NoteController controller = Get.find<NoteController>();
    //final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        91,
        118,
        132,
      ),
      body: Center(
        child: FloatingActionButton.extended(
          elevation: 10,
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          onPressed: () async {
            await controller.signIn();
            Get.to(
              () => const HomeScreen(),
            );
          },
          icon: const FaIcon(
            FontAwesomeIcons.google,
            color: Colors.red,
          ),
          label: const Text(
            'Continue with Google',
          ),
        ),
      ),
    );
  }
}
