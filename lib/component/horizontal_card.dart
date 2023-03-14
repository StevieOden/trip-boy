import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/color_values.dart';
import 'package:sizer/sizer.dart';

class HorizontalCard extends StatefulWidget {
  String title, price, imageUrl;
  String? heldAt;
  double? rating;
  HorizontalCard(
      {Key? key,
      required this.title,
      this.heldAt,
      this.rating,
      required this.price,
      required this.imageUrl})
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
              width: MediaQuery.of(context).size.width.sp,
              height: 100.sp,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: widget.imageUrl == ""
                    ? Image.asset("assets/png_image/logo.png",
                        fit: BoxFit.cover, filterQuality: FilterQuality.high)
                    : Image.network(widget.imageUrl,
                        fit: BoxFit.cover, filterQuality: FilterQuality.high),
              ),
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
              widget.heldAt!.isEmpty ? widget.price.toString() : widget.heldAt!,
              style: AppTextStyles.appTitlew400s10(ColorValues().blackColor),
            ),
            SizedBox(
              height: 2.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.price == "0"
                    ? Text(
                        "Free",
                        style: AppTextStyles.appTitlew500s10(
                            ColorValues().primaryColor),
                      )
                    : Text(
                        "Rp${widget.price}",
                        style: AppTextStyles.appTitlew500s10(
                            ColorValues().primaryColor),
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
