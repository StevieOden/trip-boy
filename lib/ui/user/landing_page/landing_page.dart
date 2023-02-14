import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/common/app_text_styles.dart';

import '../../../main.dart';
import '../../login_page.dart';
import 'pages/page_one.dart';
import 'pages/page_three.dart';
import 'pages/page_two.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  PageController? _pageController;
  int pageIndex = 0;
  bool showLoginButton = false;

  void nextPage() {
    _pageController!.animateToPage(_pageController!.page!.toInt() + 1,
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void previousPage() {
    _pageController!.animateToPage(_pageController!.page!.toInt() - 1,
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildPageView(),
          buildIndicator(),
          showLoginButton == true
              ? buildLoginButton()
              : Container(
                  height: 35.sp,
                  width: 130.sp,
                )
        ],
      ),
    ));
  }

  Widget buildPageView() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.sp),
      height: MediaQuery.of(context).size.height * 0.4.sp,
      child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            PageOne(),
            PageTwo(),
            PageThree(),
          ],
          onPageChanged: (index) {
            pageIndex = index;
            setState(() {
              if (index == 2) {
                showLoginButton = true;
              } else {
                showLoginButton = false;
              }
            });
          }),
    );
  }

  Widget buildIndicator() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: MediaQuery.of(context).size.width * 0.60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          pageIndex == 0
              ? Expanded(
                  child: Container(),
                )
              : Expanded(
                  child: InkWell(
                    onTap: (() {
                      setState(() {
                        previousPage();
                      });
                    }),
                    child: Icon(
                      Icons.arrow_circle_left_rounded,
                      size: 50,
                      color: Color.fromRGBO(111, 56, 197, 1),
                    ),
                  ),
                ),
          Expanded(
            child: SmoothPageIndicator(
              controller: _pageController!,
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: Color.fromRGBO(111, 56, 197, 1),
                dotColor: Color.fromRGBO(217, 217, 217, 1),
                dotHeight: 10,
                dotWidth: 10,
                spacing: 10,
              ),
            ),
          ),
          pageIndex == 2
              ? Expanded(
                  child: Container(),
                )
              : Expanded(
                  child: InkWell(
                    onTap: (() {
                      setState(() {
                        nextPage();
                      });
                    }),
                    child: Icon(
                      Icons.arrow_circle_right_rounded,
                      size: 50,
                      color: Color.fromRGBO(111, 56, 197, 1),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget buildLoginButton() {
    return Container(
      height: 35.sp,
      width: 130.sp,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ElevatedButton(
        onPressed: (() {
          setState(() {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          });
        }),
        child: Text(
          AppLocalizations.of(context)!.login_button,
          style: AppTextStyles.appTitlew500s12(Colors.white),
        ),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Color.fromRGBO(111, 56, 197, 1)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          )),
        ),
      ),
    );
  }

  Widget buildChangeLocalizationButton() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ElevatedButton(
        onPressed: (() => MyApp),
        child: Text("Login Sekarang"),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Color.fromRGBO(111, 56, 197, 1)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          )),
        ),
      ),
    );
  }
}
