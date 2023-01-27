import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/component/BuildTextFormField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common/color_values.dart';

class UploadDetail extends StatefulWidget {
  String? hintText;
  String hintTextType;
  int index;
  bool? isEditForm;
  UploadDetail(
      {super.key,
      required this.hintTextType,
      required this.index,
      this.isEditForm = false,
      this.hintText});

  @override
  State<UploadDetail> createState() => _UploadDetailState();
}

class _UploadDetailState extends State<UploadDetail> {
  String hintTextName = "";
  String hintTextDesc = "";
  String hintTextTimeOpen = "";
  String hintTextTimeClose = "";
  String hintTextRoadName = "";

  @override
  Widget build(BuildContext context) {
    if (widget.index == 0) {
      hintTextName = AppLocalizations.of(context)!.hintTextNameRestaurant;
      hintTextDesc = AppLocalizations.of(context)!.hintTextDescRestaurant;
    } else if (widget.index == 1) {
      hintTextName = AppLocalizations.of(context)!.hintTextNameDestination;
      hintTextDesc = AppLocalizations.of(context)!.hintTextDescDestination;
    } else if (widget.index == 2) {
      hintTextName = AppLocalizations.of(context)!.hintTextNameHotel;
      hintTextDesc = AppLocalizations.of(context)!.hintTextDescHotel;
    } else {
      hintTextName = AppLocalizations.of(context)!.hintTextNameEvent;
      hintTextDesc = AppLocalizations.of(context)!.hintTextDescEvent;
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorValues().primaryColor),
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.upload + " " + widget.hintTextType,
          style: AppTextStyles.appTitlew500s16(ColorValues().blackColor),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.sp),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 12.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BuildTextFormField(
                  title: AppLocalizations.of(context)!.name,
                  currentValue: widget.isEditForm! ? widget.hintText : "",
                  hintText: hintTextName,
                ),
                BuildTextFormField(
                  title: AppLocalizations.of(context)!.description,
                  currentValue: widget.isEditForm! ? widget.hintText : "",
                  hintText: hintTextDesc,
                ),
                BuildTextFormField(
                  title: AppLocalizations.of(context)!.timeOpen,
                  currentValue: widget.isEditForm! ? widget.hintText : "",
                  hintText:
                      AppLocalizations.of(context)!.hintTextTimeOpenDestination,
                ),
                BuildTextFormField(
                  title: AppLocalizations.of(context)!.timeClose,
                  currentValue: widget.isEditForm! ? widget.hintText : "",
                  hintText: AppLocalizations.of(context)!
                      .hintTextTimeCloseDestination,
                ),
                Text(AppLocalizations.of(context)!.address),
                BuildTextFormField(
                  noTitle: true,
                  title: "",
                  hintText:
                      AppLocalizations.of(context)!.hintTextRoadNameDestination,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
