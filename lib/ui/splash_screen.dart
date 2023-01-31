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

  Future<String> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;

    UserModel userData = await DatabaseService().getUserData(uid);
    role = userData.role!;

    return role;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();

    Future.delayed(Duration(seconds: 2), () {
      if (user == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LandingPage()));
      } else {
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
