import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common/app_text_styles.dart';
import '../../../common/color_values.dart';
import '../../../component/vertical_card.dart';

class TabComponent extends StatefulWidget {
  TabController tabController;
  String imageUrl, title;
  int rating;
  bool isLoading;
  TabComponent({Key? key ,required this.isLoading , required this.tabController, required this.imageUrl, required this.title, required this.rating}) : super(key: key);

  @override
  State<TabComponent> createState() => _TabComponentState();
}

class _TabComponentState extends State<TabComponent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.sp),
        child: Column(
          children: [buildPopular(), buildRekomendasi(), buildListAll()],
        ),
      ),
    );
  }

  Widget buildRekomendasi() {
    return Container(
      margin: EdgeInsets.only(top: 10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.recommendation,
            style: AppTextStyles.appTitlew500s14(ColorValues().blackColor),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.sp),
            height: MediaQuery.of(context).size.height * 0.35.sp,
            width: MediaQuery.of(context).size.width.sp,
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              children: List.generate(
                4,
                (index) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ColorValues().primaryColor,
                  ),
                  child: Image.network(
                      widget.imageUrl,
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.high),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildPopular() {
    return Container(
      margin: EdgeInsets.only(top: 10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.popular,
            style: AppTextStyles.appTitlew500s14(ColorValues().blackColor),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.sp),
            height: MediaQuery.of(context).size.height * 0.3.sp,
            width: MediaQuery.of(context).size.width.sp,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3.sp,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ColorValues().primaryColor),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: ColorValues().primaryColor),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: ColorValues().primaryColor),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildListAll() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 3.sp,
          ),
          child: Text(
            widget.tabController.index == 0
                ? AppLocalizations.of(context)!.allCullinary
                : widget.tabController.index == 1
                    ? AppLocalizations.of(context)!.allHotel
                    : widget.tabController.index == 2
                        ? AppLocalizations.of(context)!.allTour
                        : AppLocalizations.of(context)!.allEvent,
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
