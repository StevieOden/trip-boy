import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trip_boy/services/database_services.dart';
import 'package:trip_boy/ui/login_page.dart';
import 'package:trip_boy/ui/user/dashboard_page.dart';

import '../models/user_model.dart';

class AuthService extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      await googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print("logout error: " + e.toString());
    }

    try {
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential result =
          await FirebaseAuth.instance.signInWithCredential(credential);
      await DatabaseService().addDefaultPatientUser(
          result.user!.uid,
          result.user!.email!,
          "",
          result.user!.displayName!,
          result.user!.phoneNumber == null ? "" : result.user!.phoneNumber!,
          result.user!.photoURL!);

      notifyListeners();
    } catch (e) {
      print("login error: " + e.toString());
    }
  }

  Future registerUser(BuildContext context, String? email, String password,
      String name, String? phoneNumber, String? photoUrl) async {
    try {
      const _chars =
          'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      Random _rnd = Random();

      String getRandomString(int length) =>
          String.fromCharCodes(Iterable.generate(
              length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

      QuerySnapshot querySnapshot =
          await users.where("user_email", isEqualTo: email).get();
      UserModel userModel = UserModel(
          role: "user_customer",
          email: email,
          name: name,
          password: password,
          phoneNumber: phoneNumber == null ? "" : phoneNumber,
          profileImage: photoUrl,
          uid: getRandomString(20));
      if (querySnapshot.docs.isEmpty) {
        await users.add(userModel.toJson()).then((value) {
          print('User Registered');
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ));
        }).catchError((error) => print("Error: " + error.toString()));
      } else {
        print("user already added");
      }
    } catch (e) {}
  }

  Future logout() async {
    try {
      await googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();

      notifyListeners();
    } catch (e) {
      print("logout error: " + e.toString());
    }
  }
}
