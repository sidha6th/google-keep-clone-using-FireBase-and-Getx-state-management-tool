import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_keep_clone/controller/note_controller.dart';
import 'package:google_keep_clone/screens/views/add_or_edit_screen/add_or_edit_screen.dart';
import 'package:google_keep_clone/screens/views/home_screen/widgets/appbar.dart';
import 'package:google_keep_clone/screens/views/widgets/common_main_data_widget/main_data_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NoteController controller = Get.put(
      NoteController(),
    );
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        //shrinkWrap: true,
        slivers: <Widget>[
          const SliverAppBar(
            floating: true,
            elevation: 0,
            foregroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            flexibleSpace: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Appbarwidget(),
            ),
          ),
          MainDataWidget(size: size, controller: controller),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(
          0xFFCECECE,
        ),
        onPressed: () {
          Get.to(
            const AddOrEditScreen(),
          );
        },
        child: const Icon(Icons.add, color: Colors.black,size: 30,),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              15.0,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(
                -0,
                -1,
              ),
              color: Color.fromARGB(255, 235, 234, 234),
              blurRadius: 2,
              blurStyle: BlurStyle.inner,
              spreadRadius: 1,
            ),
          ],
        ),
        child: BottomAppBar(
          elevation: 0,
          color: const Color(
            0xFFCECECE,
          ),
          shape: const AutomaticNotchedShape(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(
                  0,
                ),
              ),
            ),
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  22,
                ),
              ),
            ),
          ),
          notchMargin: 5,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.check_box_outlined,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.brush_rounded,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.mic_none,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.image_outlined,
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
