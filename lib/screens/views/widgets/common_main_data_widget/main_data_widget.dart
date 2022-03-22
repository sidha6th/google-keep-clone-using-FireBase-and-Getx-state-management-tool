import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_keep_clone/controller/note_controller.dart';
import 'package:google_keep_clone/model/model.dart';
import 'package:google_keep_clone/screens/views/home_screen/widgets/grid_view.dart';
import 'package:google_keep_clone/screens/views/home_screen/widgets/list_view.dart';

// ignore: must_be_immutable
class MainDataWidget extends StatelessWidget {
  MainDataWidget({
    Key? key,
    this.searchText,
    this.forSearch = false,
    required this.size,
    required this.controller,
  }) : super(key: key);

  final Size size;
  RxString? searchText;
  final bool forSearch;
  final NoteController controller;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<NoteModel>>(
      stream: NoteController.getNote(),
      builder: (context, AsyncSnapshot<List<NoteModel>> snapshot) {
        return SliverToBoxAdapter(
          // ignore: prefer_is_empty
          child: snapshot.data?.length == 0
              ? SizedBox(
                  height: size.height * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.lightbulb_outline,
                        color: Colors.yellow,
                        size: size.width * 0.3,
                      ),
                      const Text('Notes you add appear here'),
                    ],
                  ),
                )
              : Obx(
                  () {
                   // print('object');
                    return controller.isGrid.value == true
                        ? GridViewWidget(
                            snapshot: snapshot,
                            forSearch: forSearch,
                            searchText: searchText?.value,
                          )
                        : ListVewwidget(
                            snapshot: snapshot,
                            forSearch: forSearch,
                            searchText: searchText?.value,
                          );
                  },
                ),
        );
      },
    );
  }
}
