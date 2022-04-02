import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_keep_clone/controller/note_controller.dart';
import 'package:google_keep_clone/model/model.dart';
import 'package:google_keep_clone/screens/views/home_screen/widgets/grid_view_widget.dart';
import 'package:google_keep_clone/screens/views/home_screen/widgets/list_view_widget.dart';

class MainDataWidget extends StatelessWidget {
  const MainDataWidget({
    Key? key,
    this.searchText,
    required this.forSearch,
    required this.size,
  }) : super(key: key);

  final Size size;
  final RxString? searchText;
  final bool forSearch;

  @override
  Widget build(BuildContext context) {
    NoteController controller = Get.find<NoteController>();
    return StreamBuilder<List<NoteModel>>(
      stream: NoteController.getNote(),
      builder: (context, AsyncSnapshot<List<NoteModel>> snapshot) =>
          SliverToBoxAdapter(
        child: forSearch == false
            ? (snapshot.data == null || snapshot.data!.isEmpty)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: size.shortestSide / 1.8,
                      ),
                      Icon(
                        Icons.lightbulb_outline,
                        color: Colors.yellow,
                        size: size.width * 0.3,
                      ),
                      const Text(
                        'Notes you add appear here',
                      ),
                    ],
                  )
                : Obx(
                    () => controller.isGrid.value == true
                        ? GridViewWidget(
                            snapshot: snapshot,
                            forSearch: false,
                            searchText: searchText?.value ?? '',
                          )
                        : ListVewwidget(
                            snapshot: snapshot,
                            forSearch: false,
                            searchText: searchText?.value ?? '',
                          ),
                  )
            : controller.isGrid.value == true
                ? Obx(
                    () => GridViewWidget(
                      snapshot: snapshot,
                      forSearch: true,
                      searchText: searchText!.value,
                    ),
                  )
                : Obx(
                    () => ListVewwidget(
                      snapshot: snapshot,
                      forSearch: true,
                      searchText: searchText!.value,
                    ),
                  ),
      ),
    );
  }
}
