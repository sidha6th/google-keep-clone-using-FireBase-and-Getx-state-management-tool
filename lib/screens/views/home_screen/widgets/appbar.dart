import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_keep_clone/constants/colors.dart';
import 'package:google_keep_clone/controller/note_controller.dart';
import 'package:google_keep_clone/screens/views/search_screen/search_screen.dart';

class Appbarwidget extends StatelessWidget {
  const Appbarwidget({required this.scaffoldKey, Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final NoteController controller = Get.find<NoteController>();
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(
        top: 30,
      ),
      child: Container(
        key: key,
        width: size.width * 0.9,
        height: size.height * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: darkWhite,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: grey,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    NoteController.searchText.value = '';
                    Get.to(() => const SearchScreen(
                          forsearch: true,
                        ));
                  },
                  child: const Text(
                    'search your notes',
                  ),
                ),
              ),
              Obx(() {
                return IconButton(
                  onPressed: () {
                    controller.isGrid.value == true
                        ? controller.isGrid.value = false
                        : controller.isGrid.value = true;
                  },
                  icon: Icon(
                    controller.isGrid.value == false
                        ? Icons.grid_view_outlined
                        : Icons.view_agenda_outlined,
                    color: grey,
                  ),
                );
              }),
              InkWell(
                onTap: () {
                  controller.signOut();
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    NoteController.userPhoto,
                  ),
                  radius: size.shortestSide * 0.04,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
