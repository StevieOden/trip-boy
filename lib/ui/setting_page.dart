import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/color_values.dart';
import 'package:trip_boy/component/alert_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_boy/component/loading.dart';

import '../main.dart';

class SettingPage extends StatefulWidget {
  Locale myLocale;
  SettingPage({super.key, required this.myLocale});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List<String> languages = [
    "Indonesia",
    "English",
  ];

  List<String> languagesId = [
    "id",
    "en",
  ];
  String? dropdownValue;
  bool _isLoading = false;
  int langId = 0;

  void _setLoading(bool loading) {
    if (mounted) {
      setState(() {
        _isLoading = loading;
      });
    } else {
      _isLoading = loading;
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.myLocale);
    langId =
        languagesId.indexWhere((element) => element == "${widget.myLocale}");
    dropdownValue = languages[langId];
    print(dropdownValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorValues().primaryColor,
      ),
      bottomSheet: Container(
        padding: EdgeInsets.only(bottom: 20.sp),
        margin: EdgeInsets.symmetric(horizontal: 15.sp),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 35.sp,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: ColorValues().primaryColor),
            child: Text(AppLocalizations.of(context)!.save),
            onPressed: () async {
              setState(() {
                _setLoading(true);
                var id =
                    languages.indexWhere((element) => element == dropdownValue);
                var languagesCode = languagesId[id];
                if (dropdownValue != languages[langId]) {
                  MyApp.of(context)!.setLocale(
                      Locale.fromSubtags(languageCode: languagesCode));
                  Navigator.pop(context);
                } else {
                  final snackBar = SnackBar(
                    duration: Duration(seconds: 1),
                    content: const Text('You haven\'t changed anything!'),
                    backgroundColor: (Colors.black54),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                _setLoading(false);
              });
            },
          ),
        ),
      ),
      body: _isLoading
          ? Loading()
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 15.sp),
              child: Column(
                children: [buildSettingBtn()],
              ),
            ),
    );
  }

  Widget buildSettingBtn() {
    return Container(
      margin: EdgeInsets.only(bottom: 5, top: 5.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.changeLang,
            style: AppTextStyles.appTitlew500s14(ColorValues().blackColor),
          ),
          Container(
              margin: EdgeInsets.only(bottom: 5, top: 2.sp),
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(color: ColorValues().greyColor),
                  borderRadius: BorderRadius.circular(10)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  isExpanded: true,
                  value: dropdownValue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: languages.map((items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                ),
              )),
        ],
      ),
    );
  }
}
