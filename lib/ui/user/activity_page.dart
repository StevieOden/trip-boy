import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/shared_code.dart';
import 'package:trip_boy/common/color_values.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trip_boy/common/user_data.dart';
import 'package:trip_boy/component/activity_list.dart';
import 'package:trip_boy/component/loading.dart';
import 'package:trip_boy/models/activity_model.dart';
import 'package:trip_boy/services/database_services.dart';

import '../../models/booking_model.dart';
import '../../models/content_model.dart';

class ActivityPage extends StatefulWidget {
  ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  int tabIndex = 0;
  bool _isLoading = false;
  List<BookingModel> bookingData = [];
  List<String> bookingId = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    setState(() {
      _isLoading = true;
    });
    bookingData = await DatabaseService().getBookingData();
    bookingId = await DatabaseService().getBookingId();
    // for (var i = 0; i < bookingData.length; i++) {
    //   SharedCode.dateAndTimeFormat
    //           .parse(bookingData[i].payment.paymentExpiresAt)
    //           .isBefore(DateTime.now())
    //       ? await DatabaseService()
    //           .updatepaymentStatus(UserData().uid, bookingId[i])
    //       : null;
    // }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double tabWidth = MediaQuery.of(context).size.width * 0.175.sp;
    return Scaffold(
      body: _isLoading
          ? Loading()
          : Column(
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
    return bookingData.isEmpty ? noData() : ActivityList(data: bookingData);
  }

  processList() {
    return bookingData
            .where((element) =>
                element.paymentStatus == "process" ||
                element.paymentStatus == "in-review")
            .toList()
            .isEmpty
        ? noData()
        : ActivityList(
            data: bookingData
                .where((element) =>
                    element.paymentStatus == "process" ||
                    element.paymentStatus == "in-review")
                .toList());
  }

  doneList() {
    return bookingData
            .where((element) => element.paymentStatus == "done")
            .toList()
            .isEmpty
        ? noData()
        : ActivityList(
            data: bookingData
                .where((element) => element.paymentStatus == "done")
                .toList());
  }

  canceledList() {
    return bookingData
            .where((element) => element.paymentStatus == "canceled")
            .toList()
            .isEmpty
        ? noData()
        : ActivityList(
            data: bookingData
                .where((element) => element.paymentStatus == "canceled")
                .toList());
  }
}
