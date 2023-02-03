import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/component/BuildTextFormField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_boy/component/custom_dialog.dart';
import 'package:trip_boy/models/destination_model.dart';
import 'package:trip_boy/models/facility_model.dart';
import 'package:trip_boy/models/hotel_model.dart';
import 'package:trip_boy/models/images_model.dart';
import 'package:trip_boy/models/restaurant_model.dart';
import 'package:trip_boy/services/database_services.dart';

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
      this.hintText = ""});

  @override
  State<UploadDetail> createState() => _UploadDetailState();
}

class _UploadDetailState extends State<UploadDetail> {
  String hintTextName = "";
  String hintTextDesc = "";
  String hintTextTimeOpen = "";
  String hintTextTimeClose = "";
  String hintTextRoadName = "";
  String hintTextHamletName = "";
  String hintTextVillageName = "";
  String hintTextUrbanVillageName = "";
  String hintTextSubDistrictName = "";
  String hintTextDistrictName = "";
  String hintTextProvinceName = "";
  String hintTextGoogleMapsLinkName = "";
  String hintTextRatingName = "";

  List<ImageModel> imageList = [];
  List<Room> roomList = [
    Room(sizeRoom: "regular", description: "", image: "", priceRoom: 0)
  ];
  List<Menu> menuList = [];
  List<Ticket> ticketList = [
    Ticket(
      name: "dadwaxaw",
      price: 0,
    )
  ];
  final ImagePicker picker = ImagePicker();
  XFile? image;
  ScrollController _scrollController = ScrollController();
  List selectedIndex = [];
  String imageUrl = "";
  late final TextEditingController menuNameController;
  late final TextEditingController menuDescController;
  late final TextEditingController menuPriceController;
  late final TextEditingController nameController;
  late final TextEditingController descController;
  late final TextEditingController timeOpenController;
  late final TextEditingController timeClosedController;
  late final TextEditingController roadNameController;
  late final TextEditingController villageNameController;
  late final TextEditingController hamletNameController;
  late final TextEditingController urbanVillageNameController;
  late final TextEditingController subDistrictNameController;
  late final TextEditingController districtNameController;
  late final TextEditingController provinceNameController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menuNameController = TextEditingController();
    menuDescController = TextEditingController();
    menuPriceController = TextEditingController();
    nameController = TextEditingController();
    descController = TextEditingController();
    timeOpenController = TextEditingController();
    timeClosedController = TextEditingController();
    roadNameController = TextEditingController();
    villageNameController = TextEditingController();
    hamletNameController = TextEditingController();
    urbanVillageNameController = TextEditingController();
    subDistrictNameController = TextEditingController();
    districtNameController = TextEditingController();
    provinceNameController = TextEditingController();
  }

  @override
  void dispose() {
    menuNameController.dispose();
    menuDescController.dispose();
    menuPriceController.dispose();
    nameController.dispose();
    descController.dispose();
    timeOpenController.dispose();
    timeClosedController.dispose();
    roadNameController.dispose();
    villageNameController.dispose();
    hamletNameController.dispose();
    urbanVillageNameController.dispose();
    subDistrictNameController.dispose();
    districtNameController.dispose();
    provinceNameController.dispose();
    super.dispose();
  }

  void clearForm() {
    menuNameController.clear();
    menuDescController.clear();
    menuPriceController.clear();
    nameController.clear();
    descController.clear();
    timeOpenController.clear();
    timeClosedController.clear();
    roadNameController.clear();
    villageNameController.clear();
    hamletNameController.clear();
    urbanVillageNameController.clear();
    subDistrictNameController.clear();
    districtNameController.clear();
    provinceNameController.clear();
  }

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
      hintTextHamletName =
          AppLocalizations.of(context)!.hintTextHamletRestaurant;
      hintTextUrbanVillageName =
          AppLocalizations.of(context)!.hintTextUrbanVillageRestaurant;
      hintTextSubDistrictName =
          AppLocalizations.of(context)!.hintTextSubDistrictRestaurant;
      hintTextDistrictName =
          AppLocalizations.of(context)!.hintTextDistrictRestaurant;
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
      hintTextHamletName =
          AppLocalizations.of(context)!.hintTextHamletDestination;
      hintTextUrbanVillageName =
          AppLocalizations.of(context)!.hintTextUrbanVillageDestination;
      hintTextSubDistrictName =
          AppLocalizations.of(context)!.hintTextSubDistrictDestination;
      hintTextDistrictName =
          AppLocalizations.of(context)!.hintTextDistrictDestination;
      hintTextProvinceName =
          AppLocalizations.of(context)!.hintTextProvinceDestination;
      hintTextGoogleMapsLinkName =
          AppLocalizations.of(context)!.hintTextGoogleMapsDestination;
    } else if (widget.index == 2) {
      hintTextName = AppLocalizations.of(context)!.hintTextNameHotel;
      hintTextDesc = AppLocalizations.of(context)!.hintTextDescHotel;
      hintTextRoadName = AppLocalizations.of(context)!.hintTextRoadNameHotel;
      hintTextHamletName = AppLocalizations.of(context)!.hintTextHamletHotel;
      hintTextUrbanVillageName =
          AppLocalizations.of(context)!.hintTextUrbanVillageHotel;
      hintTextSubDistrictName =
          AppLocalizations.of(context)!.hintTextSubDistrictHotel;
      hintTextDistrictName =
          AppLocalizations.of(context)!.hintTextDistrictHotel;
      hintTextProvinceName =
          AppLocalizations.of(context)!.hintTextProvinceHotel;
      hintTextGoogleMapsLinkName =
          AppLocalizations.of(context)!.hintTextGoogleMapsHotel;
    } else {
      hintTextName = AppLocalizations.of(context)!.hintTextNameEvent;
      hintTextDesc = AppLocalizations.of(context)!.hintTextDescEvent;
    }
  }

  Future<void> showModalBottom(List<ImageModel> imageList) async {
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
                  getImage(ImageSource.gallery, imageList);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  getImage(ImageSource.camera, imageList);
                },
              ),
            ],
          );
        });
  }

  Future getImage(ImageSource media, List imageList) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
      imageList.add(ImageModel(imagesUrl: img!.path));
    });
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
                  //
                  BuildTextFormField(
                    title: AppLocalizations.of(context)!.name,
                    hintText: hintTextName,
                    controller: nameController,
                  ),
                  BuildTextFormField(
                    title: AppLocalizations.of(context)!.description,
                    hintText: hintTextDesc,
                    controller: descController,
                  ),
                  widget.index == 0 || widget.index == 1
                      ? BuildTextFormField(
                          title: AppLocalizations.of(context)!.timeOpen,
                          hintText: hintTextTimeOpen,
                          controller: timeOpenController,
                        )
                      : Container(),
                  widget.index == 0 || widget.index == 1
                      ? BuildTextFormField(
                          title: AppLocalizations.of(context)!.timeClose,
                          hintText: AppLocalizations.of(context)!
                              .hintTextTimeCloseDestination,
                          controller: timeClosedController,
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
                              controller: roadNameController,
                            ),
                            BuildTextFormField(
                              noTitle: true,
                              title: "",
                              hintText: hintTextHamletName,
                              controller: hamletNameController,
                            ),
                            BuildTextFormField(
                              noTitle: true,
                              title: "",
                              hintText: hintTextUrbanVillageName,
                              controller: urbanVillageNameController,
                            ),
                            BuildTextFormField(
                              noTitle: true,
                              title: "",
                              hintText: hintTextSubDistrictName,
                              controller: subDistrictNameController,
                            ),
                            BuildTextFormField(
                              noTitle: true,
                              title: "",
                              hintText: hintTextDistrictName,
                              controller: districtNameController,
                            ),
                            BuildTextFormField(
                              noTitle: true,
                              title: "",
                              hintText: hintTextProvinceName,
                              controller: provinceNameController,
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
                  widget.index == 1 || widget.index == 2
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
                                controller: _scrollController,
                                isAlwaysShown: true,
                                child: SingleChildScrollView(
                                  controller: _scrollController,
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
                  widget.index == 3
                      ? BuildTextFormField(
                          hintText: "",
                          title: AppLocalizations.of(context)!.uploadImage,
                          isUploadImage: true,
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.uploadImage,
                                style: AppTextStyles.appTitlew400s12(
                                    ColorValues().blackColor),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: [
                                  ListBody(
                                    children: [
                                      ...imageList.map(
                                        (item) => item.imagesUrl! != ""
                                            ? Container(
                                                height: 150,
                                                margin:
                                                    EdgeInsets.only(bottom: 10),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: item.imagesUrl!
                                                                .startsWith("/")
                                                            ? Image(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image:
                                                                    FileImage(
                                                                  File(item
                                                                      .imagesUrl!),
                                                                ))
                                                            : Image.network(
                                                                item.imagesUrl!,
                                                                fit: BoxFit
                                                                    .cover,
                                                                filterQuality:
                                                                    FilterQuality
                                                                        .high),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        child: Padding(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      child: IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            imageList
                                                                .remove(item);
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color: ColorValues()
                                                              .primaryColor,
                                                          size: 25,
                                                        ),
                                                      ),
                                                    ))
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                      )
                                    ],
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          showModalBottom(imageList);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                ColorValues().primaryColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        child: Icon(Icons.upload),
                                      ))
                                ],
                              ),
                            ],
                          )),
                  widget.index == 0
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.menu,
                                    style: AppTextStyles.appTitlew400s12(
                                        ColorValues().blackColor),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          CustomDialog.showMenuDialog(
                                              context,
                                              menuNameController,
                                              menuDescController,
                                              menuPriceController,
                                              (val) => imageUrl = val, () {
                                            menuList.add(Menu(
                                                name: menuNameController.text,
                                                desc: menuDescController.text,
                                                price: int.parse(
                                                    menuPriceController.text),
                                                imageUrl: imageUrl));

                                            Navigator.pop(context);
                                            clearForm();
                                          }, () {
                                            Navigator.of(context).pop();
                                            clearForm();
                                          });
                                        });
                                      },
                                      icon: Icon(Icons.add))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: [
                                  ListBody(
                                    children: [
                                      ...menuList.map((item) => Container(
                                            height: 150,
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 100,
                                                        width: 100,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: item.imageUrl!
                                                                  .startsWith(
                                                                      "/")
                                                              ? Image(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image:
                                                                      FileImage(
                                                                    File(item
                                                                        .imageUrl!),
                                                                  ))
                                                              : Image.network(
                                                                  item
                                                                      .imageUrl!,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  filterQuality:
                                                                      FilterQuality
                                                                          .high),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(item.name!),
                                                          Text(item.price!
                                                              .toString()),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                    child: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        menuList.remove(item);
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: ColorValues()
                                                          .primaryColor,
                                                      size: 25,
                                                    ),
                                                  ),
                                                ))
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ))
                      : Container(),
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
                        onPressed: () {
                          DatabaseService().addRestaurantData(
                              "${roadNameController.text},${hamletNameController.text},${villageNameController.text},${urbanVillageNameController.text},${subDistrictNameController.text},${districtNameController.text},${provinceNameController.text}",
                              descController.text,
                              'googleMaspLink',
                              [],
                              [],
                              nameController.text,
                              0,
                              'timeClosed',
                              'timeOpen');
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
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
