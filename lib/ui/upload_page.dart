import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/component/loading.dart';
import 'package:trip_boy/component/vertical_card.dart';

import '../common/app_text_styles.dart';
import '../common/color_values.dart';
import '../component/upload_list.dart';

class UploadPage extends StatefulWidget {
  UploadPage({Key? key}) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  int tabIndex = 0;
  bool isLoading = true;
  List<Map> uploadList = [];
  List<Map> listAdded = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    uploadList = [
      {
        "title": AppLocalizations.of(context)!.cullinary,
        "image": "assets/uploadRestaurant.svg"
      },
      {
        "title": AppLocalizations.of(context)!.tour,
        "image": "assets/uploadDestination.svg"
      },
      {
        "title": AppLocalizations.of(context)!.hotel,
        "image": "assets/uploadHotel.svg"
      },
      {
        "title": AppLocalizations.of(context)!.event,
        "image": "assets/uploadEvent.svg"
      }
    ];
    listAdded = [
      {
        "title": "Mountain View Residence Pool",
        "subDistrict": "Bae",
        "price": 25000,
      }
    ];
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width.sp,
            margin: EdgeInsets.only(
                left: 15.sp, right: 15.sp, top: 10.sp, bottom: 10.sp),
            alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        tabIndex = 0;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.sp),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: tabIndex != 0
                              ? ColorValues().tabColor
                              : ColorValues().primaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20))),
                      child: Text(
                        AppLocalizations.of(context)!.upload,
                        style: AppTextStyles.appTitlew500s12(tabIndex == 0
                            ? Colors.white
                            : ColorValues().primaryColor),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        tabIndex = 1;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.sp),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        color: tabIndex != 1
                            ? ColorValues().tabColor
                            : ColorValues().primaryColor,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.added,
                        style: AppTextStyles.appTitlew500s12(tabIndex != 1
                            ? ColorValues().primaryColor
                            : Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          tabIndex == 0 ? buildUploadList() : addedList()
        ],
      ),
    );
  }

  noData() {
    return Expanded(
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset("assets/noDataActivity.svg"),
          Text(
            AppLocalizations.of(context)!.noAdded,
            style: AppTextStyles.appTitlew500s14(ColorValues().blackColor),
          )
        ],
      )),
    );
  }

  buildUploadList() {
    return isLoading
        ? Expanded(child: Loading())
        : UploadList(
            uploadList: uploadList,
          );
  }

  addedList() {
    return listAdded.isEmpty
        ? noData()
        : Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 15.sp, right: 15.sp),
              child: ListView.builder(
                itemCount: listAdded.length,
                itemBuilder: (context, index) => VerticalCard(
                    title: listAdded[index]["title"],
                    subDistrict: listAdded[index]["subDistrict"],
                    price: "Rp${listAdded[index]["price"]}",
                    rating: ""),
              ),
            ),
          );
  }
}
