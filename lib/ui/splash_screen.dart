import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trip_boy/ui/admin/dashboard.dart';
import 'package:trip_boy/ui/user/dashboard_page.dart';
import 'package:trip_boy/ui/user/landing_page/landing_page.dart';

import '../models/user_model.dart';
import '../services/database_services.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final user = FirebaseAuth.instance.currentUser;

  String role = "";

  Future<void> getUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      final uid = user!.uid;
      UserModel userData = await DatabaseService().getUserData(uid);
      role = userData.role!;
    } catch (e) {
      print("error: " + e.toString());
    }
    navigations();
  }

  Future<void> navigations() async {
    Future.delayed(Duration(seconds: 2), () {
      if (user == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LandingPage()));
      } else {
        print("role user:" + role);
        if (role == "user_customer") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DashboardPage()));
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DashboardAdmin()));
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/png_image/logo.png',
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.6,
        ),
      ),
    );
  }
}
