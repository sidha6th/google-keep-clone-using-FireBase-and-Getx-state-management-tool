import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_keep_clone/model/model.dart';
import 'package:google_keep_clone/screens/views/home_screen/home_screen.dart';
import 'package:google_keep_clone/screens/views/login_page/login_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class NoteController extends GetxController {
  final GetStorage box = GetStorage();

  GoogleSignInAccount? googleData;
  List<NoteModel?> searchlist = [];
  Map<String, dynamic> map = {};
  bool isSigned = false;
  ScrollController scrollController = ScrollController();
  static TextEditingController title = TextEditingController();
  static TextEditingController content = TextEditingController();
  static String userEmail = 'a';
  static String userPhoto = '';
  static String userName = '';
  //================ RX variables =================//
  RxBool isGrid = false.obs;
  static RxString searchText = ''.obs;
  RxInt index = 0.obs;
  //================ Rx variables =================//

//!!!!!!!!!!!!!!!!!!!!!!!!! functions !!!!!!!!!!!!!!!!!!!!!!!//

  //============ Google Signout Function =================//
  signOut() async {
    googleData = await GoogleSignIn().signOut();
    Get.off(
      const LoginScreen(),
    );
    await box.erase();
    isSigned = false;
  }

  //============ End of Google Signout Function =================//

//============ Google Signin Function ===================//
  signIn() async {
    googleData = await GoogleSignIn().signIn();
    if (googleData == null) {
      return;
    }
    final GoogleSignInAuthentication googleAuth =
        await googleData!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    await FirebaseAuth.instance.signInWithCredential(credential);

    await box.write('userEmail', googleData!.email);
    await box.write('userName', googleData!.displayName);
    await box.write('userImage', googleData!.photoUrl);
    userEmail = googleData!.email;
    userName = googleData!.displayName ?? '';
    userPhoto = googleData!.photoUrl ?? '';
    isSigned = true;
    Get.to(
      () => const HomeScreen(),
    );
  }
  //============ End of Google Signin Function ===================//

  //============ checking the user signed in or not ===================//
  checkIsSignedOrNot() async {
    isSigned = await GoogleSignIn().isSignedIn();
    if (isSigned == false) {
      await signIn();
      return;
    }

    userEmail = box.read('userEmail');
    userName = box.read('userName');
    userPhoto = box.read('userImage')!;
    Future.delayed(
      const Duration(
        milliseconds: 500,
      ),
    );
  }
  //============ checking the user signed in or not ===================//

  //===================== note creation ====================//
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
  //================= end of note creation =================//

  //================= getting notes =================//
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
  //=============== end of get note  =================//

  //================= Note updation =================//
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
  //============= end of note Updation ==============//

  //================= Note Deletion =================//
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
  //================= End of Note Deletion =================//

  //================= Note Searching function (for Grid view)=================//
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
                    ) ||
                snapshot.data![i].content.toString().toLowerCase().contains(
                      searchText.toLowerCase(),
                    )) {
              searchlist.add(snapshot.data![i]);
            }
          }
        }
      }
    }
  }
  //================= End of Note Searching function =================//

}
