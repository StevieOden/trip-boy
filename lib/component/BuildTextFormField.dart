// ignore: file_names
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/common/color_values.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common/app_text_styles.dart';

class BuildTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool? obsecure;
  final bool? readOnly;
  final VoidCallback? onTap;
  final Function? onTapImage;
  final VoidCallback? onEditingCompleted;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool? isMulti;
  final bool? autofocus;
  final bool? enabled;
  final String? errorText;
  final String? helperText;
  final Widget? suffix;
  final Widget? prefix;
  final String? hintText;
  final String? title;
  final String? currentValue;
  final String? assetImage;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? nextFocusNode;
  final FocusNode? focusNode;
  final bool? isDropDown;
  final bool? isDateForm;
  final bool? isTimeForm;
  final bool? isUploadImage;
  final bool? isCostForm;
  final bool? uploadFile;
  final bool? editFile;
  final bool? isTitle;
  final bool? isFlag;
  final bool? noTitle;
  final List<DropdownMenuItem<String>>? customDropdownItems;
  final String? customSelectedValue;

  BuildTextFormField(
      {this.controller,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.obsecure = false,
      this.onTap,
      this.onTapImage,
      this.isMulti = false,
      this.readOnly = false,
      this.autofocus = false,
      this.errorText,
      this.helperText,
      this.suffix,
      this.prefix,
      this.enabled = true,
      this.onEditingCompleted,
      this.onChanged,
      required this.hintText,
      required this.title,
      this.currentValue,
      this.assetImage = 'assets/images/ktp-sample.png',
      this.inputFormatters,
      // dua node ini nanti di-required
      this.nextFocusNode,
      this.focusNode,
      this.isDropDown = false,
      this.isDateForm = false,
      this.isTimeForm = false,
      this.isUploadImage = false,
      this.isCostForm = false,
      this.uploadFile = false,
      this.editFile = false,
      this.isTitle = true,
      this.isFlag = false,
      this.noTitle = false,
      this.customDropdownItems,
      this.customSelectedValue,
      super.key});

  @override
  State<BuildTextFormField> createState() => _BuildTextFormFieldState();
}

