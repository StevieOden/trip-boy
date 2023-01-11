import 'package:flutter/material.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/color_values.dart';
import 'package:sizer/sizer.dart';

class VerticalCard extends StatefulWidget {
  String title, subDistrict, price, rating;
  VerticalCard(
      {Key? key,
      required this.title,
      required this.subDistrict,
      required this.price,
      required this.rating,})
      : super(key: key);

  @override
  State<VerticalCard> createState() => _VerticalCardState();
}

class _VerticalCardState extends State<VerticalCard> {
  @override
  Widget build(BuildContext context) {
    return card();
  }

  Widget card() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: MediaQuery.of(context).size.width.sp,
        height: 60.sp,
        margin: EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: ColorValues().primaryColor,
                  borderRadius: BorderRadius.circular(12)),
              width: 60.sp,
              height: MediaQuery.of(context).size.height.sp,
            ),
            SizedBox(
              width: 10.sp,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: AppTextStyles.appTitlew500s12(
                            ColorValues().blackColor),
                      ),
                      Text(
                        widget.subDistrict,
                        style: AppTextStyles.appTitlew400s10(
                            ColorValues().blackColor),
                      ),
                    ],
                  ),
                  Text(
                    widget.price,
                    style: AppTextStyles.appTitlew700s12(
                        ColorValues().primaryColor),
                  )
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: ColorValues().primaryColor,
              size: 12.sp,
            )
          ],
        ),
      ),
    );
  }
}
