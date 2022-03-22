import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_keep_clone/controller/note_controller.dart';
import 'package:google_keep_clone/screens/views/widgets/common_main_data_widget/main_data_widget.dart';
RxString searchText = ''.obs;
class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    NoteController controller = Get.find<NoteController>();
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                systemNavigationBarColor: Color.fromARGB(0, 0, 0, 0)),
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 218, 216, 216),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            title: TextField(
              onChanged: (String value) {
                searchText.value = value;
              },
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search within "Default"',
              ),
            ),
          ),
          MainDataWidget(
            forSearch: true,
            size: size,
            controller: controller,
            searchText: searchText,
          ),
        ],
      ),
    );
  }
}