class _BuildTextFormFieldState extends State<BuildTextFormField> {
  String? selectedValue;
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(value: "Laki-laki", child: Text("Laki-laki")),
      DropdownMenuItem(value: "Perempuan", child: Text("Perempuan")),
    ];
    return menuItems;
  }

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  XFile? image;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  Future<void> showModalBottom() async {
    WidgetsFlutterBinding.ensureInitialized();
    // PERMISSION //
    await Permission.camera.request();
    await Permission.storage.request();
    await showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.folder),
                title: const Text('Galeri'),
                onTap: () {
                  Navigator.of(context).pop();
                  getImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  getImage(ImageSource.camera);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isTitle == true
            ? Text(
                widget.title!,
                style: AppTextStyles.appTitlew400s12(ColorValues().blackColor),
              )
            : const SizedBox.shrink(),
        widget.noTitle!
            ? SizedBox()
            : SizedBox(
                height: 5.sp,
              ),
        if (widget.isDropDown == true) ...[
          buildDropDownForm()
        ] else if (widget.isDateForm == true) ...[
          buildDateForm()
        ] else if (widget.isTimeForm == true) ...[
          buildTimeForm()
        ] else if (widget.isUploadImage == true) ...[
          buildTextFieldImage()
        ] else if (widget.isCostForm == true) ...[
          buildCostForm()
        ] else ...[
          buildRegularTextForm()
        ],
        widget.noTitle!
            ? SizedBox()
            : widget.isFlag == true
                ? SizedBox(
                    height: 5.sp,
                  )
                : SizedBox(
                    height: 10.sp,
                  ),
      ],
    );
  }

  Widget buildRegularTextForm() {
    return TextFormField(
      style: AppTextStyles.appTitlew400s12(ColorValues().darkGreyColor),
      onFieldSubmitted: (_) => widget.nextFocusNode?.requestFocus(),
      onChanged: widget.onChanged,
      initialValue: widget.currentValue,
      onEditingComplete: widget.onEditingCompleted,
      autofocus: widget.autofocus!,
      minLines: widget.isMulti! ? 5 : 1,
      maxLines: widget.isMulti! ? null : 1,
      onTap: widget.onTap,
      enabled: widget.enabled,
      readOnly: widget.readOnly!,
      obscureText: widget.obsecure!,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      inputFormatters: widget.inputFormatters,
      // inputFormatters: [FilteringTextInputFormatter.allow(filterPattern)],
      decoration: InputDecoration(
        filled: widget.enabled == true ? false : true,
        fillColor: widget.enabled == true
            ? Colors.white
            : ColorValues().greyColor.withOpacity(0.2),
        errorText: widget.errorText,
        prefixIcon: widget.prefix,
        suffixIcon: widget.suffix,
        hintText: widget.hintText,
        helperText: widget.helperText,
        hintStyle: AppTextStyles.appTitlew400s12(
            ColorValues().darkGreyColor.withOpacity(0.5)),
        contentPadding: EdgeInsets.symmetric(vertical: 0.sp, horizontal: 10.sp),
        // enabledBorder: textFieldfocused(),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.sp),
            borderSide: BorderSide(color: ColorValues().greyColor, width: 2)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorValues().primaryColor, width: 2),
          borderRadius: BorderRadius.circular(5.sp),
        ),
        // errorBorder: errorrTextFieldBorder(),
        // focusedErrorBorder: errorrTextFieldBorder(),
      ),
      validator: widget.validator,
    );
  }

  Widget buildDropDownForm() {
    return DropdownButtonHideUnderline(
      child: SizedBox(
        width: 80.h,
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonFormField(
            style: AppTextStyles.appTitlew400s12(ColorValues().darkGreyColor),
            focusNode: FocusNode(canRequestFocus: false),
            isExpanded: true,
            menuMaxHeight: 300,
            decoration: InputDecoration(
              isDense: true,
              errorText: widget.errorText,
              prefixIcon: widget.prefix,
              suffixIcon: widget.suffix,
              hintText: widget.hintText,
              helperText: widget.helperText,
              hintStyle: AppTextStyles.appTitlew400s12(
                  ColorValues().darkGreyColor.withOpacity(0.5)),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 8.sp, horizontal: 10.sp),
              // enabledBorder: textFieldfocused(),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.sp),
                  borderSide:
                      BorderSide(color: ColorValues().greyColor, width: 2)),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: ColorValues().darkGreyColor, width: 2),
                borderRadius: BorderRadius.circular(5.sp),
              ),
              // errorBorder: errorrTextFieldBorder(),
              // focusedErrorBorder: errorrTextFieldBorder(),
            ),
            items: widget.customDropdownItems ?? dropdownItems,
            value: widget.customSelectedValue ?? selectedValue,
            onChanged: (String? value) {
              setState(() {
                selectedValue = value!;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget buildDateForm() {
    return TextFormField(
      focusNode: FocusNode(canRequestFocus: false),
      controller: dateController,
      style: AppTextStyles.appTitlew400s12(ColorValues().darkGreyColor),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());

        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100));

        // dateController.text = pickedDate.toString();
        if (pickedDate != null) {
          setState(() {
            dateController.text = DateFormat('dd/MM/yy').format(pickedDate);
          });
        }
      },
      // inputFormatters: [FilteringTextInputFormatter.allow(filterPattern)],
      decoration: InputDecoration(
        errorText: widget.errorText,
        prefixIcon: widget.prefix,
        suffixIcon: Icon(
          Icons.calendar_month,
          size: 12.sp,
        ),
        hintText: widget.hintText,
        helperText: widget.helperText,
        hintStyle: AppTextStyles.appTitlew400s12(
            ColorValues().darkGreyColor.withOpacity(0.5)),
        contentPadding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 10.sp),
        // enabledBorder: textFieldfocused(),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.sp),
            borderSide: BorderSide(color: ColorValues().greyColor, width: 2)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorValues().darkGreyColor, width: 2),
          borderRadius: BorderRadius.circular(5.sp),
        ),
        // errorBorder: errorrTextFieldBorder(),
        // focusedErrorBorder: errorrTextFieldBorder(),
      ),
      validator: widget.validator,
    );
  }

  Widget buildTimeForm() {
    return TextFormField(
      focusNode: FocusNode(canRequestFocus: false),
      controller: timeController,
      style: AppTextStyles.appTitlew400s12(ColorValues().darkGreyColor),
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          initialTime: TimeOfDay.now(),
          context: context,
        );

        if (pickedTime != null) {
          // print(pickedTime.format(context)); //output 10:51 PM
          // DateTime parsedTime =
          //     DateFormat.jm().parse(pickedTime.format(context).toString());
          // //converting to DateTime so that we can further format on different pattern.
          // print(parsedTime); //output 1970-01-01 22:53:00.000
          // String formattedTime = DateFormat('HH:mm').format(parsedTime);
          // print(formattedTime); //output 14:59:00
          // //DateFormat() is from intl package, you can format the time on any pattern you need.

          setState(() {
            timeController.text =
                pickedTime.format(context); //set the value of text field.
          });
        } else {
          print("Time is not selected");
        }
      },
      // inputFormatters: [FilteringTextInputFormatter.allow(filterPattern)],
      decoration: InputDecoration(
        errorText: widget.errorText,
        prefixIcon: widget.prefix,
        suffixIcon: Icon(
          Icons.schedule,
          size: 12.sp,
        ),
        hintText: widget.hintText,
        helperText: widget.helperText,
        hintStyle: AppTextStyles.appTitlew400s12(
            ColorValues().darkGreyColor.withOpacity(0.5)),
        contentPadding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 10.sp),
        // enabledBorder: textFieldfocused(),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.sp),
            borderSide: BorderSide(color: ColorValues().greyColor, width: 2)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorValues().darkGreyColor, width: 2),
          borderRadius: BorderRadius.circular(5.sp),
        ),
        // errorBorder: errorrTextFieldBorder(),
        // focusedErrorBorder: errorrTextFieldBorder(),
      ),
      validator: widget.validator,
    );
  }

  Widget buildTextFieldImage() {
    return InkWell(
        onTap: () {
          showModalBottom();
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (image == null) ...[
              if (widget.uploadFile == true) ...[
                Container(
                  width: 100.w,
                  height: 25.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorValues().greyColor),
                      borderRadius: BorderRadius.all(Radius.circular(10.sp))),
                ),
              ] else if (widget.editFile == true) ...[
                Container(
                  width: 100.w,
                  height: 25.h,
                  decoration: BoxDecoration(
                      color: ColorValues().greyColor,
                      borderRadius: BorderRadius.all(Radius.circular(10.sp))),
                ),
              ] else ...[
                Container(
                  width: 100.w,
                  height: 25.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                      color: ColorValues().primaryColor.withOpacity(0.2),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.75),
                              BlendMode.dstATop),
                          image: AssetImage(widget.assetImage!))),
                ),
              ]
            ] else ...[
              Container(
                width: 100.w,
                height: 25.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                    color: Color.fromARGB(255, 21, 19, 19),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.75), BlendMode.dstATop),
                        image: FileImage(
                          File(image!.path),
                        ))),
              )
            ],
            widget.uploadFile != true
                ? SizedBox(
                    child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.edit,
                      color: ColorValues().primaryColor,
                      size: 25,
                    ),
                  ))
                : image != null
                    ? const SizedBox.shrink()
                    : Column(
                        children: [
                          Icon(
                            Icons.upload,
                            color: ColorValues().greyColor,
                            size: 30,
                          ),
                          SizedBox(
                            height: 5.sp,
                          ),
                          Text(
                            AppLocalizations.of(context)!.uploadFile,
                            style: AppTextStyles.appTitlew400s12(
                                ColorValues().greyColor),
                          )
                        ],
                      )
          ],
        ));
  }

  Widget buildCostForm() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            style: AppTextStyles.appTitlew400s12(
              ColorValues().darkGreyColor,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
            ],
            decoration: InputDecoration(
              // controller: ,
              prefixIconConstraints:
                  BoxConstraints(minWidth: 38.sp, minHeight: 38.sp),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Material(
                    color: ColorValues().greyColor.withOpacity(0.4),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      bottomLeft: Radius.circular(5.0),
                    ),
                    child: Image.asset(
                      'assets/icons/rupiah.png',
                      scale: 1.6,
                      width: 30,
                    )),
              ),
              hintText: widget.hintText,
              hintStyle: AppTextStyles.appTitlew400s12(
                ColorValues().darkGreyColor.withOpacity(0.5),
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: 8.sp,
                  horizontal: 10.sp), // enabledBorder: textFieldfocused(),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.sp),
                  borderSide:
                      BorderSide(color: ColorValues().greyColor, width: 2)),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: ColorValues().darkGreyColor, width: 2),
                borderRadius: BorderRadius.circular(5.sp),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10.sp,
        ),
        Text(
          '/ Sesi',
          style: AppTextStyles.appTitlew400s12(ColorValues().darkGreyColor),
        )
      ],
    );
  }
}
