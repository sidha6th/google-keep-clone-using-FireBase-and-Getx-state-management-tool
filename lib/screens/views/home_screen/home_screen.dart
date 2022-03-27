import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_keep_clone/controller/note_controller.dart';
import 'package:google_keep_clone/screens/views/add_or_edit_screen/add_or_edit_screen.dart';
import 'package:google_keep_clone/screens/views/home_screen/widgets/appbar.dart';
import 'package:google_keep_clone/screens/views/widgets/common_main_data_widget/main_data_widget.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    // NoteController controller = Get.find<NoteController>();
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(size: size),
      backgroundColor: Colors.white,
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            floating: true,
            elevation: 0,
            foregroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            flexibleSpace: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Appbarwidget(
                scaffoldKey: _scaffoldKey,
              ),
            ),
          ),
          MainDataWidget(
            forSearch: false,
            size: size,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(
          0xFFCECECE,
        ),
        onPressed: () {
          Get.to(
            () => const AddOrEditScreen(),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
          size: 30,
        ),
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
              color: Color.fromARGB(
                255,
                235,
                234,
                234,
              ),
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

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    required this.size,
    Key? key,
  }) : super(key: key);
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Image.network(
              'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-google-sva-scholarship-20.png',
              width: size.shortestSide / 3,
              height: size.shortestSide / 3,
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: const <Widget>[
              DraweListItem(
                icon: Icons.lightbulb_outline,
                label: 'Notes',
              ),
              DraweListItem(
                icon: Icons.notifications_none,
                label: 'Reminders',
              ),
              DraweListItem(
                icon: Icons.add,
                label: 'Create new label',
              ),
              DraweListItem(
                icon: Icons.archive_outlined,
                label: 'Archive',
              ),
              DraweListItem(
                icon: Icons.delete_outline,
                label: 'Deleted',
              ),
              DraweListItem(
                icon: Icons.settings_outlined,
                label: 'Setings',
              ),
              DraweListItem(
                icon: Icons.help_outline,
                label: 'Help & feedback',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DraweListItem extends StatelessWidget {
  const DraweListItem({
    required this.icon,
    required this.label,
    Key? key,
  }) : super(key: key);
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                icon,
                color: Colors.black,
                size: 25,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20,),
      ],
    );
  }
}
