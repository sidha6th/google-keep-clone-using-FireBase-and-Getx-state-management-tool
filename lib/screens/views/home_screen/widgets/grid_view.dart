import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_keep_clone/constants/colors.dart';
import 'package:google_keep_clone/controller/note_controller.dart';
import 'package:google_keep_clone/model/model.dart';
import 'package:google_keep_clone/screens/views/home_screen/widgets/data_card.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({
    required this.snapshot,
    required this.forSearch ,
    this.searchText = '',
    Key? key,
  }) : super(key: key);
  final AsyncSnapshot<List<NoteModel>> snapshot;
  final String searchText;
  final bool forSearch;
  @override
  Widget build(BuildContext context) {
    final NoteController controller = Get.find<NoteController>();
    controller.getSearchData(snapshot);
    final Size size = MediaQuery.of(context).size;
    return controller.searchlist.isEmpty
        ? SizedBox(
            width: size.width,
            height: size.height * 0.8,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.search_outlined,
                    color: Colors.orange,
                    size: size.shortestSide * 0.4,
                  ),
                  const Text(
                    'No Matching Notes Found',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: MasonryGridView.builder(
              controller: controller.scrollController,
              itemCount: forSearch == true
                  ? controller.searchlist.length
                  : snapshot.data?.length ?? 0,
              shrinkWrap: true,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: forSearch == true
                  ? (context, index) {
                      return DataCard(
                        size: size,
                        isgrid: false,
                        data: controller.searchlist[index],
                      );
                    }
                  : (context, index) {
                      return DataCard(
                        data: snapshot.data?[index],
                        size: size,
                        isgrid: true,
                      );
                    },
            ),
          );
  }

  
}
