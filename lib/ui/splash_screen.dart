import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_boy/component/custom_dialog.dart';
import 'package:trip_boy/services/network_connectivity.dart';
import 'package:trip_boy/ui/admin/dashboard.dart';
import 'package:trip_boy/ui/user/dashboard_page.dart';
import 'package:trip_boy/ui/landing_page/landing_page.dart';

import '../models/user_model.dart';
import '../services/auth.dart';
import '../services/database_services.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String role = "";
  Map _source = {ConnectivityResult.none: false};
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;

  Future<void> getUserData(ap) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      final uid = user!.uid;
      UserModel userData = await DatabaseService().getUserData(uid);
      role = userData.role!;
    } catch (e) {
      print("error: " + e.toString());
    }
    navigations(ap);
  }

  Future<void> navigations(AuthService ap) async {
    Future.delayed(Duration(seconds: 2), () {
      print("is sign in: " + ap.isSignedIn.toString());
      if (ap.isSignedIn) {
        if (role == "user_customer") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DashboardPage()));
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DashboardAdmin()));
        }
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LandingPage()));
      }
    });
  }

  Future<void> checkInternet(ap) async {
    _networkConnectivity.initialise();
    _networkConnectivity.myStream.listen((source) {
      _source = source;
      switch (_source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          getUserData(ap);
          break;
        case ConnectivityResult.wifi:
          getUserData(ap);
          break;
        case ConnectivityResult.none:
        default:
          CustomDialog.showNoInternetConnectionDialog(context);
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    final ap = Provider.of<AuthService>(context, listen: false);
    checkInternet(ap);
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

  @override
  void dispose() {
    _networkConnectivity.disposeStream();
    super.dispose();
  }
}
