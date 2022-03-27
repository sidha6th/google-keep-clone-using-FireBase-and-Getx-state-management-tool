import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_keep_clone/controller/note_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NoteController controller = Get.find<NoteController>();
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        91,
        118,
        132,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.lightbulb_outlined,
              color: Colors.yellow,
              size: size.width / 2,
              semanticLabel: 'Keep Notes',
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: Text(
                'Keep Notes\'s',
                style: TextStyle(
                  color: Color.fromARGB(
                    255,
                    234,
                    228,
                    168,
                  ),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FloatingActionButton.extended(
              elevation: 10,
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              onPressed: () async {
                await controller.signIn();
              },
              icon: const FaIcon(
                FontAwesomeIcons.google,
                color: Colors.red,
              ),
              label: const Text(
                'Continue with Google',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
