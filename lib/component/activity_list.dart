import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_boy/models/booking_model.dart';
import 'package:trip_boy/models/content_model.dart';
import 'package:trip_boy/services/database_services.dart';
import 'package:trip_boy/ui/user/booking_payment_page.dart';

import '../common/color_values.dart';
import '../common/shared_code.dart';

class ActivityList extends StatefulWidget {
  List<BookingModel> data;
  ActivityList({Key? key, required this.data}) : super(key: key);

  @override
  State<ActivityList> createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList> {
  List<ContentModel> paymentData = [];

  @override
  void initState() {
    super.initState();
  }

  Future<String> getAccountNumber(id, index) async {
    String orderId = await DatabaseService().getOrderId(id);
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
                getAccountNumber(widget.data[index].id, index).then((value) {
                  widget.data[index].paymentStatus != "process"
                      ? null
                      : Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BookingPaymentPage(
                              orderId: value,
                              paymentTotal:
                                  widget.data[index].booking.paymentTotal,
                              title: widget.data[index].booking.content.name,
                              accountNumber: widget
                                  .data[index]
                                  .booking
                                  .content
                                  .paymentMethod![widget.data[index].booking
                                      .content.paymentMethod!
                                      .indexWhere((element) => element.method
                                          .contains(widget.data[index].booking
                                              .paymentMethod))]
                                  .number,
                              paymentMethod: widget
                                  .data[index]
                                  .booking
                                  .content
                                  .paymentMethod![widget.data[index].booking.content.paymentMethod!.indexWhere((element) => element.method.contains(widget.data[index].booking.paymentMethod))]
                                  .method),
                        ));
                });
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
                        Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: widget.data[index].paymentStatus ==
                                            "process" ||
                                        widget.data[index].paymentStatus ==
                                            "in-review"
                                    ? ColorValues().yellowColor
                                    : widget.data[index].paymentStatus == "done"
                                        ? ColorValues().greenColor
                                        : ColorValues().lightRedColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(
                                widget.data[index].paymentStatus == "in-review"
                                    ? "process"
                                    : widget.data[index].paymentStatus,
                                style: TextStyle(
                                  fontSize: 9,
                                  color: widget.data[index].paymentStatus ==
                                              "process" ||
                                          widget.data[index].paymentStatus ==
                                              "in-review"
                                      ? ColorValues().orangeColor
                                      : widget.data[index].paymentStatus ==
                                              "done"
                                          ? ColorValues().darkGreenColor
                                          : ColorValues().redColor,
                                ))),
                        widget.data[index].paymentStatus != "process"
                            ? Container()
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(AppLocalizations.of(context)!.payNow,
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
