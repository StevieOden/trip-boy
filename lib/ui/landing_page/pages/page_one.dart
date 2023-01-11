import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/color_values.dart';

class PageOne extends StatefulWidget {
  PageOne({Key? key}) : super(key: key);

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 10,
              child: SvgPicture.asset('assets/landingPage1.svg',
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                AppLocalizations.of(context)!.landing_page1,
                style: AppTextStyles.appTitlew700s20(ColorValues().blackColor),
              ),
            ),
            Text(AppLocalizations.of(context)!.landing_page_desc1,
                textAlign: TextAlign.center,
                style: AppTextStyles.appTitlew500s16(ColorValues().blackColor))
          ],
        ),
      ),
    );
  }
}
