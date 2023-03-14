import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/color_values.dart';
import 'package:trip_boy/component/BuildTextFormField.dart';

typedef void StringCallback(String val);

class CustomDialog {
  static showNoInternetConnectionDialog(
    BuildContext context,
  ) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                "assets/svg_image/noConnection.svg",
                height: 100.sp,
              ),
              Text(
                AppLocalizations.of(context)!.noConnection,
                style: AppTextStyles.appTitlew500s14(ColorValues().blackColor),
              )
            ],
          ),
        ),
      ),
    );
  }

  static showUploadTicketDialog(
    BuildContext context,
    TextEditingController _ticketNameController,
    TextEditingController _ticketPriceController,
    Function? saveButton,
    Function? cancelButton,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 10),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.sp))),
            title: Text(AppLocalizations.of(context)!.tickets),
            content: Container(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BuildTextFormField(
                      controller: _ticketNameController,
                      obsecure: false,
                      title: AppLocalizations.of(context)!.ticketName,
                      hintText: AppLocalizations.of(context)!.fillTicketName,
                    ),
                    BuildTextFormField(
                      keyboardType: TextInputType.number,
                      controller: _ticketPriceController,
                      title: AppLocalizations.of(context)!.ticketPrice,
                      hintText: AppLocalizations.of(context)!.fillTicketPrice,
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

  static showRoomHotelDialog(
    BuildContext context,
    TextEditingController _sizeRoomController,
    TextEditingController _descRoomController,
    TextEditingController _priceRoomController,
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
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.sp))),
            title: Text(AppLocalizations.of(context)!.room),
            content: Container(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BuildTextFormField(
                      controller: _sizeRoomController,
                      obsecure: false,
                      title: AppLocalizations.of(context)!.sizeRoom,
                      hintText: AppLocalizations.of(context)!.fillSizeRoom,
                    ),
                    BuildTextFormField(
                      controller: _descRoomController,
                      title: AppLocalizations.of(context)!.descRoom,
                      hintText: AppLocalizations.of(context)!.fillDescRoom,
                    ),
                    BuildTextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                      controller: _priceRoomController,
                      title: AppLocalizations.of(context)!.priceRoom,
                      hintText: AppLocalizations.of(context)!.fillPriceRoom,
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

  static showTermsDialog(
    BuildContext context,
    TextEditingController _termsController,
    Function? saveButton,
    Function? cancelButton,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 10),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.sp))),
            title: Text(AppLocalizations.of(context)!.termTitle),
            content: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BuildTextFormField(
                    isTitle: false,
                    controller: _termsController,
                    obsecure: false,
                    title: "",
                    hintText: AppLocalizations.of(context)!.fillTerm,
                  ),
                ],
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

  static showMenuDialog(
    BuildContext context,
    TextEditingController _menuNameController,
    TextEditingController _descNameController,
    TextEditingController _priceNameController,
    TextEditingController _menuTypeController,
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
                      controller: _menuTypeController,
                      title: AppLocalizations.of(context)!.menuType,
                      hintText: AppLocalizations.of(context)!.fillMenuType,
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

  static showWarningProfileIncomplete(
      BuildContext context, Function() navigate) {
    showDialog(
      barrierColor: Colors.black54,
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            backgroundColor: Colors.red[300],
            contentPadding: EdgeInsets.all(0),
            insetPadding: EdgeInsets.all(10),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.sp))),
            content: Container(
              padding: EdgeInsets.only(right: 15.sp, top: 5.sp, bottom: 5.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    'assets/svg_image/fillPhoneNum.svg',
                    height: 90,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!
                          .warningIncompleteProfileData,
                      style: AppTextStyles.appTitlew500s14(Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: navigate,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      child: Text(
                        AppLocalizations.of(context)!.warningButton,
                        style: AppTextStyles.appTitlew500s10(
                            ColorValues().redColor),
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static showConfirmation(
      BuildContext context, Function() action, Widget content) {
    showDialog(
      barrierColor: Colors.black54,
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.sp))),
            content: Container(
                padding: EdgeInsets.only(right: 15.sp, top: 5.sp, bottom: 5.sp),
                child: content),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'No',
                    style: AppTextStyles.appTitlew400s14(
                        ColorValues().primaryColor),
                  )),
              TextButton(
                onPressed: action,
                child: Text(
                  'Yes',
                  style:
                      AppTextStyles.appTitlew400s14(ColorValues().primaryColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static showPaymentConfirmationAdmin(
      BuildContext context, Function() action,Function() rejectAction, Widget content) {
    showDialog(
      barrierColor: Colors.black54,
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            insetPadding: EdgeInsets.all(20),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.sp))),
            content: Container(
                padding: EdgeInsets.only(
                    left: 15.sp, right: 15.sp, top: 5.sp, bottom: 5.sp),
                child: content),
            actions: [
              TextButton(
                  onPressed: rejectAction,
                  child: Text(
                    'Reject',
                    style: AppTextStyles.appTitlew400s14(
                        ColorValues().primaryColor),
                  )),
              TextButton(
                onPressed: action,
                child: Text(
                  'Accept',
                  style:
                      AppTextStyles.appTitlew400s14(ColorValues().primaryColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
