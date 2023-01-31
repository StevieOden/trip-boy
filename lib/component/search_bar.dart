import 'package:flutter/material.dart';

import '../common/app_text_styles.dart';
import '../common/color_values.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchBar extends StatefulWidget {
  TextEditingController? controller;
  Function(String)? onChanged;
  SearchBar({Key? key, this.controller, this.onChanged}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(primary: ColorValues().primaryColor)),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        child: TextField(
          controller: widget.controller,
          onChanged: (value) {
            setState(() {
              widget.onChanged!.call(value);
            });
          },
          cursorColor: ColorValues().primaryColor,
          style: AppTextStyles.appTitlew400s12(ColorValues().darkGreyColor),
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.search),
            suffixIconColor: ColorValues().greyColor,
            hintText: AppLocalizations.of(context)!.search,
            hintStyle: AppTextStyles.appTitlew400s12(ColorValues().greyColor),
            filled: true,
            fillColor: Colors.white,
            hoverColor: ColorValues().primaryColor,
            contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorValues().primaryColor),
                borderRadius: BorderRadius.circular(10)),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
    );
  }
}
