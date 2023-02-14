import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/color_values.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/models/content_model.dart';

class VerticalCard extends StatefulWidget {
  String title, subDistrict, rating, imageUrl;
  String price;
  bool isShowRating;
  bool isElevated;
  List<ContentModel>? listContent;
  VerticalCard({
    Key? key,
    required this.title,
    required this.subDistrict,
    required this.price,
    required this.rating,
    required this.imageUrl,
    this.isShowRating = true,
    this.isElevated = true,
    this.listContent,
  }) : super(key: key);

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
      elevation: widget.isElevated ? 2 : 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: MediaQuery.of(context).size.width.sp,
        height: 60.sp,
        margin: EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 80,
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: widget.imageUrl.startsWith("/")
                    ? Image(
                        image: FileImage(
                        File(widget.imageUrl),
                      ))
                    : widget.imageUrl == ""
                        ? Image.asset("assets/png_image/logo.png",
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high)
                        : Image.network(widget.imageUrl,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high),
              ),
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
                        maxLines: 1,
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
                  widget.price.isEmpty
                      ? Container()
                      : Text(
                          "Rp${widget.price.toString()}",
                          style: AppTextStyles.appTitlew700s12(
                              ColorValues().primaryColor),
                        )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.isShowRating
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            color: ColorValues().starColor,
                            size: 12.sp,
                          ),
                          Text(widget.rating,
                              style: AppTextStyles.appTitlew500s12(
                                  ColorValues().blackColor))
                        ],
                      )
                    : Container(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: ColorValues().primaryColor,
                  size: 12.sp,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
