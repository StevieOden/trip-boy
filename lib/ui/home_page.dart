import 'package:flutter/material.dart';
import 'package:trip_boy/component/circle_button.dart';
import 'package:trip_boy/component/horizontal_card.dart';
import 'package:trip_boy/component/search_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/component/vertical_card.dart';
import 'package:trip_boy/ui/dashboard_page.dart';
import '../common/app_text_styles.dart';
import '../common/color_values.dart';

class HomePage extends StatefulWidget {
  int selectedIndex, selectedTabIndex;
  HomePage(
      {Key? key, required this.selectedIndex, required this.selectedTabIndex})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    return GestureDetector(
      onTap: () {
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height.sp,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 5.h,
                      margin: EdgeInsets.only(
                          left: 15.sp, right: 15.sp, top: 10.sp),
                      width: MediaQuery.of(context).size.width.w,
                      child: SearchBar()),
                  Container(
                    margin: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 15),
                    child: _buildCircleButton(),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 12.sp, top: 10.sp),
                      child: _buildHighlightEvent()),
                  Container(
                      margin: EdgeInsets.only(
                          left: 12.sp, top: 10.sp, right: 12.sp, bottom: 10.sp),
                      child: _buildRecommend()),
                ],
              ),
            )),
      ),
    );
  }

  _buildCircleButton() {
    return Row(
      children: [
        CircleButton(
          icon: Icons.restaurant,
          title: AppLocalizations.of(context)!.cullinary,
          onTap: () {
            setState(() {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardPage(
                      selectedIndex: 1,
                      exploreSelectionIndex: 0,
                    ),
                  ));
            });
          },
        ),
        CircleButton(
          icon: Icons.hotel,
          title: AppLocalizations.of(context)!.hotel,
          onTap: () {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardPage(
                      selectedIndex: 1,
                      exploreSelectionIndex: 1,
                    ),
                  ));
            });
          },
        ),
        CircleButton(
          icon: Icons.map,
          title: AppLocalizations.of(context)!.tour,
          onTap: () {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardPage(
                      selectedIndex: 1,
                      exploreSelectionIndex: 2,
                    ),
                  ));
            });
          },
        ),
        CircleButton(
          icon: Icons.event,
          title: AppLocalizations.of(context)!.event,
          onTap: () {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardPage(
                      selectedIndex: 1,
                      exploreSelectionIndex: 3,
                    ),
                  ));
            });
          },
        )
      ],
    );
  }

  _buildHighlightEvent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 3.sp),
          child: Text(
            AppLocalizations.of(context)!.highlight_event,
            style: AppTextStyles.appTitlew500s14(ColorValues().blackColor),
          ),
        ),
        SizedBox(
          height: 5.sp,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var i = 0; i < 6; i++)
                HorizontalCard(
                  title: "Street Food Festival : Poncobudoyo",
                  subDistrict: "Kec. Selo",
                  price: "Gratis",
                )
            ],
          ),
        ),
      ],
    );
  }

  _buildRecommend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 3.sp,
          ),
          child: Text(
            AppLocalizations.of(context)!.recommendation,
            style: AppTextStyles.appTitlew500s14(ColorValues().blackColor),
          ),
        ),
        SizedBox(
          height: 5.sp,
        ),
        Column(
          children: [
            for (var i = 0; i < 6; i++)
              VerticalCard(
                title: "Wisata Alam Sutera",
                subDistrict: "Kec. Selo",
                price: "Rp5.000",
                rating: "4.5",
              )
          ],
        ),
      ],
    );
  }
}
