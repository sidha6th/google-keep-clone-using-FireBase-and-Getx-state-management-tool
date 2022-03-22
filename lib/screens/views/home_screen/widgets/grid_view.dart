import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_keep_clone/controller/note_controller.dart';
import 'package:google_keep_clone/model/model.dart';
import 'package:google_keep_clone/screens/views/home_screen/widgets/data_card.dart';
List<NoteModel> searchlist = [];

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({
    required this.snapshot,
    this.forSearch = false,
    this.searchText,
    Key? key,
  }) : super(key: key);
  final AsyncSnapshot<List<NoteModel>> snapshot;
  final String? searchText;
  final bool forSearch;
  @override
  Widget build(BuildContext context) {
    final NoteController controller = Get.find<NoteController>();
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.builder(
        controller: controller.scrollController,
        itemCount:snapshot.data?.length ?? 0,
        shrinkWrap: true,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
            if (forSearch == true) {
              snapshot.data![index].title
                        .toString()
                        .contains(searchText.toString())
                    ? searchlist.add(snapshot.data![index])
                    : null;
              return DataCard(
                size: size,
                isgrid: false,
                data: searchlist[index],
              );
            } else {
              return DataCard(
                data: snapshot.data?[index],
                size: size,
                isgrid: true,
              );
            }
        },
      ),
    );
  }
}
