import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/color_values.dart';

class UploadList extends StatelessWidget {
  List<Map> uploadList;
  UploadList({Key? key, required this.uploadList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 10.sp),
        child: ListView.separated(
          itemCount: uploadList.length,
          separatorBuilder: (context, index) {
            return Container(
              height: 2.sp,
            );
          },
          itemBuilder: (context, index) {
            return Container(
              height: 125.sp,
              width: MediaQuery.of(context).size.width.sp,
              padding: EdgeInsets.only(left: 15.sp),
              margin: EdgeInsets.only(bottom: 10.sp),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      ColorValues().primaryColor,
                      ColorValues().primaryColor.withOpacity(0.25),
                    ],
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(uploadList[index]["title"],
                      style: AppTextStyles.appTitlew700s16(
                        Colors.white,
                      )),
                  SvgPicture.asset(uploadList[index]["image"])
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
