import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trip_boy/ui/user/dashboard_page.dart';
import 'package:trip_boy/ui/user/landing_page/landing_page.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      if (user == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LandingPage()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DashboardPage()));
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
