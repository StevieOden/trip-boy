import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/component/BuildTextFormField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_boy/component/custom_dialog.dart';
import 'package:trip_boy/component/loading.dart';
import 'package:trip_boy/models/hotel_model.dart';
import 'package:trip_boy/services/database_services.dart';

import '../../../common/color_values.dart';
import '../../../models/content_model.dart';
import '../../../models/destination_model.dart';
import '../../../models/restaurant_model.dart';

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
  String imageUrl = "";

  List<ImageModelRestaurant> imageList = [];
  List<RoomHotel> roomList = [
    RoomHotel(sizeRoom: "regular", description: "", imageUrl: "", priceRoom: 0)
  ];
  List<MenuRestaurant> menuList = [];
  List<TicketDestination> ticketList = [];
  List selectedIndex = [];

  bool _isLoading = false;
  bool ticketType = false;

  //payment method variable
  bool bcaValue = false;
  bool mandiriValue = false;
  bool briValue = false;
  bool bniValue = false;
  bool ovoValue = false;
  bool danaValue = false;

  final ImagePicker picker = ImagePicker();
  XFile? image;
  ScrollController _scrollController = ScrollController();
  ScrollController _parentScrollController = ScrollController();

  late final TextEditingController menuNameController;
  late final TextEditingController menuDescController;
  late final TextEditingController menuPriceController;

  late final TextEditingController ticketNameController;
  late final TextEditingController ticketPriceController;

  late final TextEditingController _sizeRoomController;
  late final TextEditingController _descRoomController;
  late final TextEditingController _priceRoomController;

  late final TextEditingController nameController;
  late final TextEditingController descController;
  late final TextEditingController timeOpenController;
  late final TextEditingController timeClosedController;
  late final TextEditingController timeHeldController;
  late final TextEditingController dateHeldController;
  late final TextEditingController timeHeldCloseController;
  late final TextEditingController roadNameController;
  late final TextEditingController hamletNameController;
  late final TextEditingController urbanVillageNameController;
  late final TextEditingController subDistrictNameController;
  late final TextEditingController districtNameController;
  late final TextEditingController provinceNameController;
  late final TextEditingController googleMapsController;
  late final TextEditingController ratingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menuNameController = TextEditingController();
    menuDescController = TextEditingController();
    menuPriceController = TextEditingController();

    ticketNameController = TextEditingController();
    ticketPriceController = TextEditingController();

    _sizeRoomController = TextEditingController();
    _descRoomController = TextEditingController();
    _priceRoomController = TextEditingController();

    nameController = TextEditingController();
    descController = TextEditingController();
    timeOpenController = TextEditingController();
    timeClosedController = TextEditingController();
    timeHeldController = TextEditingController();
    timeHeldCloseController = TextEditingController();
    dateHeldController = TextEditingController();
    roadNameController = TextEditingController();
    hamletNameController = TextEditingController();
    urbanVillageNameController = TextEditingController();
    subDistrictNameController = TextEditingController();
    districtNameController = TextEditingController();
    provinceNameController = TextEditingController();
    googleMapsController = TextEditingController();
    ratingController = TextEditingController();
  }

  @override
  void dispose() {
    menuNameController.dispose();
    menuDescController.dispose();
    menuPriceController.dispose();
    ticketNameController.dispose();
    ticketPriceController.dispose();
    _sizeRoomController.dispose();
    _descRoomController.dispose();
    _priceRoomController.dispose();
    nameController.dispose();
    descController.dispose();
    timeOpenController.dispose();
    timeClosedController.dispose();
    timeHeldController.dispose();
    timeHeldCloseController.dispose();
    roadNameController.dispose();
    dateHeldController.dispose();
    hamletNameController.dispose();
    urbanVillageNameController.dispose();
    subDistrictNameController.dispose();
    districtNameController.dispose();
    provinceNameController.dispose();
    googleMapsController.dispose();
    ratingController.dispose();
    super.dispose();
  }

  void setLoading(bool loading) {
    if (mounted) {
      setState(() {
        _isLoading = loading;
      });
    } else {
      _isLoading = loading;
    }
  }

  void clearForm() {
    menuNameController.clear();
    menuDescController.clear();
    menuPriceController.clear();
    ticketNameController.clear();
    ticketPriceController.clear();
    _sizeRoomController.clear();
    _descRoomController.clear();
    _priceRoomController.clear();
    nameController.clear();
    descController.clear();
    timeOpenController.clear();
    timeClosedController.clear();
    timeHeldController.clear();
    dateHeldController.clear();
    timeHeldCloseController.clear();
    roadNameController.clear();
    hamletNameController.clear();
    urbanVillageNameController.clear();
    subDistrictNameController.clear();
    districtNameController.clear();
    provinceNameController.clear();
    googleMapsController.clear();
    ratingController.clear();
    imageList.clear();
    menuList.clear();
  }

  void hintText(context) {
    if (widget.index == 0) {
      hintTextName = AppLocalizations.of(context)!.hintTextNameRestaurant;
      hintTextDesc = AppLocalizations.of(context)!.hintTextDescRestaurant;
      hintTextRatingName =
          AppLocalizations.of(context)!.hintTextRatingRestaurant;
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

  Future<void> showModalBottom(List imageList) async {
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

  Future<void> addToDatabase() async {
    try {
      setLoading(true);
      DatabaseService().addRestaurantData(
          "${roadNameController.text},${hamletNameController.text},${urbanVillageNameController.text},${subDistrictNameController.text},${districtNameController.text},${provinceNameController.text}",
          descController.text,
          googleMapsController.text,
          imageList,
          menuList,
          nameController.text,
          double.parse(ratingController.text),
          timeClosedController.text,
          timeOpenController.text);
      clearForm();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: ColorValues().primaryColor.withOpacity(0.2),
        content: Text(AppLocalizations.of(context)!.dataSave),
      ));
      setLoading(false);
    } catch (e) {
      throw e.toString();
    }
  }

  Future getImage(ImageSource media, List imageList) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
      imageList.add(ImageModel(imageUrl: img!.path));
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
    return GestureDetector(
      onTap: () {
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: ColorValues().primaryColor),
          elevation: 0,
          title: Text(
            AppLocalizations.of(context)!.upload + " " + widget.hintTextType,
            style: AppTextStyles.appTitlew500s16(ColorValues().blackColor),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: _isLoading
            ? Loading()
            : Container(
                margin: EdgeInsets.symmetric(horizontal: 12.sp),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _parentScrollController,
                        child: Container(
                          padding: EdgeInsets.only(top: 12.sp),
                          child: Column(
                            children: [
                              widget.index == 0
                                  ? buildRestaurant()
                                  : widget.index == 1
                                      ? buildDestination(facilityList)
                                      : widget.index == 2
                                          ? buildHotel(facilityList)
                                          : buildEvent()
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: () {
                            addToDatabase();
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
    );
  }

  Widget buildRestaurant() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          BuildTextFormField(
            isTimeForm: true,
            title: AppLocalizations.of(context)!.timeOpen,
            hintText: hintTextTimeOpen,
            controller: timeOpenController,
          ),
          BuildTextFormField(
            isTimeForm: true,
            title: AppLocalizations.of(context)!.timeClose,
            hintText:
                AppLocalizations.of(context)!.hintTextTimeCloseDestination,
            controller: timeClosedController,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildTextFormField(
                title: AppLocalizations.of(context)!.address,
                hintText: hintTextRoadName,
                controller: roadNameController,
              ),
              BuildTextFormField(
                isTitle: false,
                title: "",
                hintText: hintTextHamletName,
                controller: hamletNameController,
              ),
              BuildTextFormField(
                isTitle: false,
                title: "",
                hintText: hintTextUrbanVillageName,
                controller: urbanVillageNameController,
              ),
              BuildTextFormField(
                isTitle: false,
                title: "",
                hintText: hintTextSubDistrictName,
                controller: subDistrictNameController,
              ),
              BuildTextFormField(
                isTitle: false,
                title: "",
                hintText: hintTextDistrictName,
                controller: districtNameController,
              ),
              BuildTextFormField(
                isTitle: false,
                title: "",
                hintText: hintTextProvinceName,
                controller: provinceNameController,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          BuildTextFormField(
            title: AppLocalizations.of(context)!.googleMapsLink,
            controller: googleMapsController,
            hintText: hintTextGoogleMapsLinkName,
          ),
          SizedBox(
            height: 10,
          ),
          BuildTextFormField(
            title: AppLocalizations.of(context)!.rating + " range (0.0 - 5.0)",
            controller: ratingController,
            hintText: hintTextRatingName,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            isMaxLength: true,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0.0-5.0]')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.menu,
                style: AppTextStyles.appTitlew400s12(ColorValues().blackColor),
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
                        menuList.add(MenuRestaurant(
                            name: menuNameController.text,
                            desc: menuDescController.text,
                            price: int.parse(menuPriceController.text),
                            imageUrl: imageUrl));

                        Navigator.pop(context);
                        menuNameController.clear();
                        menuDescController.clear();
                        menuPriceController.clear();
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
          Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.uploadImage,
                    style:
                        AppTextStyles.appTitlew400s12(ColorValues().blackColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      ListBody(
                        children: [
                          ...imageList.map(
                            (item) => item.imageUrl != ""
                                ? Container(
                                    height: 150,
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: item.imageUrl.startsWith("/")
                                                ? Image(
                                                    fit: BoxFit.cover,
                                                    image: FileImage(
                                                      File(item.imageUrl),
                                                    ))
                                                : Image.network(item.imageUrl,
                                                    fit: BoxFit.cover,
                                                    filterQuality:
                                                        FilterQuality.high),
                                          ),
                                        ),
                                        SizedBox(
                                            child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                imageList.remove(item);
                                              });
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: ColorValues().primaryColor,
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
                                backgroundColor: ColorValues().primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: Icon(Icons.upload),
                          ))
                    ],
                  ),
                ],
              )),
          SizedBox(
            height: 10,
          ),
          Text(
            AppLocalizations.of(context)!.paymentMethod,
            style: AppTextStyles.appTitlew400s12(ColorValues().blackColor),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                      width: 60,
                      height: 30,
                      image: AssetImage("assets/png_image/bca-logo.png")),
                  Switch(
                    value: bcaValue,
                    activeColor: ColorValues().primaryColor,
                    onChanged: (value) {
                      setState(() {
                        bcaValue = value;
                      });
                    },
                  )
                ],
              ),
              bcaValue
                  ? BuildTextFormField(
                      isTitle: false,
                      hintText:
                          AppLocalizations.of(context)!.enterAccountPhoneNum,
                      title: "")
                  : Container()
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                      width: 60,
                      height: 30,
                      image: AssetImage("assets/png_image/mandiri-logo.png")),
                  Switch(
                    value: mandiriValue,
                    activeColor: ColorValues().primaryColor,
                    onChanged: (value) {
                      setState(() {
                        mandiriValue = value;
                      });
                    },
                  )
                ],
              ),
              mandiriValue
                  ? BuildTextFormField(
                      isTitle: false,
                      hintText:
                          AppLocalizations.of(context)!.enterAccountPhoneNum,
                      title: "")
                  : Container()
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                      width: 60,
                      height: 30,
                      image: AssetImage("assets/png_image/bri-logo.png")),
                  Switch(
                    value: briValue,
                    activeColor: ColorValues().primaryColor,
                    onChanged: (value) {
                      setState(() {
                        briValue = value;
                      });
                    },
                  )
                ],
              ),
              briValue
                  ? BuildTextFormField(
                      isTitle: false,
                      hintText:
                          AppLocalizations.of(context)!.enterAccountPhoneNum,
                      title: "")
                  : Container()
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                      width: 60,
                      height: 30,
                      image: AssetImage("assets/png_image/bni-logo.png")),
                  Switch(
                    value: bniValue,
                    activeColor: ColorValues().primaryColor,
                    onChanged: (value) {
                      setState(() {
                        bniValue = value;
                      });
                    },
                  )
                ],
              ),
              bniValue
                  ? BuildTextFormField(
                      isTitle: false,
                      hintText:
                          AppLocalizations.of(context)!.enterAccountPhoneNum,
                      title: "")
                  : Container()
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                      width: 60,
                      height: 30,
                      image: AssetImage("assets/png_image/ovo-logo.png")),
                  Switch(
                    value: ovoValue,
                    activeColor: ColorValues().primaryColor,
                    onChanged: (value) {
                      setState(() {
                        ovoValue = value;
                      });
                    },
                  )
                ],
              ),
              ovoValue
                  ? BuildTextFormField(
                      isTitle: false,
                      hintText:
                          AppLocalizations.of(context)!.enterAccountPhoneNum,
                      title: "")
                  : Container()
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                      width: 60,
                      height: 30,
                      image: AssetImage("assets/png_image/dana-logo.png")),
                  Switch(
                    value: danaValue,
                    activeColor: ColorValues().primaryColor,
                    onChanged: (value) {
                      setState(() {
                        danaValue = value;
                      });
                    },
                  )
                ],
              ),
              danaValue
                  ? BuildTextFormField(
                      isTitle: false,
                      hintText:
                          AppLocalizations.of(context)!.enterAccountPhoneNum,
                      title: "")
                  : Container()
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDestination(List<Facility> facilityList) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          BuildTextFormField(
            isTimeForm: true,
            title: AppLocalizations.of(context)!.timeOpen,
            hintText: hintTextTimeOpen,
            controller: timeOpenController,
          ),
          BuildTextFormField(
            isTimeForm: true,
            title: AppLocalizations.of(context)!.timeClose,
            hintText:
                AppLocalizations.of(context)!.hintTextTimeCloseDestination,
            controller: timeClosedController,
          ),
          Text(AppLocalizations.of(context)!.address,
              style: AppTextStyles.appTitlew400s12(ColorValues().blackColor)),
          BuildTextFormField(
            isTitle: false,
            title: "",
            hintText: hintTextRoadName,
            controller: roadNameController,
          ),
          BuildTextFormField(
            isTitle: false,
            title: "",
            hintText: hintTextHamletName,
            controller: hamletNameController,
          ),
          BuildTextFormField(
            isTitle: false,
            title: "",
            hintText: hintTextUrbanVillageName,
            controller: urbanVillageNameController,
          ),
          BuildTextFormField(
            isTitle: false,
            title: "",
            hintText: hintTextSubDistrictName,
            controller: subDistrictNameController,
          ),
          BuildTextFormField(
            isTitle: false,
            title: "",
            hintText: hintTextDistrictName,
            controller: districtNameController,
          ),
          BuildTextFormField(
            isTitle: false,
            title: "",
            hintText: hintTextProvinceName,
            controller: provinceNameController,
          ),
          SizedBox(
            height: 10,
          ),
          BuildTextFormField(
            title: AppLocalizations.of(context)!.googleMapsLink,
            controller: googleMapsController,
            hintText: hintTextGoogleMapsLinkName,
          ),
          SizedBox(
            height: 10,
          ),
          BuildTextFormField(
            title: AppLocalizations.of(context)!.rating + " range (0.0 - 5.0)",
            controller: ratingController,
            hintText: hintTextRatingName,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            isMaxLength: true,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0.0-5.0]')),
            ],
          ),
          Text(
            AppLocalizations.of(context)!.facilities,
            style: AppTextStyles.appTitlew400s12(ColorValues().blackColor),
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
                            value: selectedIndex.contains(item.name),
                            onChanged: (_isChecked) => {
                              setState(() {
                                _itemChange(item.name, _isChecked!);
                              })
                            },
                            title: Text(
                              item.name.substring(0, 1).toUpperCase() +
                                  item.name
                                      .substring(1, item.name.length)
                                      .toLowerCase(),
                              style: AppTextStyles.appTitlew400s10(
                                  ColorValues().blackColor),
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                          ))
                      .toList(),
                ]),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.tickets,
                    style:
                        AppTextStyles.appTitlew400s12(ColorValues().blackColor),
                  ),
                  IconButton(
                      onPressed: () {
                        CustomDialog.showUploadTicketDialog(
                            context,
                            ticketNameController,
                            ticketPriceController,
                            () {}, () {
                          Navigator.pop(context);
                        });
                      },
                      icon: Icon(Icons.add))
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ticketList[index].name),
                            Text(ticketList[index].price.toString()),
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
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.uploadImage,
                    style:
                        AppTextStyles.appTitlew400s12(ColorValues().blackColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      ListBody(
                        children: [
                          ...imageList.map(
                            (item) => item.imageUrl != ""
                                ? Container(
                                    height: 150,
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: item.imageUrl.startsWith("/")
                                                ? Image(
                                                    fit: BoxFit.cover,
                                                    image: FileImage(
                                                      File(item.imageUrl),
                                                    ))
                                                : Image.network(item.imageUrl,
                                                    fit: BoxFit.cover,
                                                    filterQuality:
                                                        FilterQuality.high),
                                          ),
                                        ),
                                        SizedBox(
                                            child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                imageList.remove(item);
                                              });
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: ColorValues().primaryColor,
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
                                backgroundColor: ColorValues().primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: Icon(Icons.upload),
                          ))
                    ],
                  ),
                ],
              )),
          SizedBox(
            height: 10,
          ),
          Text(
            AppLocalizations.of(context)!.paymentMethod,
            style: AppTextStyles.appTitlew400s12(ColorValues().blackColor),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                      width: 60,
                      height: 30,
                      image: AssetImage("assets/png_image/bca-logo.png")),
                  Switch(
                    value: bcaValue,
                    activeColor: ColorValues().primaryColor,
                    onChanged: (value) {
                      setState(() {
                        bcaValue = value;
                      });
                    },
                  )
                ],
              ),
              bcaValue
                  ? BuildTextFormField(
                      isTitle: false,
                      hintText:
                          AppLocalizations.of(context)!.enterAccountPhoneNum,
                      title: "")
                  : Container()
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                      width: 60,
                      height: 30,
                      image: AssetImage("assets/png_image/mandiri-logo.png")),
                  Switch(
                    value: mandiriValue,
                    activeColor: ColorValues().primaryColor,
                    onChanged: (value) {
                      setState(() {
                        mandiriValue = value;
                      });
                    },
                  )
                ],
              ),
              mandiriValue
                  ? BuildTextFormField(
                      isTitle: false,
                      hintText:
                          AppLocalizations.of(context)!.enterAccountPhoneNum,
                      title: "")
                  : Container()
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                      width: 60,
                      height: 30,
                      image: AssetImage("assets/png_image/bri-logo.png")),
                  Switch(
                    value: briValue,
                    activeColor: ColorValues().primaryColor,
                    onChanged: (value) {
                      setState(() {
                        briValue = value;
                      });
                    },
                  )
                ],
              ),
              briValue
                  ? BuildTextFormField(
                      isTitle: false,
                      hintText:
                          AppLocalizations.of(context)!.enterAccountPhoneNum,
                      title: "")
                  : Container()
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                      width: 60,
                      height: 30,
                      image: AssetImage("assets/png_image/bni-logo.png")),
                  Switch(
                    value: bniValue,
                    activeColor: ColorValues().primaryColor,
                    onChanged: (value) {
                      setState(() {
                        bniValue = value;
                      });
                    },
                  )
                ],
              ),
              bniValue
                  ? BuildTextFormField(
                      isTitle: false,
                      hintText:
                          AppLocalizations.of(context)!.enterAccountPhoneNum,
                      title: "")
                  : Container()
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                      width: 60,
                      height: 30,
                      image: AssetImage("assets/png_image/ovo-logo.png")),
                  Switch(
                    value: ovoValue,
                    activeColor: ColorValues().primaryColor,
                    onChanged: (value) {
                      setState(() {
                        ovoValue = value;
                      });
                    },
                  )
                ],
              ),
              ovoValue
                  ? BuildTextFormField(
                      isTitle: false,
                      hintText:
                          AppLocalizations.of(context)!.enterAccountPhoneNum,
                      title: "")
                  : Container()
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                      width: 60,
                      height: 30,
                      image: AssetImage("assets/png_image/dana-logo.png")),
                  Switch(
                    value: danaValue,
                    activeColor: ColorValues().primaryColor,
                    onChanged: (value) {
                      setState(() {
                        danaValue = value;
                      });
                    },
                  )
                ],
              ),
              danaValue
                  ? BuildTextFormField(
                      isTitle: false,
                      hintText:
                          AppLocalizations.of(context)!.enterAccountPhoneNum,
                      title: "")
                  : Container()
            ],
          ),
        ],
      ),
    );
  }

  Widget buildHotel(List<Facility> facilityList) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.address,
                  style:
                      AppTextStyles.appTitlew400s12(ColorValues().blackColor)),
              BuildTextFormField(
                isTitle: false,
                title: "",
                hintText: hintTextRoadName,
                controller: roadNameController,
              ),
              BuildTextFormField(
                isTitle: false,
                title: "",
                hintText: hintTextHamletName,
                controller: hamletNameController,
              ),
              BuildTextFormField(
                isTitle: false,
                title: "",
                hintText: hintTextUrbanVillageName,
                controller: urbanVillageNameController,
              ),
              BuildTextFormField(
                isTitle: false,
                title: "",
                hintText: hintTextSubDistrictName,
                controller: subDistrictNameController,
              ),
              BuildTextFormField(
                isTitle: false,
                title: "",
                hintText: hintTextDistrictName,
                controller: districtNameController,
              ),
              BuildTextFormField(
                isTitle: false,
                title: "",
                hintText: hintTextProvinceName,
                controller: provinceNameController,
              ),
            ],
          ),
          BuildTextFormField(
            title: AppLocalizations.of(context)!.googleMapsLink,
            controller: googleMapsController,
            hintText: hintTextGoogleMapsLinkName,
          ),
          BuildTextFormField(
            title: AppLocalizations.of(context)!.rating + " range (0.0 - 5.0)",
            controller: ratingController,
            hintText: hintTextRatingName,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            isMaxLength: true,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0.0-5.0]')),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.facilities,
                style: AppTextStyles.appTitlew400s12(ColorValues().blackColor),
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
                                value: selectedIndex.contains(item.name),
                                onChanged: (_isChecked) => {
                                  setState(() {
                                    _itemChange(item.name, _isChecked!);
                                  })
                                },
                                title: Text(
                                  item.name.substring(0, 1).toUpperCase() +
                                      item.name
                                          .substring(1, item.name.length)
                                          .toLowerCase(),
                                  style: AppTextStyles.appTitlew400s10(
                                      ColorValues().blackColor),
                                ),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ))
                          .toList(),
                    ]),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.room,
                    style:
                        AppTextStyles.appTitlew400s12(ColorValues().blackColor),
                  ),
                  IconButton(
                      onPressed: () {
                        CustomDialog.showRoomHotelDialog(
                            context,
                            _sizeRoomController,
                            _descRoomController,
                            _priceRoomController,
                            (val) {
                              showModalBottom(imageList);
                            },
                            () {},
                            () {
                              Navigator.pop(context);
                            });
                      },
                      icon: Icon(Icons.add))
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
                  itemCount: roomList.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(roomList[index].sizeRoom),
                            Text(roomList[index].priceRoom.toString()),
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                roomList.removeAt(index);
                              });
                            },
                            icon: Icon(Icons.delete))
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.uploadImage,
                    style:
                        AppTextStyles.appTitlew400s12(ColorValues().blackColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      ListBody(
                        children: [
                          ...imageList.map(
                            (item) => item.imageUrl != ""
                                ? Container(
                                    height: 150,
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: item.imageUrl.startsWith("/")
                                                ? Image(
                                                    fit: BoxFit.cover,
                                                    image: FileImage(
                                                      File(item.imageUrl),
                                                    ))
                                                : Image.network(item.imageUrl,
                                                    fit: BoxFit.cover,
                                                    filterQuality:
                                                        FilterQuality.high),
                                          ),
                                        ),
                                        SizedBox(
                                            child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                imageList.remove(item);
                                              });
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: ColorValues().primaryColor,
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
                                backgroundColor: ColorValues().primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: Icon(Icons.upload),
                          ))
                    ],
                  ),
                ],
              )),
          SizedBox(
            height: 10,
          ),
          Text(
            AppLocalizations.of(context)!.paymentMethod,
            style: AppTextStyles.appTitlew400s12(ColorValues().blackColor),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                      width: 60,
                      height: 30,
                      image: AssetImage("assets/png_image/bca-logo.png")),
                  Switch(
                    value: bcaValue,
                    activeColor: ColorValues().primaryColor,
                    onChanged: (value) {
                      setState(() {
                        bcaValue = value;
                      });
                    },
                  )
                ],
              ),
              bcaValue
                  ? BuildTextFormField(
                      isTitle: false,
                      hintText:
                          AppLocalizations.of(context)!.enterAccountPhoneNum,
                      title: "")
                  : Container()
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                      width: 60,
                      height: 30,
                      image: AssetImage("assets/png_image/mandiri-logo.png")),
                  Switch(
                    value: mandiriValue,
                    activeColor: ColorValues().primaryColor,
                    onChanged: (value) {
                      setState(() {
                        mandiriValue = value;
                      });
                    },
                  )
                ],
              ),
              mandiriValue
                  ? BuildTextFormField(
                      isTitle: false,
                      hintText:
                          AppLocalizations.of(context)!.enterAccountPhoneNum,
                      title: "")
                  : Container()
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                      width: 60,
                      height: 30,
                      image: AssetImage("assets/png_image/bri-logo.png")),
                  Switch(
                    value: briValue,
                    activeColor: ColorValues().primaryColor,
                    onChanged: (value) {
                      setState(() {
                        briValue = value;
                      });
                    },
                  )
                ],
              ),
              briValue
                  ? BuildTextFormField(
                      isTitle: false,
                      hintText:
                          AppLocalizations.of(context)!.enterAccountPhoneNum,
                      title: "")
                  : Container()
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                      width: 60,
                      height: 30,
                      image: AssetImage("assets/png_image/bni-logo.png")),
                  Switch(
                    value: bniValue,
                    activeColor: ColorValues().primaryColor,
                    onChanged: (value) {
                      setState(() {
                        bniValue = value;
                      });
                    },
                  )
                ],
              ),
              bniValue
                  ? BuildTextFormField(
                      isTitle: false,
                      hintText:
                          AppLocalizations.of(context)!.enterAccountPhoneNum,
                      title: "")
                  : Container()
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                      width: 60,
                      height: 30,
                      image: AssetImage("assets/png_image/ovo-logo.png")),
                  Switch(
                    value: ovoValue,
                    activeColor: ColorValues().primaryColor,
                    onChanged: (value) {
                      setState(() {
                        ovoValue = value;
                      });
                    },
                  )
                ],
              ),
              ovoValue
                  ? BuildTextFormField(
                      isTitle: false,
                      hintText:
                          AppLocalizations.of(context)!.enterAccountPhoneNum,
                      title: "")
                  : Container()
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                      width: 60,
                      height: 30,
                      image: AssetImage("assets/png_image/dana-logo.png")),
                  Switch(
                    value: danaValue,
                    activeColor: ColorValues().primaryColor,
                    onChanged: (value) {
                      setState(() {
                        danaValue = value;
                      });
                    },
                  )
                ],
              ),
              danaValue
                  ? BuildTextFormField(
                      isTitle: false,
                      hintText:
                          AppLocalizations.of(context)!.enterAccountPhoneNum,
                      title: "")
                  : Container()
            ],
          ),
        ],
      ),
    );
  }

  Widget buildEvent() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          BuildTextFormField(
            isDateForm: true,
            title: AppLocalizations.of(context)!.dateHeld,
            hintText: "",
            controller: dateHeldController,
          ),
          Text(AppLocalizations.of(context)!.ticketPrice),
          BuildTextFormField(
            isTitle: false,
            title: "",
            hintText: AppLocalizations.of(context)!.fillTicketPrice,
            controller: dateHeldController,
          ),
          Row(
            children: [
              Text(AppLocalizations.of(context)!.ticketType),
              Switch(
                value: ticketType,
                onChanged: (value) {
                  setState(() {
                    ticketType = value;
                  });
                },
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: BuildTextFormField(
                  isTimeForm: true,
                  title: AppLocalizations.of(context)!.timeHeld,
                  hintText: "",
                  controller: timeHeldController,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: BuildTextFormField(
                  isTimeForm: true,
                  title: "",
                  hintText: "",
                  controller: timeHeldCloseController,
                ),
              ),
            ],
          ),
          BuildTextFormField(
            title: AppLocalizations.of(context)!.rating + " range (0.0 - 5.0)",
            controller: ratingController,
            hintText: hintTextRatingName,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            isMaxLength: true,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0.0-5.0]')),
            ],
          ),
          BuildTextFormField(
            hintText: "",
            title: AppLocalizations.of(context)!.uploadImage,
            isUploadImage: true,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            AppLocalizations.of(context)!.paymentMethod,
            style: AppTextStyles.appTitlew400s12(ColorValues().blackColor),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                      width: 60,
                      height: 30,
                      image: AssetImage("assets/png_image/bca-logo.png")),
                  Switch(
                    value: bcaValue,
                    activeColor: ColorValues().primaryColor,
                    onChanged: (value) {
                      setState(() {
                        bcaValue = value;
                      });
                    },
                  )
                ],
              ),
              bcaValue
                  ? BuildTextFormField(
                      isTitle: false,
                      hintText:
                          AppLocalizations.of(context)!.enterAccountPhoneNum,
                      title: "")
                  : Container()
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                      width: 60,
                      height: 30,
                      image: AssetImage("assets/png_image/mandiri-logo.png")),
                  Switch(
                    value: mandiriValue,
                    activeColor: ColorValues().primaryColor,
                    onChanged: (value) {
                      setState(() {
                        mandiriValue = value;
                      });
                    },
                  )
                ],
              ),
              mandiriValue
                  ? BuildTextFormField(
                      isTitle: false,
                      hintText:
                          AppLocalizations.of(context)!.enterAccountPhoneNum,
                      title: "")
                  : Container()
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                      width: 60,
                      height: 30,
                      image: AssetImage("assets/png_image/bri-logo.png")),
                  Switch(
                    value: briValue,
                    activeColor: ColorValues().primaryColor,
                    onChanged: (value) {
                      setState(() {
                        briValue = value;
                      });
                    },
                  )
                ],
              ),
              briValue
                  ? BuildTextFormField(
                      isTitle: false,
                      hintText:
                          AppLocalizations.of(context)!.enterAccountPhoneNum,
                      title: "")
                  : Container()
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                      width: 60,
                      height: 30,
                      image: AssetImage("assets/png_image/bni-logo.png")),
                  Switch(
                    value: bniValue,
                    activeColor: ColorValues().primaryColor,
                    onChanged: (value) {
                      setState(() {
                        bniValue = value;
                      });
                    },
                  )
                ],
              ),
              bniValue
                  ? BuildTextFormField(
                      isTitle: false,
                      hintText:
                          AppLocalizations.of(context)!.enterAccountPhoneNum,
                      title: "")
                  : Container()
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                      width: 60,
                      height: 30,
                      image: AssetImage("assets/png_image/ovo-logo.png")),
                  Switch(
                    value: ovoValue,
                    activeColor: ColorValues().primaryColor,
                    onChanged: (value) {
                      setState(() {
                        ovoValue = value;
                      });
                    },
                  )
                ],
              ),
              ovoValue
                  ? BuildTextFormField(
                      isTitle: false,
                      hintText:
                          AppLocalizations.of(context)!.enterAccountPhoneNum,
                      title: "")
                  : Container()
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                      width: 60,
                      height: 30,
                      image: AssetImage("assets/png_image/dana-logo.png")),
                  Switch(
                    value: danaValue,
                    activeColor: ColorValues().primaryColor,
                    onChanged: (value) {
                      setState(() {
                        danaValue = value;
                      });
                    },
                  )
                ],
              ),
              danaValue
                  ? BuildTextFormField(
                      isTitle: false,
                      hintText:
                          AppLocalizations.of(context)!.enterAccountPhoneNum,
                      title: "")
                  : Container()
            ],
          ),
        ],
      ),
    );
  }

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
