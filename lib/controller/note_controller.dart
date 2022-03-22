import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_keep_clone/model/model.dart';

class NoteController extends GetxController {
  ScrollController scrollController = ScrollController();

  static TextEditingController title = TextEditingController();
  static TextEditingController content = TextEditingController();
  //================ obs variable =================//
  RxBool isGrid = false.obs;

  static Future<String> createNote(NoteModel note) async {
    final fireStore =
        FirebaseFirestore.instance.collection('collectionPath').doc();
    note.id = fireStore.id;
    await fireStore.set(
      note.toJson(),
    );
    return fireStore.id;
  }

  static Stream<List<NoteModel>> getNote() =>
      FirebaseFirestore.instance.collection('collectionPath').snapshots().map(
            (snapshot) => snapshot.docs
                .map(
                  (json) => NoteModel.fromJson(
                    json.data(),
                  ),
                )
                .toList(),
          );

  static Future updateNote(NoteModel note) async {
    final docTodo =
        FirebaseFirestore.instance.collection('collectionPath').doc(note.id);
    await docTodo.update(note.toJson());
  }

  static Future deleteNote(NoteModel note) async {
    //print(note.id);
    await FirebaseFirestore.instance
        .collection('collectionPath')
        .doc(note.id)
        .delete();
  }
}
