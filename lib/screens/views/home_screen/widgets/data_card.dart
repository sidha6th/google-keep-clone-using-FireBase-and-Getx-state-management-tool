import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_keep_clone/model/model.dart';
import 'package:google_keep_clone/screens/views/add_or_edit_screen/add_or_edit_screen.dart';

class DataCard extends StatelessWidget {
  const DataCard({
    Key? key,
    this.data,
    this.isgrid = false,
    required this.size,
  }) : super(key: key);

  final Size size;
  final bool isgrid;
  final NoteModel? data;

  @override
  Widget build(BuildContext context) {
    return data==null?const SizedBox(): InkWell(
      onTap: () {
        Get.to(
          AddOrEditScreen(
            data: data,
            forEdit: true,
          ),
        );
      },
      child: Container(
        width: isgrid ? 0 : size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: data?.title == null
                    ? const SizedBox()
                    : data!.title!.trim().isNotEmpty
                        ? Text(
                            data?.title ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        : const SizedBox(),
              ),
              data?.content == null
                  ? const SizedBox()
                  : data!.content.trim().isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Text(
                            data?.content ?? '',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 7,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        )
                      : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
