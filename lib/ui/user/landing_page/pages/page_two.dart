import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/app_text_styles.dart';
import '../../../../common/color_values.dart';

class PageTwo extends StatefulWidget {
  PageTwo({Key? key}) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
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
              child: SvgPicture.asset(
                'assets/svg_image/landingPage2.svg',
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                AppLocalizations.of(context)!.landing_page2,
                style: AppTextStyles.appTitlew700s20(ColorValues().blackColor),
              ),
            ),
            Text(AppLocalizations.of(context)!.landing_page_desc2,
                textAlign: TextAlign.center,
                style: AppTextStyles.appTitlew500s16(ColorValues().blackColor))
          ],
        ),
      ),
    );
  }
}
