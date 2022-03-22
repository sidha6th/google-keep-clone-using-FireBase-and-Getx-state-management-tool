import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_keep_clone/controller/note_controller.dart';
import 'package:google_keep_clone/model/model.dart';
import 'package:google_keep_clone/screens/views/home_screen/home_screen.dart';

class AddOrEditScreen extends StatefulWidget {
  const AddOrEditScreen({
    this.data,
    this.forEdit = false,
    Key? key,
  }) : super(key: key);
  final bool? forEdit;
  final NoteModel? data;
  @override
  State<AddOrEditScreen> createState() => _AddOrEditScreenState();
}

class _AddOrEditScreenState extends State<AddOrEditScreen> {
  addNote() async {
    if (NoteController.title.text.trim().isEmpty &&
        NoteController.content.text.trim().isEmpty) {
      return;
    }
    NoteModel note = NoteModel(
      title: NoteController.title.text,
      content: NoteController.content.text,
      dateTime: DateTime.now(),
    );
    await NoteController.createNote(note);
    NoteController.title.clear();
    NoteController.content.clear();
  }

  updateNote() async {
    NoteModel note = NoteModel(
        title: NoteController.title.text,
        content: NoteController.content.text,
        dateTime: DateTime.now(),
        id: widget.data?.id);
    if (NoteController.title.text.trim().isEmpty &&
        NoteController.content.text.trim().isEmpty) {
      await NoteController.deleteNote(note);
      return;
    }
    await NoteController.updateNote(note);
  }

  @override
  void dispose() {
    widget.forEdit == true ? updateNote() : addNote();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NoteController.title.text = widget.data?.title ?? '';
    NoteController.content.text = widget.data?.content ?? '';
    //final NoteController controller = Get.find<NoteController>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.push_pin_outlined,
              color: Colors.black54,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notification_add_outlined,
              color: Colors.black54,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.archive_outlined,
              color: Colors.black54,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            TextFormField(
              controller: NoteController.title,
              //initialValue: widget.title ?? '',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                hintText: 'Title',
                border: InputBorder.none,
              ),
            ),
            TextFormField(
              controller: NoteController.content,
              //initialValue: widget.content ?? '',
              style: const TextStyle(color: Colors.black, fontSize: 15),
              maxLines: null,
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                hintText: 'Note',
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add_box_outlined),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.color_lens_outlined),
            ),
            const Spacer(),
            Text(
                //DateFormat.jm().format(DateFormat("hh:mm:ss").parse())
                'Edited:${widget.data?.dateTime?.hour ?? DateTime.now().hour}:${widget.data?.dateTime?.minute ?? DateTime.now().minute}'),
            //Text('Edited:${widget.lastEdited?.hour??DateTime.now().hour}:${widget.lastEdited?.minute??DateTime.now().minute}'),
            const Spacer(),
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  enableDrag: true,
                  context: context,
                  builder: (context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.delete_outline),
                          title: const Text('Delete'),
                          onTap: () {
                            NoteModel note = NoteModel(
                              title: NoteController.title.text,
                              content: NoteController.content.text,
                              dateTime: DateTime.now(),
                              id: widget.data?.id,
                            );
                            widget.forEdit == false
                                ? Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (ctx) => const HomeScreen(),
                                    ),
                                    (route) => false,
                                  )
                                : {
                                    NoteController.deleteNote(note),
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (ctx) => const HomeScreen(),
                                      ),
                                      (route) => false,
                                    )
                                  };
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.copy_rounded),
                          title: const Text('Make a copy'),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.share_outlined),
                          title: const Text('Send'),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.person_add_alt),
                          title: const Text('Collaborator'),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.label_outline),
                          title: const Text('Labels'),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.more_vert_sharp),
            ),
          ],
        ),
      ),
    );
  }
}
