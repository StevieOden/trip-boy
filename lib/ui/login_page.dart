import 'dart:async';

import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:trip_boy/common/shared_code.dart';
import 'package:trip_boy/component/BuildTextFormField.dart';

import '../../common/app_text_styles.dart';
import '../../common/color_values.dart';
import '../../services/auth.dart';
import '../models/user_model.dart';
import '../services/database_services.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String role = "";
  bool _isLoading = false;
  bool isShowPassword = false;
  late FocusNode focusNode;
  late TextEditingController phoneForm;
  late TextEditingController passForm;
  // static final loginFormKey = GlobalKey<FormState>();

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
    phoneForm = TextEditingController();
    passForm = TextEditingController();
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
    // Clean up the focus node when the Form is disposed.
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
            padding: SharedCode.globalMargin,
            child: Column(
              children: [
                buildImage(),
                SizedBox(
                  height: 10,
                ),
                buildLoginForm(),
                SizedBox(
                  height: 15,
                ),
                Text(
                  AppLocalizations.of(context)!.or.toUpperCase(),
                  style: AppTextStyles.appTitlew500s14(
                      ColorValues().darkGreyColor),
                ),
                SizedBox(
                  height: 15,
                ),
                buildButtonGoogleLogin(),
                SizedBox(
                  height: 15,
                ),
                // Wrap(
                //   spacing: 2,
                //   crossAxisAlignment: WrapCrossAlignment.center,
                //   children: [
                //     Text(
                //       AppLocalizations.of(context)!.dontHaveAccount,
                //       style: AppTextStyles.appTitlew400s12(
                //           ColorValues().darkGreyColor),
                //     ),
                //     GestureDetector(
                //       onTap: () {
                //         setState(() {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) => RegisterPage()));
                //         });
                //       },
                //       child: Text(
                //         AppLocalizations.of(context)!.signup,
                //         style: AppTextStyles.appTitlew500s12(
                //             ColorValues().primaryColor),
                //       ),
                //     ),
                //   ],
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
          AppLocalizations.of(context)!.welcomeBack,
          style: AppTextStyles.appTitlew700s18(ColorValues().veryBlackColor),
        ),
        Text(AppLocalizations.of(context)!.login_desc,
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
      // key: loginFormKey,
      child: Column(
        children: [
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
              margin: EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
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
            hintText: AppLocalizations.of(context)!.phoneNumber,
            title: "",
            isTitle: false,
            nextFocusNode: focusNode,
            keyboardType: TextInputType.phone,
            validator: SharedCode(context).phoneValidator,
          ),
          // BuildTextFormField(
          //   cursorColor: ColorValues().primaryColor,
          //   controller: passForm,
          //   focusNode: focusNode,
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
          //   },
          // ),
          // Row(
          //   children: [
          //     Spacer(),
          //     TextButton(
          //         onPressed: () {},
          //         child: Text(
          //           AppLocalizations.of(context)!.forgotPassword,
          //           style: AppTextStyles.appTitlew500s12(
          //               ColorValues().primaryColor),
          //         ))
          //   ],
          // ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: ElevatedButton(
                onPressed: () {
                  // if (loginFormKey.currentState!.validate()) {
                  sendPhoneNumber();
                  // }
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
