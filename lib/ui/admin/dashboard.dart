import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/color_values.dart';
import '../../models/user_model.dart';
import '../../services/auth.dart';
import '../../services/database_services.dart';

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({super.key});

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  String name = "";
  String email = "";
  String profileUrl = "";
  bool _isLoading = true;
  bool _isAuthenticated = false;
  User? user = FirebaseAuth.instance.currentUser!;

  Future<void> getUserData() async {
    setLoading(true);
    final uid = user!.uid;
    if (uid == null) {
      _isAuthenticated = false;
      print("Not authanticated");
    } else {
      print("authanticated");
      _isAuthenticated = true;
      UserModel userData = await DatabaseService().getUserData(uid);
      name = userData.name!;
      email = userData.email!;

      profileUrl = userData.profileImage!;
    }
    setLoading(false);
  }

  void setLoading(bool loading) {
    if (mounted) {
      setState(() {
        _isLoading = loading;
      });
    } else {
      _isLoading = loading;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 125,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(bottom: 10.sp, top: 10.sp),
                decoration: BoxDecoration(color: ColorValues().primaryColor),
                child: Container(
                  margin: EdgeInsets.only(left: 12, right: 12),
                  child: Row(
                    children: [
                      buildProfileImage(),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: AppTextStyles.appTitlew500s14(Colors.white),
                          ),
                          Text(
                            email,
                            style: AppTextStyles.appTitlew500s10(Colors.white),
                          )
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.settings,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  final provider = Provider.of<AuthService>(
                                      context,
                                      listen: false);
                                  provider.logout();
                                });
                              },
                              icon: Icon(
                                Icons.logout,
                                color: Colors.white,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileImage() {
    return Container(
      height: 80,
      width: 80,
      child: profileUrl.endsWith('jpg') ||
              profileUrl.endsWith('png') ||
              profileUrl.endsWith('jpeg')
          ? CircleAvatar(
              backgroundImage: FileImage(File(profileUrl)),
            )
          : CircleAvatar(
              backgroundImage: NetworkImage(profileUrl),
            ),
    );
  }
}
