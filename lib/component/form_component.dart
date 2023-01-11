import 'package:flutter/material.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/color_values.dart';

class FormComponent extends StatelessWidget {
  String title;
  String? initialValue;
  TextEditingController controller;
  FormComponent(
      {Key? key,
      required this.title,
      required this.controller,
      this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: AppTextStyles.appTitlew500s12(ColorValues().blackColor),
        ),
        TextFormField(controller: controller, initialValue: initialValue, decoration: InputDecoration(fillColor: ColorValues().greyColor),),
      ],
    );
  }
}
