import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:trip_boy/component/loading.dart';
import 'package:sizer/sizer.dart';

import '../../common/app_text_styles.dart';
import '../../common/color_values.dart';
import '../../services/auth.dart';
import 'dashboard_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    try {} catch (e) {
      print(e.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Loading());
            } else if (snapshot.hasData) {
              return DashboardPage();
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Something went wrong!"),
              );
            } else {
              return _isLoading
                  ? Loading()
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [buildImage(), buildButton()],
                      ),
                    );
            }
          }),
    );
  }

  Widget buildImage() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45.sp,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 10,
            child: SvgPicture.asset(
              'assets/svg_image/loginPage.svg',
            ),
          ),
          Text(
            AppLocalizations.of(context)!.login_title,
            style: AppTextStyles.appTitlew700s20(ColorValues().blackColor),
          ),
          Text(AppLocalizations.of(context)!.login_desc,
              textAlign: TextAlign.center,
              style: AppTextStyles.appTitlew500s16(ColorValues().blackColor))
        ],
      ),
    );
  }

  Widget buildButton() {
    return Container(
      padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
      height: 85.sp,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 35.sp,
            child: ElevatedButton(
                onPressed: () {
                  final provider =
                      Provider.of<AuthService>(context, listen: false);
                  provider.googleLogin();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromRGBO(111, 56, 197, 1)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
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
                      AppLocalizations.of(context)!.login_google,
                      style: AppTextStyles.appTitlew500s12(Colors.white),
                    )
                  ],
                )),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 35.sp,
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromRGBO(111, 56, 197, 1)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
                ),
                child: Text(
                  AppLocalizations.of(context)!.login_back,
                  style: AppTextStyles.appTitlew500s12(Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
