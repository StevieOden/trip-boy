import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/component/custom_dialog.dart';
import 'package:trip_boy/models/booking_model.dart';
import 'package:trip_boy/models/content_model.dart';
import 'package:trip_boy/services/database_services.dart';
import 'package:trip_boy/ui/user/booking_payment_page.dart';

import '../common/color_values.dart';
import '../common/shared_code.dart';

class ActivityListAdmin extends StatefulWidget {
  List<BookingModel> data;
  ActivityListAdmin({Key? key, required this.data}) : super(key: key);

  @override
  State<ActivityListAdmin> createState() => _ActivityListAdminState();
}

class _ActivityListAdminState extends State<ActivityListAdmin> {
  List<ContentModel> paymentData = [];

  @override
  void initState() {
    super.initState();
  }

  Future<String> getOrderId(userId, id) async {
    String orderId = await DatabaseService().getOrderIdAdmin(userId, id);
    return orderId;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      child: ListView.separated(
          itemBuilder: (context, index) {
            var generateAtFormated = widget.data[index].createdAt;
            var expiredAtFormated = SharedCode.dateAndTimeFormat.format(
                SharedCode.dateAndTimeFormat
                    .parse(widget.data[index].createdAt)
                    .add(Duration(hours: 1)));
            return InkWell(
              onTap: () {
                DatabaseService()
                    .getOrderUserData(widget.data[index].userId)
                    .then((value) => CustomDialog.showPaymentConfirmationAdmin(
                          context,
                          () {
                            getOrderId(widget.data[index].userId,
                                    widget.data[index].id)
                                .then((value) {
                              DatabaseService().updatePaymentAccept(
                                  widget.data[index].userId, value);
                              Navigator.pop(context);
                            });
                          },
                          () {
                            getOrderId(widget.data[index].userId,
                                    widget.data[index].id)
                                .then((value) {
                              DatabaseService().updatePaymentReject(
                                  widget.data[index].userId, value);
                              Navigator.pop(context);
                            });
                          },
                          Scrollbar(
                            isAlwaysShown: true,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.userName,
                                    style: AppTextStyles.appTitlew500s12(
                                        ColorValues().blackColor),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    value.name!,
                                    style: AppTextStyles.appTitlew400s12(
                                        ColorValues().blackColor),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.contentName,
                                    style: AppTextStyles.appTitlew500s12(
                                        ColorValues().blackColor),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    widget.data[index].booking.content.name,
                                    style: AppTextStyles.appTitlew400s12(
                                        ColorValues().blackColor),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.paymentTotal,
                                    style: AppTextStyles.appTitlew500s12(
                                        ColorValues().blackColor),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Rp${widget.data[index].payment.paymentAmount}",
                                    style: AppTextStyles.appTitlew400s12(
                                        ColorValues().blackColor),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .receiptPayment,
                                    style: AppTextStyles.appTitlew500s12(
                                        ColorValues().blackColor),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 450,
                                    width: MediaQuery.of(context).size.width,
                                    child: Image(
                                        image: FileImage(
                                      File(widget
                                          .data[index].payment.receiptImage),
                                    )),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.receiptSendAt,
                                    style: AppTextStyles.appTitlew500s12(
                                        ColorValues().blackColor),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    widget.data[index].payment.receiptSentAt,
                                    style: AppTextStyles.appTitlew400s12(
                                        ColorValues().blackColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ));
              },
              child: Container(
                height: 50.sp,
                margin: EdgeInsets.only(
                    left: 15.sp, right: 15.sp, top: 10.sp, bottom: 10.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      widget.data[index].booking.content.type == "restaurant"
                          ? Icons.restaurant
                          : widget.data[index].booking.content.type == "hotel"
                              ? Icons.hotel
                              : widget.data[index].booking.content.type ==
                                      "destination"
                                  ? Icons.tour_outlined
                                  : Icons.event,
                      color: ColorValues().primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.data[index].booking.content.name,
                            style: TextStyle(
                                color: ColorValues().blackColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.data[index].booking.paymentTotal == 0
                                  ? Text("Free",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: ColorValues().blackColor,
                                      ))
                                  : Text(
                                      "Rp${widget.data[index].booking.paymentTotal}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: ColorValues().blackColor,
                                      )),
                              Text(generateAtFormated,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: ColorValues().lightGrayColor,
                                  )),
                              Text("Expired At $expiredAtFormated",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: ColorValues().redColor,
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(child: Container()),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(AppLocalizations.of(context)!.checkData,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: ColorValues().primaryColor)),
                            Icon(
                              Icons.arrow_forward,
                              color: ColorValues().primaryColor,
                              size: 18,
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 3,
              color: ColorValues().tabColor,
            );
          },
          itemCount: widget.data.length),
    ));
  }
}
