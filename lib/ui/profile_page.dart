import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_boy/common/user_data.dart';
import 'package:trip_boy/component/loading.dart';
import 'package:trip_boy/services/auth.dart';
import 'package:trip_boy/services/database_services.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/ui/edit_profile.dart';
import 'package:trip_boy/ui/login_page.dart';
import 'package:trip_boy/ui/setting_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common/shared_code.dart';
import '../models/user_model.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = true;
  bool _isAuthenticated = false;
  String name = "";
  String email = "";
  String profileUrl = "";
  User? user = FirebaseAuth.instance.currentUser!;
  Locale? myLocale;

  Future<void> getUserData() async {
    _setLoading(true);
    final uid = user!.uid;
    if (uid == null) {
      _isAuthenticated = false;
      print("Not authanticated");
    } else {
      print("authanticated");
      _isAuthenticated = true;
      UserModel userData = await DatabaseService().getUserData(uid);
      name = userData.name;
      email = userData.email;
      profileUrl = userData.profileImage;
    }
    _setLoading(false);
  }

  void _setLoading(bool loading) {
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
    myLocale = Localizations.localeOf(context);
    return Scaffold(
      body: !_isAuthenticated
          ? LoginPage()
          : _isLoading
              ? Loading()
              : Padding(
                  padding: EdgeInsets.only(
                      left: 15.sp, right: 15.sp, top: 25.sp, bottom: 10.sp),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          Container(
                            height: 230,
                            margin: EdgeInsets.only(bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildProfileImage(),
                                buildUserProfileName(),
                              ],
                            ),
                          ),
                          buildEditProfileBtn(),
                          buildSettingBtn(),
                          Spacer(),
                          buildLogoutBtn()
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }

  Widget buildLogoutBtn() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () async {
            setState(() {
              final provider = Provider.of<AuthService>(context, listen: false);
              provider.logout();
            });
          },
          child: Row(
            children: [
              Icon(Icons.logout_outlined),
              SizedBox(
                width: 5,
              ),
              Text(
                AppLocalizations.of(context)!.logout,
                style: TextStyle(fontSize: 15),
              ),
            ],
          )),
    );
  }

  Widget buildEditProfileBtn() {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff6F38C5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfile(),
                ));
          },
          child: Row(
            children: [
              Icon(Icons.edit),
              SizedBox(
                width: 5,
              ),
              Text(AppLocalizations.of(context)!.editProfile),
            ],
          )),
    );
  }

  Widget buildSettingBtn() {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff6F38C5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingPage(myLocale: myLocale!),
                ));
          },
          child: Row(
            children: [
              Icon(Icons.settings),
              SizedBox(
                width: 5,
              ),
              Text(AppLocalizations.of(context)!.settings),
            ],
          )),
    );
  }

  Widget buildUserProfileName() {
    return Column(
      children: [
        Text(
          UserData().name!,
          style: TextStyle(
              fontSize: 16,
              color: Color(0xff3A354D),
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          UserData().email!,
          style: TextStyle(
              fontSize: 13,
              color: Color(0xff9598A6),
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 30,
        ),
        Divider(
          thickness: 2,
        )
      ],
    );
  }

  Widget buildProfileImage() {
    return Container(
      height: 110,
      width: 110,
      child: CircleAvatar(
        backgroundImage: NetworkImage(UserData().profileImage!),
      ),
    );
  }
}
