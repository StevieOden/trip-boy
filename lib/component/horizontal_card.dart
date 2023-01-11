import 'package:flutter/material.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/color_values.dart';
import 'package:sizer/sizer.dart';

class HorizontalCard extends StatefulWidget {
  String title, subDistrict, price;
  HorizontalCard(
      {Key? key,
      required this.title,
      required this.subDistrict,
      required this.price})
      : super(key: key);

  @override
  State<HorizontalCard> createState() => _HorizontalCardState();
}

class _HorizontalCardState extends State<HorizontalCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 90.sp,
        margin: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: ColorValues().primaryColor,
                  borderRadius: BorderRadius.circular(12)),
              width: MediaQuery.of(context).size.width.sp,
              height: 100.sp,
            ),
            SizedBox(
              height: 5.sp,
            ),
            Text(
              widget.title,
              style: AppTextStyles.appTitlew500s12(ColorValues().blackColor),
            ),
            SizedBox(
              height: 5.sp,
            ),
            Text(
              widget.subDistrict,
              style: AppTextStyles.appTitlew400s10(ColorValues().blackColor),
            ),
            SizedBox(
              height: 2.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.price,
                  style:
                      AppTextStyles.appTitlew500s10(ColorValues().primaryColor),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: ColorValues().primaryColor,
                  size: 10.sp,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
