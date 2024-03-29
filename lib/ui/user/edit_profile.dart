import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/common/shared_code.dart';
import 'package:trip_boy/component/BuildTextFormField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_boy/component/loading.dart';
import 'package:trip_boy/services/database_services.dart';
import '../../common/color_values.dart';
import '../../common/user_data.dart';
import '../../models/user_model.dart';

class EditProfile extends StatefulWidget {
  String uid;
  EditProfile({Key? key, required this.uid}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String name = "";
  String email = "";
  String profileUrl = "";
  String phoneNumber = "";
  String uidGlobal = "";
  bool _isLoading = false;
  File? file;

  static final formKey = GlobalKey<FormState>();

  late TextEditingController nameEditingController;
  late TextEditingController emailEditingController;
  late TextEditingController phoneNumEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    setLoading(true);
    UserModel userData = await DatabaseService().getUserData(widget.uid);
    name = userData.name!;
    email = userData.email!;
    phoneNumber = userData.phoneNumber!;
    profileUrl = userData.profileImage!;
    uidGlobal = userData.uid!;

    nameEditingController = TextEditingController(text: name);
    emailEditingController = TextEditingController(text: email);
    phoneNumEditingController =
        TextEditingController(text: phoneNumber == null ? "" : phoneNumber);
    setLoading(false);
  }

  Future<void> updateProfile(phoneNumEditingController, emailEditingController,
      nameEditingController) async {
    setLoading(true);
    await DatabaseService().updateUserData(
        widget.uid,
        phoneNumEditingController.text,
        emailEditingController.text,
        nameEditingController.text,
        profileUrl);

    Navigator.pop(context, true);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorValues().primaryColor),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: _isLoading
          ? Loading()
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 15.sp),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      buildProfileImage(),
                      SizedBox(
                        height: 10.sp,
                      ),
                      BuildTextFormField(
                        controller: nameEditingController,
                        hintText: AppLocalizations.of(context)!.enterName,
                        title: AppLocalizations.of(context)!.name,
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      BuildTextFormField(
                        controller: emailEditingController,
                        hintText: AppLocalizations.of(context)!.enterEmail,
                        title: AppLocalizations.of(context)!.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: SharedCode(context).emailValidator,
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      BuildTextFormField(
                          keyboardType: TextInputType.phone,
                          controller: phoneNumEditingController,
                          hintText:
                              AppLocalizations.of(context)!.enterPhoneNumber,
                          title: AppLocalizations.of(context)!.phoneNumber),
                      Container(
                        width: MediaQuery.of(context).size.width.sp,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                updateProfile(
                                    phoneNumEditingController,
                                    emailEditingController,
                                    nameEditingController);
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorValues().primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          child: Text(AppLocalizations.of(context)!.save),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget buildProfileImage() {
    return Container(
      height: 110,
      width: 110,
      child: Stack(
        fit: StackFit.expand,
        children: [
          profileUrl.endsWith('jpg') ||
                  profileUrl.endsWith('png') ||
                  profileUrl.endsWith('jpeg')
              ? CircleAvatar(
                  backgroundImage: FileImage(File(profileUrl)),
                )
              : CircleAvatar(
                  backgroundImage: NetworkImage(profileUrl),
                ),
          Container(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () async {
                var pickedFile = await SharedCode(context).getFromGallery();
                setState(() {
                  if (pickedFile != null) {
                    // file = File(pickedFile.path);
                    profileUrl = pickedFile.path;
                  }
                });
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: ColorValues().primaryColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Icon(
                  Icons.edit,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
