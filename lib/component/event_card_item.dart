import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/color_values.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventCardItem extends StatelessWidget {
  String? asset;
  String title, dateHeld, ticketType;
  int price;
  EventCardItem(
      {Key? key,
      this.asset,
      required this.title,
      required this.dateHeld,
      required this.ticketType,
      required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: MediaQuery.of(context).size.width.sp,
        child: Column(
          children: [
            asset == null
                ? Container(
                    height: 90.sp,
                    width: MediaQuery.of(context).size.width.sp,
                    decoration: BoxDecoration(
                        color: ColorValues().primaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12))),
                  )
                : asset!.endsWith("png")
                    ? Image(
                        image: AssetImage(asset!),
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width.sp,
                        height: 125.sp,
                      )
                    : SvgPicture.asset(asset!),
            Container(
              margin: EdgeInsets.only(
                  left: 15.sp, right: 15.sp, top: 5.sp, bottom: 5.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:
                        AppTextStyles.appTitlew700s14(ColorValues().blackColor),
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                  Row(children: [
                    Icon(
                      Icons.calendar_month,
                      color: ColorValues().primaryColor,
                    ),
                    SizedBox(
                      width: 5.sp,
                    ),
                    Text(dateHeld,
                        style: AppTextStyles.appTitlew400s10(
                            ColorValues().greyColor)),
                  ]),
                  Row(children: [
                    Icon(Icons.confirmation_number,
                        color: ColorValues().primaryColor),
                    SizedBox(
                      width: 5.sp,
                    ),
                    Text(ticketType,
                        style: AppTextStyles.appTitlew400s10(
                            ColorValues().greyColor)),
                  ]),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              color: Color(0xFFD7D7D7),
            ),
            Container(
              margin: EdgeInsets.only(left: 15.sp, right: 15.sp, bottom: 8.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    price == 0
                        ? AppLocalizations.of(context)!.free
                        : "Rp$price",
                    style: AppTextStyles.appTitlew700s12(
                        ColorValues().primaryColor),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: ColorValues().primaryColor,
                    size: 16,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
