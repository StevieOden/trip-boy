import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/color_values.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AlertDialogComponent extends StatelessWidget {
  BuildContext context;
  Function()? onPressedYes;
  String title;
  Widget content;
  bool exitButton;
  AlertDialogComponent({
    Key? key,
    required this.context,
    required this.onPressedYes,
    required this.title,
    required this.content,
    this.exitButton = false,
  }) : super(key: key);

  @override
  Widget build(context) {
    return AlertDialog(
      title: title == "" ? null : Text(title),
      content: content,
      actions: <Widget>[
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'No',
              style: AppTextStyles.appTitlew400s14(ColorValues().primaryColor),
            )),
        TextButton(
          onPressed: () => exitButton ? exit(0) : onPressedYes,
          child: Text(
            'Yes',
            style: AppTextStyles.appTitlew400s14(ColorValues().primaryColor),
          ),
        ),
      ],
    );
  }
}
