import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_boy/common/color_values.dart';
import 'package:trip_boy/component/BuildTextFormField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_boy/models/images_model.dart';
import '../common/app_text_styles.dart';
import '../models/facility_model.dart';

typedef void StringCallback(String val);

class CustomDialog {
  static showMenuDialog(
    BuildContext context,
    TextEditingController _menuNameController,
    TextEditingController _descNameController,
    TextEditingController _priceNameController,
    StringCallback imageUrl,
    Function? saveButton,
    Function? cancelButton,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 10),
            contentPadding: EdgeInsets.all(15.sp),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.sp))),
            title: Row(
              children: [Text(AppLocalizations.of(context)!.menu)],
            ),
            content: Container(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BuildTextFormField(
                      controller: _menuNameController,
                      obsecure: false,
                      title: AppLocalizations.of(context)!.menuName,
                      hintText: AppLocalizations.of(context)!.fillMenuName,
                    ),
                    BuildTextFormField(
                      controller: _descNameController,
                      title: AppLocalizations.of(context)!.descMenu,
                      hintText: AppLocalizations.of(context)!.fillDescMenu,
                    ),
                    BuildTextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                      controller: _priceNameController,
                      title: AppLocalizations.of(context)!.priceMenu,
                      hintText: AppLocalizations.of(context)!.fillPriceMenu,
                    ),
                    BuildTextFormField(
                      hintText: "",
                      title: AppLocalizations.of(context)!.uploadImage,
                      isUploadImage: true,
                      imagePath: (val) => setState(() => imageUrl(val)),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: TextStyle(
                      fontSize: 15, color: ColorValues().primaryColor),
                ),
                onPressed: () {
                  cancelButton!.call();
                },
              ),
              TextButton(
                child: Text(
                  AppLocalizations.of(context)!.save,
                  style: TextStyle(
                      fontSize: 15, color: ColorValues().primaryColor),
                ),
                onPressed: () {
                 
                  saveButton!.call();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
