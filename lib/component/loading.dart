import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trip_boy/common/color_values.dart';
import 'package:sizer/sizer.dart';

class Loading extends StatefulWidget {
  Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      color: ColorValues().primaryColor,
      duration: Duration(milliseconds: 1400),
      size: 50.0.sp,
    );
  }

  showAlertDialog(BuildContext context) {
    showDialog(
      barrierColor: Colors.black26,
      context: context,
      builder: (BuildContext context) {
        return SpinKitFadingCircle(
          color: ColorValues().primaryColor,
          duration: Duration(milliseconds: 1400),
          size: 50.0.sp,
        );
      },
    );
  }
}
