import 'dart:io';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/color_values.dart';
import '../../models/user_model.dart';
import '../../services/auth.dart';
import '../../services/database_services.dart';
import 'detail_confirmation_restaurant.dart';

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
  bool selected = true;
  int _choiceIndex = 0;

  List<String> choicesList = [
    "Semua",
    "Acc Destinasi Wisata",
    "Acc Restoran",
    "Acc Penginapan",
    "Acc Event",
    "Payment Confirmation",
  ];

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
        child: Column(
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
            Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: choicesList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: ChoiceChip(
                        selectedColor: ColorValues().primaryColor,
                        selected: _choiceIndex == index,
                        label: Text(choicesList[index]),
                        labelStyle: TextStyle(
                            color: _choiceIndex == index
                                ? Colors.white
                                : ColorValues().blackColor),
                        onSelected: (bool isSelect) {
                          setState(() {
                            _choiceIndex = isSelect ? index : 0;
                          });
                        }),
                  );
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0; i < 5; i++)
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailConfirmationRestaurant(
                                hintTextType: "",
                                index: 0,
                                isEditForm: false,
                                hintText: ""),
                          ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(3),
                                topRight: Radius.circular(3),
                                bottomLeft: Radius.circular(3),
                                bottomRight: Radius.circular(3)),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 213, 213, 213)
                                    .withOpacity(0.3),
                                // spreadRadius: 5,
                                blurRadius: 15,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          margin:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          height: 100,
                          child: Row(
                            children: [
                              Container(
                                child: Image.asset(
                                  "assets/png_image/kulinerFood.png",
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            "Warung Makan IGA Pak Wid",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text("29/11/2022",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 27,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(child: SizedBox()),
                                          Container(
                                            width: 70,
                                            height: 20,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Color.fromARGB(
                                                        255, 15, 199, 55)),
                                                onPressed: () {},
                                                child: Text(
                                                  "Terima",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                  ),
                                                )),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Container(
                                            width: 70,
                                            height: 20,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Color.fromARGB(
                                                        255, 232, 17, 17)),
                                                onPressed: () {},
                                                child: Text(
                                                  "Tolak",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                  ),
                                                )),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
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
