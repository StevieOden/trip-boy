import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/models/activity_model.dart';

import '../common/color_values.dart';
import '../common/shared_code.dart';

class ActivityList extends StatelessWidget {
  List<ActivityModel> data;
  ActivityList({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      child: ListView.separated(
          itemBuilder: (context, index) {
            var dateFormatter = SharedCode.dateFormat;
            var generateAtFormated =
                dateFormatter.format(data[index].generatedAt);
            var expiredAtFormated = dateFormatter.format(data[index].expiredAt);
            return Container(
              height: 50.sp,
              margin: EdgeInsets.only(
                  left: 15.sp, right: 15.sp, top: 10.sp, bottom: 10.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    data[index].type == "restaurant"
                        ? Icons.restaurant
                        : data[index].type == "hotel"
                            ? Icons.hotel
                            : data[index].type == "destination"
                                ? Icons.tour_outlined
                                : Icons.event,
                    color: ColorValues().primaryColor,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[index].title,
                        style: TextStyle(
                            color: ColorValues().blackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Rp${data[index].price}",
                              style: TextStyle(
                                fontSize: 12,
                                color: ColorValues().blackColor,
                              )),
                          Text(generateAtFormated,
                              style: TextStyle(
                                fontSize: 12,
                                color: ColorValues().lightGrayColor,
                              )),
                          Text("Expired At $expiredAtFormated",
                              style: TextStyle(
                                fontSize: 10,
                                color: ColorValues().redColor,
                              ))
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: data[index].status == "Process"
                                  ? ColorValues().yellowColor
                                  : data[index].status == "Done"
                                      ? ColorValues().greenColor
                                      : ColorValues().lightRedColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(data[index].status,
                              style: TextStyle(
                                fontSize: 9,
                                color: data[index].status == "Process"
                                    ? ColorValues().orangeColor
                                    : data[index].status == "Done"
                                        ? ColorValues().darkGreenColor
                                        : ColorValues().redColor,
                              ))),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Bayar Sekarang",
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
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 3,
              color: ColorValues().tabColor,
            );
          },
          itemCount: data.length),
    ));
  }
}
