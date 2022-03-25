import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_keep_clone/controller/note_controller.dart';
import 'package:google_keep_clone/model/model.dart';
import 'package:google_keep_clone/screens/views/home_screen/widgets/data_card.dart';

class ListVewwidget extends StatelessWidget {
  const ListVewwidget(
      {this.searchText,
      required this.forSearch,
      required this.snapshot,
      Key? key})
      : super(key: key);
  final AsyncSnapshot<List<NoteModel>> snapshot;
  final String? searchText;
  final bool forSearch;
  @override
  Widget build(BuildContext context) {
    final NoteController controller = Get.find<NoteController>();
    controller.getSearchData(snapshot);
    final Size size = MediaQuery.of(context).size;
    return GetBuilder<NoteController>(builder: (params) {
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
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              // ignore: prefer_is_empty
              child: (forSearch == true &&
                      snapshot.data!.isEmpty &&
                      searchText!.isNotEmpty)
                  ? const Text(
                      'No Notes Found',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )
                  : ListView.builder(
                      controller: controller.scrollController,
                      shrinkWrap: true,
                      itemCount: forSearch == true
                          ? controller.searchlist.length
                          : snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        if (forSearch == true) {
                          return Column(
                            children: <Widget>[
                              DataCard(
                                size: size,
                                isgrid: false,
                                data: controller.searchlist[index],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            children: <Widget>[
                              DataCard(
                                size: size,
                                isgrid: false,
                                data: snapshot.data?[index],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        }
                      },
                    ),
            );
    });
  }
}
