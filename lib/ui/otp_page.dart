import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:trip_boy/component/loading.dart';
import 'package:trip_boy/services/auth.dart';
import 'package:trip_boy/ui/login_page.dart';
import 'package:trip_boy/ui/user/dashboard_page.dart';

import '../common/app_text_styles.dart';
import '../common/color_values.dart';
import '../common/shared_code.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../models/user_model.dart';
import '../services/database_services.dart';
import 'admin/dashboard.dart';

class OtpPage extends StatefulWidget {
  final String verificationId;
  final String name, password, phoneNumber;
  OtpPage(
      {Key? key,
      required this.verificationId,
      required this.name,
      required this.phoneNumber,
      required this.password})
      : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String? otpCode;
  String role = "";

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<AuthService>(context, listen: true).isLoading;
    FocusScopeNode currentFocus = FocusScope.of(context);
    return GestureDetector(
      onTap: () {
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: isLoading
            ? Loading()
            : SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  margin: SharedCode.globalMargin,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      buildImage(),
                      SizedBox(
                        height: 20,
                      ),
                      buildPinCode(),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () {
                              if (otpCode != null) {
                                verifyOtp(context, otpCode!);
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  elevation: 0,
                                  backgroundColor: ColorValues()
                                      .primaryColor
                                      .withOpacity(0.5),
                                  content: Text(
                                      AppLocalizations.of(context)!.errorOtp),
                                ));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: ColorValues().secondaryColor,
                            ),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .verifyButton
                                  .toUpperCase(),
                              style:
                                  AppTextStyles.appTitlew500s12(Colors.black),
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.didntGetOtp,
                            style: AppTextStyles.appTitlew400s12(
                                ColorValues().blackColor),
                          ),
                          TextButton(
                            onPressed: () {
                              sendPhoneNumber();
                            },
                            child: Text(
                              AppLocalizations.of(context)!.getOtp,
                              style: AppTextStyles.appTitlew500s12(
                                  ColorValues().primaryColor),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget buildImage() {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/svg_image/authantication.svg',
          height: MediaQuery.of(context).size.height * 0.2,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          AppLocalizations.of(context)!.verificationPage,
          style: AppTextStyles.appTitlew700s18(ColorValues().veryBlackColor),
        ),
        Text(AppLocalizations.of(context)!.verificationDescription,
            textAlign: TextAlign.start,
            style: AppTextStyles.appTitlew400s14(ColorValues().blackColor))
      ],
    );
  }

  Widget buildPinCode() {
    return PinCodeTextField(
      cursorColor: Colors.white,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          selectedColor: ColorValues().primaryColor,
          selectedFillColor: ColorValues().primaryColor,
          inactiveColor: Color(0xffE7ECF3),
          inactiveFillColor: Color(0xffE7ECF3),
          borderRadius: BorderRadius.circular(10)),
      textStyle: TextStyle(color: Colors.white),
      enableActiveFill: true,
      keyboardType: TextInputType.number,
      autoFocus: true,
      appContext: context,
      length: 6,
      onChanged: (value) {},
      onCompleted: (value) {
        setState(() {
          otpCode = value;
        });
      },
    );
  }

  Future<void> getUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      final uid = user!.uid;
      await DatabaseService().getUserData(uid).then((value) {
        if (value.role == "user_customer") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DashboardPage()));
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DashboardAdmin()));
        }
      });
      // role = userData.role!;
    } catch (e) {
      print("error: " + e.toString());
    }
  }

  void sendPhoneNumber() {
    final ap = Provider.of<AuthService>(context, listen: false);
    ap.signInWithPhone(
        context, widget.phoneNumber, widget.name, widget.password);
  }

  void verifyOtp(BuildContext context, String otpCode) async {
    final ap = Provider.of<AuthService>(context, listen: false);
    ap.verifyOtp(
        context: context,
        verificationId: widget.verificationId,
        userOtp: otpCode,
        name: widget.name,
        password: widget.password,
        onSuccess: () {
          getUserData();
        });
  }
}
