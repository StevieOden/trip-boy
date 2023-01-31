import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/component/BuildTextFormField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_boy/component/custom_dialog.dart';
import 'package:trip_boy/models/destination_model.dart';
import 'package:trip_boy/models/facility_model.dart';
import 'package:trip_boy/models/hotel_model.dart';
import 'package:trip_boy/models/images_model.dart';

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
  String hintTextVillageName = "";
  String hintTextUrbanVillageName = "";
  String hintTextSubDistrictName = "";
  String hintTextDistrictName = "";
  String hintTextProvinceName = "";
  String hintTextGoogleMapsLinkName = "";
  String hintTextRatingName = "";

  List<ImageModel> imageList = [ImageModel(imagesUrl: "")];
  List<Room> roomList = [
    Room(sizeRoom: "regular", description: "", image: "", priceRoom: 0)
  ];
  List<Ticket> ticketList = [
    Ticket(
      name: "dadwaxaw",
      price: 0,
    )
  ];
  List selectedIndex = [];
  void hintText(context) {
    if (widget.index == 0) {
      hintTextName = AppLocalizations.of(context)!.hintTextNameRestaurant;
      hintTextDesc = AppLocalizations.of(context)!.hintTextDescRestaurant;
      hintTextTimeOpen =
          AppLocalizations.of(context)!.hintTextTimeOpenRestaurant;
      hintTextTimeClose =
          AppLocalizations.of(context)!.hintTextTimeCloseRestaurant;
      hintTextRoadName =
          AppLocalizations.of(context)!.hintTextRoadNameRestaurant;
      hintTextVillageName =
          AppLocalizations.of(context)!.hintTextVillageRestaurant;
      hintTextUrbanVillageName =
          AppLocalizations.of(context)!.hintTextUrbanVillageRestaurant;
      hintTextProvinceName =
          AppLocalizations.of(context)!.hintTextProvinceRestaurant;
      hintTextGoogleMapsLinkName =
          AppLocalizations.of(context)!.hintTextGoogleMapsRestaurant;
    } else if (widget.index == 1) {
      hintTextName = AppLocalizations.of(context)!.hintTextNameDestination;
      hintTextDesc = AppLocalizations.of(context)!.hintTextDescDestination;
      hintTextTimeOpen =
          AppLocalizations.of(context)!.hintTextTimeOpenDestination;
      hintTextTimeClose =
          AppLocalizations.of(context)!.hintTextTimeCloseDestination;
      hintTextRoadName =
          AppLocalizations.of(context)!.hintTextRoadNameDestination;
      hintTextVillageName =
          AppLocalizations.of(context)!.hintTextVillageDestination;
      hintTextUrbanVillageName =
          AppLocalizations.of(context)!.hintTextUrbanVillageDestination;
      hintTextProvinceName =
          AppLocalizations.of(context)!.hintTextProvinceDestination;
      hintTextGoogleMapsLinkName =
          AppLocalizations.of(context)!.hintTextGoogleMapsDestination;
    } else if (widget.index == 2) {
      hintTextName = AppLocalizations.of(context)!.hintTextNameHotel;
      hintTextDesc = AppLocalizations.of(context)!.hintTextDescHotel;
      hintTextRoadName = AppLocalizations.of(context)!.hintTextRoadNameHotel;
      hintTextVillageName = AppLocalizations.of(context)!.hintTextVillageHotel;
      hintTextUrbanVillageName =
          AppLocalizations.of(context)!.hintTextUrbanVillageHotel;
      hintTextProvinceName =
          AppLocalizations.of(context)!.hintTextProvinceHotel;
      hintTextGoogleMapsLinkName =
          AppLocalizations.of(context)!.hintTextGoogleMapsHotel;
    } else {
      hintTextName = AppLocalizations.of(context)!.hintTextNameEvent;
      hintTextDesc = AppLocalizations.of(context)!.hintTextDescEvent;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Facility> facilityList = [
      Facility(name: "toilet"),
      Facility(name: "mosque"),
      Facility(name: "restaurant"),
      Facility(name: "swimming pool"),
      Facility(name: "wifi"),
      Facility(name: "smoking area"),
      Facility(name: "free breakfast"),
      Facility(name: "bar"),
      Facility(name: "easy reservation"),
      Facility(name: "playground")
    ];
    hintText(context);
    FocusScopeNode currentFocus = FocusScope.of(context);
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
      body: GestureDetector(
        onTap: () {
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
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
                  widget.index == 0 || widget.index == 1
                      ? BuildTextFormField(
                          title: AppLocalizations.of(context)!.timeOpen,
                          currentValue:
                              widget.isEditForm! ? widget.hintText : "",
                          hintText: hintTextTimeOpen,
                        )
                      : Container(),
                  widget.index == 0 || widget.index == 1
                      ? BuildTextFormField(
                          title: AppLocalizations.of(context)!.timeClose,
                          currentValue:
                              widget.isEditForm! ? widget.hintText : "",
                          hintText: AppLocalizations.of(context)!
                              .hintTextTimeCloseDestination,
                        )
                      : Container(),
                  widget.index != 3
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!.address),
                            BuildTextFormField(
                              noTitle: true,
                              title: "",
                              hintText: hintTextRoadName,
                            ),
                            BuildTextFormField(
                              noTitle: true,
                              title: "",
                              hintText: hintTextVillageName,
                            ),
                            BuildTextFormField(
                              noTitle: true,
                              title: "",
                              hintText: hintTextUrbanVillageName,
                            ),
                            BuildTextFormField(
                              noTitle: true,
                              title: "",
                              hintText: hintTextUrbanVillageName,
                            ),
                            BuildTextFormField(
                              noTitle: true,
                              title: "",
                              hintText: hintTextProvinceName,
                            ),
                          ],
                        )
                      : Container(),
                  SizedBox(
                    height: 10,
                  ),
                  widget.index != 3
                      ? BuildTextFormField(
                          noTitle: false,
                          title: AppLocalizations.of(context)!.googleMapsLink,
                          currentValue:
                              widget.isEditForm! ? widget.hintText : "",
                          hintText: hintTextGoogleMapsLinkName,
                        )
                      : Container(),
                  widget.index == 0 || widget.index == 2
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.facilities,
                              style: AppTextStyles.appTitlew400s12(
                                  ColorValues().blackColor),
                            ),
                            Container(
                              height: 200,
                              margin: EdgeInsets.symmetric(vertical: 10.sp),
                              child: Scrollbar(
                                isAlwaysShown: true,
                                child: SingleChildScrollView(
                                  child: ListBody(children: [
                                    ...facilityList
                                        .map((item) => CheckboxListTile(
                                              value: selectedIndex
                                                  .contains(item.name!),
                                              onChanged: (_isChecked) => {
                                                setState(() {
                                                  _itemChange(
                                                      item.name!, _isChecked!);
                                                })
                                              },
                                              title: Text(
                                                item.name!
                                                        .substring(0, 1)
                                                        .toUpperCase() +
                                                    item.name!
                                                        .substring(1,
                                                            item.name!.length)
                                                        .toLowerCase(),
                                                style: AppTextStyles
                                                    .appTitlew400s10(
                                                        ColorValues()
                                                            .blackColor),
                                              ),
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                            ))
                                        .toList(),
                                  ]),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  BuildTextFormField(
                    hintText: "",
                    title: AppLocalizations.of(context)!.uploadImage,
                    isUploadImage: true,
                  ),
                  widget.index == 1
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.tickets,
                                  style: AppTextStyles.appTitlew400s12(
                                      ColorValues().blackColor),
                                ),
                                IconButton(
                                    onPressed: () {}, icon: Icon(Icons.add))
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    thickness: 1,
                                    color: ColorValues().greyColor,
                                  );
                                },
                                itemCount: ticketList.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(ticketList[index].name!),
                                          Text(ticketList[index]
                                              .price!
                                              .toString()),
                                        ],
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              ticketList.removeAt(index);
                                            });
                                          },
                                          icon: Icon(Icons.delete))
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorValues().primaryColor),
                        child: Text(AppLocalizations.of(context)!.save)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // showFacilityDialog(
  //   BuildContext context,
  //   List<Facility> facilities,
  // ) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         insetPadding:
  //             EdgeInsets.symmetric(horizontal: 15.sp, vertical: 25.sp),
  //         shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(10.sp))),
  //         title: Text(AppLocalizations.of(context)!.uploadFacility,
  //             style: AppTextStyles.appTitlew500s16(ColorValues().blackColor)),
  //         content: Container(
  //           height: MediaQuery.of(context).size.height,
  //           width: MediaQuery.of(context).size.width,
  //           child:
  //         ),
  //         actions: [
  //           TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text(AppLocalizations.of(context)!.cancel)),
  //           TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text(AppLocalizations.of(context)!.save)),
  //         ],
  //       );
  //     },
  //   );
  // }

  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        print(itemValue);
        selectedIndex.add(itemValue);
      } else {
        print(itemValue + " remove");
        selectedIndex.remove(itemValue);
      }
      print(selectedIndex);
    });
  }
}
