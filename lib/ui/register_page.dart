import 'dart:async';

import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:trip_boy/common/shared_code.dart';
import 'package:trip_boy/component/BuildTextFormField.dart';
import 'package:trip_boy/ui/login_page.dart';
import 'package:trip_boy/ui/user/dashboard_page.dart';

import '../../common/app_text_styles.dart';
import '../../common/color_values.dart';
import '../../services/auth.dart';
import '../component/loading.dart';
import '../models/user_model.dart';
import '../services/database_services.dart';
import 'admin/dashboard.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String role = "";
  bool _isLoading = false;
  bool isShowPassword = false;
  bool isShowPasswordCon = false;
  late FocusNode focusNode;
  late TextEditingController nameForm;
  late TextEditingController phoneForm;
  late TextEditingController emailForm;
  late TextEditingController passForm;
  late TextEditingController passConForm;
  static final registerFormKey = GlobalKey<FormState>();

  Country selectedCountry = Country(
      phoneCode: "62",
      countryCode: "ID",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "Indonesia",
      example: "Indonesia",
      displayName: "Indonesia",
      displayNameNoCountryCode: "ID",
      e164Key: "");

  Future<void> getUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      final uid = user!.uid;
      UserModel userData = await DatabaseService().getUserData(uid);
      role = userData.role!;
    } catch (e) {
      throw ("error : " + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();

    focusNode = FocusNode();
    nameForm = TextEditingController();
    phoneForm = TextEditingController();
    emailForm = TextEditingController();
    passForm = TextEditingController();
    passConForm = TextEditingController();
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
  void dispose() {
    focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    phoneForm.selection =
        TextSelection.fromPosition(TextPosition(offset: phoneForm.text.length));
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: SharedCode.globalMargin,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildImage(),
                SizedBox(
                  height: 10,
                ),
                buildLoginForm(),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    AppLocalizations.of(context)!.or.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.appTitlew500s14(
                        ColorValues().darkGreyColor),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                buildButtonGoogleLogin(),
                // SizedBox(
                //   height: 15,
                // ),
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   alignment: Alignment.center,
                //   child: Wrap(
                //     spacing: 2,
                //     children: [
                //       Text(
                //         AppLocalizations.of(context)!.alreadyHaveAccount,
                //         style: AppTextStyles.appTitlew400s12(
                //             ColorValues().darkGreyColor),
                //       ),
                //       GestureDetector(
                //         onTap: () {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                 builder: (context) => LoginPage(),
                //               ));
                //         },
                //         child: Text(
                //           AppLocalizations.of(context)!.login_button,
                //           style: AppTextStyles.appTitlew500s12(
                //               ColorValues().primaryColor),
                //         ),
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          'assets/svg_image/loginPage.svg',
          height: MediaQuery.of(context).size.height * 0.2,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          AppLocalizations.of(context)!.login_title,
          style: AppTextStyles.appTitlew700s18(ColorValues().veryBlackColor),
        ),
        Text(AppLocalizations.of(context)!.registerDesc,
            textAlign: TextAlign.start,
            style: AppTextStyles.appTitlew400s14(ColorValues().blackColor))
      ],
    );
  }

  Widget buildButtonGoogleLogin() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: OutlinedButton(
          onPressed: () {
            final provider = Provider.of<AuthService>(context, listen: false);
            provider.googleLogin(context);
          },
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: ColorValues().greyColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  width: 20,
                  height: 20,
                  image: AssetImage('assets/png_image/google.png')),
              SizedBox(width: 15),
              Text(
                AppLocalizations.of(context)!.login_google.toUpperCase(),
                style:
                    AppTextStyles.appTitlew500s12(ColorValues().darkGreyColor),
              )
            ],
          )),
    );
  }

  buildLoginForm() {
    return Form(
      key: registerFormKey,
      child: Column(
        children: [
          BuildTextFormField(
            cursorColor: ColorValues().primaryColor,
            controller: nameForm,
            prefix: Icon(
              Icons.person,
              color: ColorValues().darkGreyColor.withOpacity(0.5),
            ),
            hintText: AppLocalizations.of(context)!.fillName,
            title: "",
            isTitle: false,
            validator: (value) {
              if (value!.isNotEmpty) {
                SharedCode(context).nameValidator(value);
              } else if (value.isEmpty) {
                SharedCode(context).emptyValidator(value);
              }
            },
          ),
          BuildTextFormField(
            cursorColor: ColorValues().primaryColor,
            controller: phoneForm,
            onChanged: (value) {
              setState(() {
                phoneForm.text = value;
              });
            },
            suffix: phoneForm.text.length > 8
                ? Icon(
                    Icons.done,
                    color: ColorValues().darkGreenColor,
                  )
                : null,
            prefix: Container(
              margin: EdgeInsets.only(top: 15, bottom: 15, left: 5),
              child: InkWell(
                onTap: () {
                  showCountryPicker(
                      context: context,
                      onSelect: (value) {
                        setState(() {
                          selectedCountry = value;
                        });
                      },
                      countryListTheme: CountryListThemeData(
                          borderRadius: BorderRadius.circular(20),
                          textStyle: AppTextStyles.appTitlew400s14(
                              ColorValues().blackColor),
                          bottomSheetHeight:
                              MediaQuery.of(context).size.height * 0.5));
                },
                child: Text(
                  "${selectedCountry.flagEmoji} +${selectedCountry.phoneCode}",
                  style:
                      AppTextStyles.appTitlew500s12(ColorValues().blackColor),
                ),
              ),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'^0+')),
              FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
            ],
            hintText: AppLocalizations.of(context)!.phoneNumber,
            title: "",
            isTitle: false,
            keyboardType: TextInputType.phone,
            validator: SharedCode(context).phoneValidator,
          ),

          // BuildTextFormField(
          //   cursorColor: ColorValues().primaryColor,
          //   controller: passForm,
          //   prefix: Icon(
          //     Icons.fingerprint,
          //     color: ColorValues().darkGreyColor.withOpacity(0.5),
          //   ),
          //   suffix: IconButton(
          //       onPressed: () {
          //         setState(() {
          //           isShowPassword = !isShowPassword;
          //         });
          //       },
          //       icon: Icon(
          //         isShowPassword ? Icons.visibility : Icons.visibility_off,
          //         color: ColorValues().darkGreyColor.withOpacity(0.5),
          //       )),
          //   hintText: AppLocalizations.of(context)!.passwords,
          //   obsecure: !isShowPassword,
          //   title: "",
          //   isTitle: false,
          //   validator: (value) {
          //     if (value!.isEmpty) {
          //       return SharedCode(context).passwordEmpty(value);
          //     }
          //     if (value.isNotEmpty) {
          //       return SharedCode(context).passwordValidator(value);
          //     }
          //     if (value != passConForm.text) {
          //       return AppLocalizations.of(context)!.passConfirmSame;
          //     }
          //   },
          // ),
          // BuildTextFormField(
          //   cursorColor: ColorValues().primaryColor,
          //   controller: passConForm,
          //   prefix: Icon(
          //     Icons.fingerprint,
          //     color: ColorValues().darkGreyColor.withOpacity(0.5),
          //   ),
          //   suffix: IconButton(
          //       onPressed: () {
          //         setState(() {
          //           isShowPasswordCon = !isShowPasswordCon;
          //         });
          //       },
          //       icon: Icon(
          //         isShowPasswordCon ? Icons.visibility : Icons.visibility_off,
          //         color: ColorValues().darkGreyColor.withOpacity(0.5),
          //       )),
          //   hintText: AppLocalizations.of(context)!.passwordsCon,
          //   obsecure: !isShowPasswordCon,
          //   title: "",
          //   isTitle: false,
          //   validator: (value) {
          //     if (value!.isEmpty) {
          //       return SharedCode(context).passwordConfirmValidator(value);
          //     }
          //     if (value != passForm.text) {
          //       return SharedCode(context).passwordConfirmSameValidator(value);
          //     }
          //     if (value.isNotEmpty) {
          //       return SharedCode(context).passwordValidator(value);
          //     }
          //   },
          // ),

          Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: ElevatedButton(
                onPressed: () {
                  if (registerFormKey.currentState!.validate()) {
                    sendPhoneNumber();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorValues().primaryColor,
                  side: BorderSide(color: ColorValues().greyColor),
                ),
                child: Text(
                  AppLocalizations.of(context)!.login_button.toUpperCase(),
                  style: AppTextStyles.appTitlew500s12(Colors.white),
                )),
          )
        ],
      ),
    );
  }

  void sendPhoneNumber() {
    final ap = Provider.of<AuthService>(context, listen: false);
    String phoneNumber =
        "+${selectedCountry.phoneCode}${phoneForm.text.trim()}";
    ap.signInWithPhone(context, phoneNumber);
  }
}
