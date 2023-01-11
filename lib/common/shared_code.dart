import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SharedCode {
  static DateFormat dateFormat = DateFormat('dd MMM yyyy, hh:mm');

  static Future<User?> checkUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? _user;

    _auth.authStateChanges().listen((event) {
      _user = event;
    });
    await Future.delayed(const Duration(seconds: 1));
    return _user;
  }

  static const shimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);
}
