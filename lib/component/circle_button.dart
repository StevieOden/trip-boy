import 'package:flutter/material.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/color_values.dart';
import 'package:sizer/sizer.dart';

class CircleButton extends StatefulWidget {
  IconData icon;
  String? title;
  void Function()? onTap;
  CircleButton({Key? key, required this.icon, this.title, required this.onTap}) : super(key: key);

  @override
  State<CircleButton> createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: widget.onTap,
      child: Column(
        children: [
          Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(50),
            child: Container(
              height: 45.sp,
              width: 45.sp,
              child: Icon(widget.icon),
            ),
          ),
          SizedBox(
            height: 5.sp,
          ),
          Text(
            widget.title!,
            style: AppTextStyles.appTitlew400s10(ColorValues().primaryColor),
          )
        ],
      ),
    ));
  }
}
