import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trip_boy/services/database_services.dart';

class AuthService extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

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
          result.user!.displayName!,
          result.user!.phoneNumber == null ? "" : result.user!.phoneNumber!,
          result.user!.photoURL!);

      notifyListeners();
    } catch (e) {
      print("login error: " + e.toString());
    }
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
