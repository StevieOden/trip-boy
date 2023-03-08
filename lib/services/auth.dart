import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trip_boy/services/database_services.dart';
import 'package:trip_boy/ui/login_page.dart';
import 'package:trip_boy/ui/otp_page.dart';
import 'package:trip_boy/ui/user/dashboard_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/color_values.dart';
import '../models/user_model.dart';
import '../ui/admin/dashboard.dart';

class AuthService extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  String? _uid;
  String get uid => _uid!;

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AuthService() {
    checkSignIn();
  }

  Future googleLogin(BuildContext context) async {
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

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("is_signed", true);
      _isSignedIn = true;

      await DatabaseService().addDefaultPatientUser(
          result.user!.uid,
          result.user!.email!,
          result.user!.displayName!,
          result.user!.phoneNumber == null ? "" : result.user!.phoneNumber!,
          result.user!.photoURL!,
          "user_customer");

      await DatabaseService().getUserData(result.user!.uid).then((value) {
        if (value.role == "user_customer") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardPage(),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardAdmin(),
            ),
          );
        }
      });

      notifyListeners();
    } catch (e) {
      print("login error: " + e.toString());
    }
  }

  Future logout() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      _isSignedIn = false;
      await googleSignIn.disconnect();
      await firebaseAuth.signOut();
      notifyListeners();
    } catch (e) {
      print("logout error: " + e.toString());
    }
  }

  void checkSignIn() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      _isSignedIn = prefs.getBool("is_signed") ?? false;
      notifyListeners();
    } catch (e) {
      print("check sign in error: " + e.toString());
    }
  }

  void signInWithPhone(
    BuildContext context,
    String phoneNumber,
  ) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
        forceResendingToken: 3,
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) async {
          await firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          throw Exception(error.message);
        },
        codeSent: (verificationId, forceResendingToken) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpPage(
                  verificationId: verificationId,
                  phoneNumber: phoneNumber,
                ),
              ));
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 0,
        backgroundColor: ColorValues().primaryColor.withOpacity(0.5),
        content: Text(e.message.toString()),
      ));
    }
  }

  void verifyOtp(
      {required BuildContext context,
      required String verificationId,
      required String userOtp,
      required Function onSuccess}) async {
    _isLoading = true;
    notifyListeners();

    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      UserCredential user =
          await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);

      if (user != null) {
        _uid = user.user!.uid;
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("is_signed", true);
        _isSignedIn = true;
        checkExistingUser().then((value) async {
          if (value == false) {
            await DatabaseService().addDefaultPatientUser(user.user!.uid, "",
                 "", user.user!.phoneNumber, "", "user_customer");
          }
        });
        onSuccess();
      }

      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 0,
        backgroundColor: ColorValues().primaryColor.withOpacity(0.5),
        content: Text(e.message.toString()),
      ));
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> checkExistingUser() async {
    DocumentSnapshot snap =
        await firebaseFirestore.collection("users").doc(_uid).get();
    if (snap.exists) {
      print("user exists");
      return true;
    } else {
      print("new user");
      return false;
    }
  }
}
