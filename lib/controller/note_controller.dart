import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_keep_clone/model/model.dart';
import 'package:google_keep_clone/screens/views/login_page/login_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteController extends GetxController {
  GoogleSignInAccount? googleData;
  static String userEmail = 'a';
  static String userPhoto = '';
  static String userName = '';
  ScrollController scrollController = ScrollController();
  static TextEditingController title = TextEditingController();
  static TextEditingController content = TextEditingController();
  List<NoteModel?> searchlist = [];
  bool isSigned = false;
  //================ obs variable =================//
  RxBool isGrid = false.obs;
  static RxString searchText = ''.obs;
  RxInt index = 0.obs;
  //============ signin ===================//

  signIn() async {
    try {
      googleData = await GoogleSignIn().signIn();
    } on PlatformException {
      debugPrint('please trun on the network');
    }
    if (googleData == null) return;
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('userEmail', googleData!.email);
    await pref.setString('userName', googleData!.displayName ?? '');
    await pref.setString('userImage', googleData!.photoUrl ?? '');
    userEmail = googleData!.email;
    userName = googleData!.displayName ?? '';
    userPhoto = googleData!.photoUrl ?? '';
  }
  //============ signin ===================//

  //============ signOut =================//
  signOut() async {
    googleData = await GoogleSignIn().signOut();
    Get.off(
      const LoginScreen(),
    );
  }
  //============ signin =================//

  checkIsSignedOrNot() async {
    bool _signedOrNot = await GoogleSignIn().isSignedIn();
    if (_signedOrNot == false) {
      isSigned = false;
    }
    isSigned = _signedOrNot;
    SharedPreferences pref = await SharedPreferences.getInstance();
    userEmail = pref.getString('userEmail')!;
    userName = pref.getString('userName')!;
    userPhoto = pref.getString('userImage')!;
    Future.delayed(
      const Duration(milliseconds: 500),
    );
  }

  static Future<String> createNote(NoteModel note) async {
    final fireStore = FirebaseFirestore.instance
        .collection(
          userEmail,
        )
        .doc();
    note.id = fireStore.id;
    await fireStore.set(
      note.toJson(),
    );
    return fireStore.id;
  }

  static Stream<List<NoteModel>> getNote() =>
      FirebaseFirestore.instance.collection(userEmail).snapshots().map(
            (snapshot) => snapshot.docs
                .map(
                  (json) => NoteModel.fromJson(
                    json.data(),
                  ),
                )
                .toList(),
          );

  static Future updateNote(NoteModel note) async {
    final noteInstance = FirebaseFirestore.instance
        .collection(
          userEmail,
        )
        .doc(
          note.id,
        );
    await noteInstance.update(
      note.toJson(),
    );
  }

  static Future deleteNote(NoteModel note) async {
    await FirebaseFirestore.instance
        .collection(
          userEmail,
        )
        .doc(
          note.id,
        )
        .delete();
  }

  void getSearchData(AsyncSnapshot<List<NoteModel>> snapshot) {
    searchlist.clear();
    if (searchText.isEmpty) {
      searchlist.addAll(snapshot.data ?? []);
    } else {
      if (snapshot.data != null && snapshot.data!.isNotEmpty) {
        for (var i = 0; i < snapshot.data!.length; i++) {
          if (snapshot.data?[i] != null) {
            if (snapshot.data![i].title.toString().toLowerCase().contains(
                  searchText.toLowerCase(),
                )) {
              searchlist.add(snapshot.data![i]);
            }
          }
        }
      }
    }
  }
}
