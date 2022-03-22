import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_keep_clone/controller/note_controller.dart';
import 'package:google_keep_clone/model/model.dart';
import 'package:google_keep_clone/screens/views/home_screen/widgets/data_card.dart';

class ListVewwidget extends StatelessWidget {
  const ListVewwidget(
      {this.searchText,
      this.forSearch = false,
      required this.snapshot,
      Key? key})
      : super(key: key);
  final AsyncSnapshot<List<NoteModel>> snapshot;
  final String? searchText;
  final bool forSearch;
  @override
  Widget build(BuildContext context) {
    final NoteController controller = Get.find<NoteController>();
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
          controller: controller.scrollController,
          shrinkWrap: true,
          itemCount:  snapshot.data?.length ?? 0,
          itemBuilder: (context, index) {
            if (forSearch == true) {
              return  Column(
                children: <Widget>[
                  DataCard(
                    size: size,
                    isgrid: false,
                    data: snapshot.data![index].title.toString().contains(searchText.toString())
                        ? snapshot.data![index]
                        : null,
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
          },),
    );
  }
}
