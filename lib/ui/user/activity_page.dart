import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/shared_code.dart';
import 'package:trip_boy/common/color_values.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trip_boy/component/activity_list.dart';
import 'package:trip_boy/models/activity_model.dart';

class ActivityPage extends StatefulWidget {
  ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  int tabIndex = 0;
  List<ActivityModel> activityList = [];

  @override
  Widget build(BuildContext context) {
    activityList = [
      ActivityModel(
          title: "D’ASMO RESTO - Pulisen",
          description: "dawda",
          price: 25000,
          status: AppLocalizations.of(context)!.process,
          type: "restaurant",
          paymentType: "BCA",
          expiredAt: DateTime.now(),
          generatedAt: DateTime.now()),
      ActivityModel(
          title: "D’ASMO RESTO - Pulisen",
          description: "dawda",
          price: 25000,
          status: AppLocalizations.of(context)!.canceled,
          type: "hotel",
          paymentType: "BCA",
          expiredAt: DateTime.now(),
          generatedAt: DateTime.now()),
    ];
    double tabWidth = MediaQuery.of(context).size.width * 0.175.sp;
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: 15.sp, right: 15.sp, top: 10.sp, bottom: 10.sp),
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      tabIndex = 0;
                    });
                  },
                  child: Container(
                    width: tabWidth,
                    padding: EdgeInsets.all(10.sp),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: tabIndex != 0
                            ? ColorValues().tabColor
                            : ColorValues().primaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                    child: Text(
                      AppLocalizations.of(context)!.allOrders,
                      style: AppTextStyles.appTitlew500s12(tabIndex == 0
                          ? Colors.white
                          : ColorValues().primaryColor),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      tabIndex = 1;
                    });
                  },
                  child: Container(
                    width: tabWidth,
                    padding: EdgeInsets.all(10.sp),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: tabIndex != 1
                          ? ColorValues().tabColor
                          : ColorValues().primaryColor,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.process,
                      style: AppTextStyles.appTitlew500s12(tabIndex != 1
                          ? ColorValues().primaryColor
                          : Colors.white),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      tabIndex = 2;
                    });
                  },
                  child: Container(
                    width: tabWidth,
                    padding: EdgeInsets.all(10.sp),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: tabIndex != 2
                          ? ColorValues().tabColor
                          : ColorValues().primaryColor,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.done,
                      style: AppTextStyles.appTitlew500s12(tabIndex == 2
                          ? Colors.white
                          : ColorValues().primaryColor),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      tabIndex = 3;
                    });
                  },
                  child: Container(
                    width: tabWidth,
                    padding: EdgeInsets.all(10.sp),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: tabIndex != 3
                            ? ColorValues().tabColor
                            : ColorValues().primaryColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Text(
                      AppLocalizations.of(context)!.canceled,
                      style: AppTextStyles.appTitlew500s12(tabIndex == 3
                          ? Colors.white
                          : ColorValues().primaryColor),
                    ),
                  ),
                )
              ],
            ),
          ),
          tabIndex == 0
              ? allOrdersList()
              : tabIndex == 1
                  ? processList()
                  : tabIndex == 2
                      ? doneList()
                      : canceledList()
        ],
      ),
    );
  }

  noData() {
    return Expanded(
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset("assets/svg_image/noDataActivity.svg"),
          Text(
            AppLocalizations.of(context)!.noDataActivity,
            style: AppTextStyles.appTitlew500s14(ColorValues().blackColor),
          )
        ],
      )),
    );
  }

  allOrdersList() {
    return activityList.isEmpty ? noData() : ActivityList(data: activityList);
  }

  processList() {
    return activityList
            .where((element) =>
                element.status == AppLocalizations.of(context)!.process)
            .toList()
            .isEmpty
        ? noData()
        : ActivityList(
            data: activityList
                .where((element) =>
                    element.status == AppLocalizations.of(context)!.process)
                .toList());
  }

  doneList() {
    return activityList
            .where((element) =>
                element.status == AppLocalizations.of(context)!.done)
            .toList()
            .isEmpty
        ? noData()
        : ActivityList(
            data: activityList
                .where((element) =>
                    element.status == AppLocalizations.of(context)!.done)
                .toList());
  }

  canceledList() {
    return activityList
            .where((element) =>
                element.status == AppLocalizations.of(context)!.canceled)
            .toList()
            .isEmpty
        ? noData()
        : ActivityList(
            data: activityList
                .where((element) =>
                    element.status == AppLocalizations.of(context)!.canceled)
                .toList());
  }
}
