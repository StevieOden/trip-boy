import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/shared_code.dart';
import 'package:trip_boy/component/BuildTextFormField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_boy/component/custom_dialog.dart';
import 'package:trip_boy/component/loading.dart';
import 'package:trip_boy/models/event_model.dart';
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

  List<ImageModelRestaurant> imageRestaurantList = [];
  List<ImageHotel> imageHotelList = [];
  List<ImageDestination> imageDestinationList = [];
  List<FacilityDestinationModel> facilityDestinationList = [];
  List<FacilityHotelModel> facilityHotelList = [];
  List<RoomHotel> roomList = [];
  List<MenuRestaurant> menuList = [];
  List<TicketDestination> ticketList = [];
  List<Facility> selectedIndex = [];
  List<TermEvent> termEventList = [];
  List<PaymentMethodRestaurant> paymentMethodRestaurantList = [];
  List<PaymentMethodHotel> paymentMethodHotelList = [];
  List<PaymentMethodDestination> paymentMethodDestinationList = [];
  List<PaymentMethodEvent> paymentMethodEventList = [];

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

  late final TextEditingController _termsController;

  late final TextEditingController bcaAccountNumController;
  late final TextEditingController mandiriAccountNumController;
  late final TextEditingController briAccountNumController;
  late final TextEditingController bniAccountNumController;
  late final TextEditingController ovoAccountNumController;
  late final TextEditingController danaAccountNumController;

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
  late final TextEditingController meetLinkController;
  late final TextEditingController priceEventController;

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

    meetLinkController = TextEditingController();

    _termsController = TextEditingController();
    priceEventController = TextEditingController();

    bcaAccountNumController = TextEditingController();
    mandiriAccountNumController = TextEditingController();
    briAccountNumController = TextEditingController();
    bniAccountNumController = TextEditingController();
    ovoAccountNumController = TextEditingController();
    danaAccountNumController = TextEditingController();

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
    bcaAccountNumController.dispose();
    mandiriAccountNumController.dispose();
    briAccountNumController.dispose();
    bniAccountNumController.dispose();
    ovoAccountNumController.dispose();
    danaAccountNumController.dispose();
    priceEventController.dispose();
    menuNameController.dispose();
    menuDescController.dispose();
    menuPriceController.dispose();
    ticketNameController.dispose();
    ticketPriceController.dispose();
    _termsController.dispose();
    meetLinkController.dispose();
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
    bcaAccountNumController.clear();
    mandiriAccountNumController.clear();
    briAccountNumController.clear();
    bniAccountNumController.clear();
    ovoAccountNumController.clear();
    danaAccountNumController.clear();
    priceEventController.clear();
    menuNameController.clear();
    menuDescController.clear();
    menuPriceController.clear();
    ticketNameController.clear();
    ticketPriceController.clear();
    _termsController.clear();
    meetLinkController.clear();
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

    paymentMethodHotelList.clear();
    paymentMethodRestaurantList.clear();
    paymentMethodDestinationList.clear();
    paymentMethodEventList.clear();

    ticketList.clear();
    facilityDestinationList.clear();
    facilityHotelList.clear();

    bcaAccountNumController.clear();
    mandiriAccountNumController.clear();
    briAccountNumController.clear();
    bniAccountNumController.clear();
    ovoAccountNumController.clear();
    danaAccountNumController.clear();

    bcaValue = false;
    mandiriValue = false;
    briValue = false;
    bniValue = false;
    ovoValue = false;
    danaValue = false;

    googleMapsController.clear();
    ratingController.clear();
    imageRestaurantList.clear();
    imageDestinationList.clear();
    imageHotelList.clear();
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
      bcaValue
          ? paymentMethodRestaurantList.add(PaymentMethodRestaurant(
              method: "bca", number: bcaAccountNumController.text))
          : null;
      mandiriValue
          ? paymentMethodRestaurantList.add(PaymentMethodRestaurant(
              method: "mandiri", number: mandiriAccountNumController.text))
          : null;
      briValue
          ? paymentMethodRestaurantList.add(PaymentMethodRestaurant(
              method: "bca", number: briAccountNumController.text))
          : null;
      bniValue
          ? paymentMethodRestaurantList.add(PaymentMethodRestaurant(
              method: "bni", number: bniAccountNumController.text))
          : null;
      ovoValue
          ? paymentMethodRestaurantList.add(PaymentMethodRestaurant(
              method: "ovo", number: ovoAccountNumController.text))
          : null;
      danaValue
          ? paymentMethodRestaurantList.add(PaymentMethodRestaurant(
              method: "dana", number: danaAccountNumController.text))
          : null;

      bcaValue
          ? paymentMethodDestinationList.add(PaymentMethodDestination(
              method: "bca", number: bcaAccountNumController.text))
          : null;
      mandiriValue
          ? paymentMethodDestinationList.add(PaymentMethodDestination(
              method: "mandiri", number: mandiriAccountNumController.text))
          : null;
      briValue
          ? paymentMethodDestinationList.add(PaymentMethodDestination(
              method: "bca", number: briAccountNumController.text))
          : null;
      bniValue
          ? paymentMethodDestinationList.add(PaymentMethodDestination(
              method: "bni", number: bniAccountNumController.text))
          : null;
      ovoValue
          ? paymentMethodDestinationList.add(PaymentMethodDestination(
              method: "ovo", number: ovoAccountNumController.text))
          : null;
      danaValue
          ? paymentMethodDestinationList.add(PaymentMethodDestination(
              method: "dana", number: danaAccountNumController.text))
          : null;

      bcaValue
          ? paymentMethodHotelList.add(PaymentMethodHotel(
              method: "bca", number: bcaAccountNumController.text))
          : null;
      mandiriValue
          ? paymentMethodHotelList.add(PaymentMethodHotel(
              method: "mandiri", number: mandiriAccountNumController.text))
          : null;
      briValue
          ? paymentMethodHotelList.add(PaymentMethodHotel(
              method: "bca", number: briAccountNumController.text))
          : null;
      bniValue
          ? paymentMethodHotelList.add(PaymentMethodHotel(
              method: "bni", number: bniAccountNumController.text))
          : null;
      ovoValue
          ? paymentMethodHotelList.add(PaymentMethodHotel(
              method: "ovo", number: ovoAccountNumController.text))
          : null;
      danaValue
          ? paymentMethodHotelList.add(PaymentMethodHotel(
              method: "dana", number: danaAccountNumController.text))
          : null;

      bcaValue
          ? paymentMethodEventList.add(PaymentMethodEvent(
              method: "bca", number: bcaAccountNumController.text))
          : null;
      mandiriValue
          ? paymentMethodEventList.add(PaymentMethodEvent(
              method: "mandiri", number: mandiriAccountNumController.text))
          : null;
      briValue
          ? paymentMethodEventList.add(PaymentMethodEvent(
              method: "bca", number: briAccountNumController.text))
          : null;
      bniValue
          ? paymentMethodEventList.add(PaymentMethodEvent(
              method: "bni", number: bniAccountNumController.text))
          : null;
      ovoValue
          ? paymentMethodEventList.add(PaymentMethodEvent(
              method: "ovo", number: ovoAccountNumController.text))
          : null;
      danaValue
          ? paymentMethodEventList.add(PaymentMethodEvent(
              method: "dana", number: danaAccountNumController.text))
          : null;
      widget.index == 0
          ? DatabaseService().addRestaurantData(
              "${roadNameController.text},${hamletNameController.text},${urbanVillageNameController.text},${subDistrictNameController.text},${districtNameController.text},${provinceNameController.text}",
              descController.text,
              googleMapsController.text,
              imageRestaurantList,
              menuList,
              nameController.text,
              double.parse(ratingController.text),
              timeClosedController.text,
              timeOpenController.text,
              paymentMethodRestaurantList)
          : widget.index == 1
              ? DatabaseService().addDestinationData(
                  "${roadNameController.text},${hamletNameController.text},${urbanVillageNameController.text},${subDistrictNameController.text},${districtNameController.text},${provinceNameController.text}",
                  descController.text,
                  facilityDestinationList,
                  imageDestinationList,
                  nameController.text,
                  googleMapsController.text,
                  double.parse(ratingController.text),
                  ticketList,
                  timeClosedController.text,
                  timeOpenController.text,
                  paymentMethodDestinationList)
              : widget.index == 2
                  ? DatabaseService().addHotelData(
                      "${roadNameController.text},${hamletNameController.text},${urbanVillageNameController.text},${subDistrictNameController.text},${districtNameController.text},${provinceNameController.text}",
                      descController.text,
                      facilityHotelList,
                      double.parse(ratingController.text),
                      imageHotelList,
                      nameController.text,
                      googleMapsController.text,
                      roomList,
                      paymentMethodHotelList)
                  : DatabaseService().addEventData(
                      timeHeldController.text,
                      descController.text,
                      imageUrl,
                      ticketType ? googleMapsController.text : "",
                      nameController.text,
                      int.parse(priceEventController.text),
                      double.parse(ratingController.text),
                      termEventList,
                      ticketType ? "online" : "offline",
                      paymentMethodEventList);
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
      widget.index == 0
          ? imageList.add(ImageModelRestaurant(imageUrl: img!.path))
          : widget.index == 1
              ? imageList.add(ImageDestination(imageUrl: img!.path))
              : widget.index == 2
                  ? imageList.add(ImageHotel(imageUrl: img!.path))
                  : imageList.add(ImageModel(imageUrl: img!.path));
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
                            if (SharedCode.formKey.currentState!.validate()) {
                              addToDatabase();
                            }
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
      child: Form(
        key: SharedCode.formKey,
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
              timeController: timeOpenController,
            ),
            BuildTextFormField(
              isTimeForm: true,
              title: AppLocalizations.of(context)!.timeClose,
              hintText:
                  AppLocalizations.of(context)!.hintTextTimeCloseDestination,
              timeController: timeClosedController,
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
              title:
                  AppLocalizations.of(context)!.rating + " range (0.0 - 5.0)",
              controller: ratingController,
              hintText: hintTextRatingName,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              isMaxLength: true,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.menu,
                  style:
                      AppTextStyles.appTitlew400s12(ColorValues().blackColor),
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
                                        borderRadius: BorderRadius.circular(10),
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
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(item.name),
                                        Text(item.price.toString()),
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
                                    color: ColorValues().primaryColor,
                                    size: 25,
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ))
                  ],
                )
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
                            ...imageRestaurantList.map(
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
                                              child: item.imageUrl
                                                      .startsWith("/")
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
                                                  imageRestaurantList
                                                      .remove(item);
                                                });
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color:
                                                    ColorValues().primaryColor,
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
                                showModalBottom(imageRestaurantList);
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
                        keyboardType: TextInputType.number,
                        controller: bcaAccountNumController,
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
                        keyboardType: TextInputType.number,
                        controller: mandiriAccountNumController,
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
                        keyboardType: TextInputType.number,
                        controller: briAccountNumController,
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
                        keyboardType: TextInputType.number,
                        controller: bniAccountNumController,
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
                        keyboardType: TextInputType.number,
                        controller: ovoAccountNumController,
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
                        keyboardType: TextInputType.number,
                        controller: danaAccountNumController,
                        isTitle: false,
                        hintText:
                            AppLocalizations.of(context)!.enterAccountPhoneNum,
                        title: "")
                    : Container()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDestination(List<Facility> facilityList) {
    return Container(
      child: Form(
        key: SharedCode.formKey,
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
              timeController: timeOpenController,
            ),
            BuildTextFormField(
              isTimeForm: true,
              title: AppLocalizations.of(context)!.timeClose,
              hintText:
                  AppLocalizations.of(context)!.hintTextTimeCloseDestination,
              timeController: timeClosedController,
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
              title:
                  AppLocalizations.of(context)!.rating + " range (0.0 - 5.0)",
              controller: ratingController,
              hintText: hintTextRatingName,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              isMaxLength: true,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
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
                              activeColor: ColorValues().primaryColor,
                              value: facilityDestinationList
                                  .any((element) => element.name == item.name),
                              onChanged: (_isChecked) => {
                                setState(() {
                                  if (_isChecked!) {
                                    facilityDestinationList.add(
                                        FacilityDestinationModel(
                                            name: item.name));
                                    print(facilityDestinationList);
                                  } else {
                                    var index = facilityDestinationList
                                        .indexWhere((element) =>
                                            element.name == item.name);
                                    facilityDestinationList.removeAt(index);
                                    print(facilityDestinationList);
                                  }
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
                      style: AppTextStyles.appTitlew400s12(
                          ColorValues().blackColor),
                    ),
                    IconButton(
                        onPressed: () {
                          CustomDialog.showUploadTicketDialog(context,
                              ticketNameController, ticketPriceController, () {
                            ticketList.add(TicketDestination(
                                name: ticketNameController.text,
                                price: int.parse(ticketPriceController.text)));
                            Navigator.pop(context);
                          }, () {
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
                              SizedBox(
                                height: 5,
                              ),
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
                            ...imageDestinationList.map(
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
                                              child: item.imageUrl
                                                      .startsWith("/")
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
                                                  imageDestinationList
                                                      .remove(item);
                                                });
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color:
                                                    ColorValues().primaryColor,
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
                                showModalBottom(imageDestinationList);
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
                        keyboardType: TextInputType.number,
                        isTitle: false,
                        hintText:
                            AppLocalizations.of(context)!.enterAccountPhoneNum,
                        title: "",
                        controller: bcaAccountNumController,
                      )
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
                        keyboardType: TextInputType.number,
                        isTitle: false,
                        hintText:
                            AppLocalizations.of(context)!.enterAccountPhoneNum,
                        title: "",
                        controller: mandiriAccountNumController,
                      )
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
                        keyboardType: TextInputType.number,
                        isTitle: false,
                        hintText:
                            AppLocalizations.of(context)!.enterAccountPhoneNum,
                        title: "",
                        controller: briAccountNumController,
                      )
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
                        keyboardType: TextInputType.number,
                        isTitle: false,
                        hintText:
                            AppLocalizations.of(context)!.enterAccountPhoneNum,
                        title: "",
                        controller: bniAccountNumController,
                      )
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
                        keyboardType: TextInputType.number,
                        isTitle: false,
                        hintText:
                            AppLocalizations.of(context)!.enterAccountPhoneNum,
                        title: "",
                        controller: ovoAccountNumController,
                      )
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
                        keyboardType: TextInputType.number,
                        isTitle: false,
                        hintText:
                            AppLocalizations.of(context)!.enterAccountPhoneNum,
                        title: "",
                        controller: danaAccountNumController,
                      )
                    : Container()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHotel(List<Facility> facilityList) {
    return Container(
      child: Form(
        key: SharedCode.formKey,
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
                    style: AppTextStyles.appTitlew400s12(
                        ColorValues().blackColor)),
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
              title:
                  AppLocalizations.of(context)!.rating + " range (0.0 - 5.0)",
              controller: ratingController,
              hintText: hintTextRatingName,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              isMaxLength: true,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.facilities,
                  style:
                      AppTextStyles.appTitlew400s12(ColorValues().blackColor),
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
                                  activeColor: ColorValues().primaryColor,
                                  value: facilityHotelList.any(
                                      (element) => element.name == item.name),
                                  onChanged: (_isChecked) => {
                                    setState(() {
                                      if (_isChecked!) {
                                        facilityHotelList.add(
                                            FacilityHotelModel(
                                                name: item.name));
                                      } else {
                                        var index = facilityHotelList
                                            .indexWhere((element) =>
                                                element.name == item.name);
                                        facilityHotelList.removeAt(index);
                                      }
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
                      style: AppTextStyles.appTitlew400s12(
                          ColorValues().blackColor),
                    ),
                    IconButton(
                        onPressed: () {
                          CustomDialog.showRoomHotelDialog(
                              context,
                              _sizeRoomController,
                              _descRoomController,
                              _priceRoomController,
                              (val) => imageUrl = val, () {
                            roomList.add(RoomHotel(
                                imageUrl: imageUrl,
                                sizeRoom: _sizeRoomController.text,
                                priceRoom: int.parse(_priceRoomController.text),
                                description: _descRoomController.text));
                            Navigator.pop(context);
                          }, () {
                            Navigator.pop(context);
                          });
                        },
                        icon: Icon(Icons.add))
                  ],
                ),
                Column(
                  children: [
                    ListBody(
                      children: [
                        ...roomList.map((item) => Container(
                              height: 100,
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
                                                BorderRadius.circular(10),
                                            child: item.imageUrl.startsWith("/")
                                                ? Image(
                                                    image: FileImage(
                                                    File(item.imageUrl),
                                                  ))
                                                : item.imageUrl == ""
                                                    ? Image.asset(
                                                        "assets/png_image/logo.png",
                                                        fit: BoxFit.cover,
                                                        filterQuality:
                                                            FilterQuality.high)
                                                    : Image.network(
                                                        item.imageUrl,
                                                        fit: BoxFit.cover,
                                                        filterQuality:
                                                            FilterQuality.high),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 120,
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(item.sizeRoom),
                                                  Text(item.priceRoom
                                                      .toString()),
                                                ],
                                              ),
                                              Text(
                                                item.description,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
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
                                          roomList.remove(item);
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
                            ))
                      ],
                    )
                  ],
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
                            ...imageHotelList.map(
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
                                              child: item.imageUrl
                                                      .startsWith("/")
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
                                                  imageHotelList.remove(item);
                                                });
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color:
                                                    ColorValues().primaryColor,
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
                                showModalBottom(imageHotelList);
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
                        keyboardType: TextInputType.number,
                        isTitle: false,
                        hintText:
                            AppLocalizations.of(context)!.enterAccountPhoneNum,
                        title: "",
                        controller: bcaAccountNumController,
                      )
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
                        keyboardType: TextInputType.number,
                        isTitle: false,
                        hintText:
                            AppLocalizations.of(context)!.enterAccountPhoneNum,
                        title: "",
                        controller: mandiriAccountNumController,
                      )
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
                        keyboardType: TextInputType.number,
                        isTitle: false,
                        hintText:
                            AppLocalizations.of(context)!.enterAccountPhoneNum,
                        title: "",
                        controller: briAccountNumController,
                      )
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
                        keyboardType: TextInputType.number,
                        isTitle: false,
                        hintText:
                            AppLocalizations.of(context)!.enterAccountPhoneNum,
                        title: "",
                        controller: bniAccountNumController,
                      )
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
                        keyboardType: TextInputType.number,
                        isTitle: false,
                        hintText:
                            AppLocalizations.of(context)!.enterAccountPhoneNum,
                        title: "",
                        controller: ovoAccountNumController,
                      )
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
                        keyboardType: TextInputType.number,
                        isTitle: false,
                        hintText:
                            AppLocalizations.of(context)!.enterAccountPhoneNum,
                        title: "",
                        controller: danaAccountNumController,
                      )
                    : Container()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEvent() {
    return Container(
      child: Form(
        key: SharedCode.formKey,
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
              dateController: dateHeldController,
            ),
            Row(
              children: [
                Expanded(
                  child: BuildTextFormField(
                    isTimeForm: true,
                    title: AppLocalizations.of(context)!.timeHeld,
                    hintText: "",
                    timeController: timeHeldController,
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
                    timeController: timeHeldCloseController,
                  ),
                ),
              ],
            ),
            Text(AppLocalizations.of(context)!.ticketPrice),
            BuildTextFormField(
              isTitle: false,
              title: "",
              hintText: AppLocalizations.of(context)!.fillTicketPrice,
              controller: priceEventController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.ticketType),
                Switch(
                  value: ticketType,
                  activeColor: ColorValues().primaryColor,
                  onChanged: (value) {
                    setState(() {
                      ticketType = value;
                    });
                  },
                )
              ],
            ),
            ticketType
                ? BuildTextFormField(
                    isTitle: false,
                    title: "",
                    hintText: AppLocalizations.of(context)!.fillMeetLink,
                    controller: meetLinkController,
                  )
                : Container(),
            BuildTextFormField(
              title:
                  AppLocalizations.of(context)!.rating + " range (0.0 - 5.0)",
              controller: ratingController,
              hintText: hintTextRatingName,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              isMaxLength: true,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.termTitle,
                    style: AppTextStyles.appTitlew400s12(
                        ColorValues().blackColor)),
                IconButton(
                    onPressed: () {
                      CustomDialog.showTermsDialog(context, _termsController,
                          () {
                        termEventList
                            .add(TermEvent(text: _termsController.text));
                        Navigator.pop(context);
                      }, () {
                        Navigator.pop(context);
                      });
                    },
                    icon: Icon(
                      Icons.add,
                      color: ColorValues().blackColor,
                    ))
              ],
            ),
            SizedBox(
              height: 10,
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
                itemCount: termEventList.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(termEventList[index].text),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              termEventList.removeAt(index);
                            });
                          },
                          icon: Icon(Icons.delete))
                    ],
                  );
                },
              ),
            ),
            BuildTextFormField(
              imagePath: (val) {
                imageUrl = val;
              },
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
                        keyboardType: TextInputType.number,
                        isTitle: false,
                        hintText:
                            AppLocalizations.of(context)!.enterAccountPhoneNum,
                        title: "",
                        controller: bcaAccountNumController,
                      )
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
                        keyboardType: TextInputType.number,
                        isTitle: false,
                        hintText:
                            AppLocalizations.of(context)!.enterAccountPhoneNum,
                        title: "",
                        controller: mandiriAccountNumController,
                      )
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
                        keyboardType: TextInputType.number,
                        isTitle: false,
                        hintText:
                            AppLocalizations.of(context)!.enterAccountPhoneNum,
                        title: "",
                        controller: briAccountNumController,
                      )
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
                        keyboardType: TextInputType.number,
                        isTitle: false,
                        hintText:
                            AppLocalizations.of(context)!.enterAccountPhoneNum,
                        title: "",
                        controller: bniAccountNumController,
                      )
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
                        keyboardType: TextInputType.number,
                        isTitle: false,
                        hintText:
                            AppLocalizations.of(context)!.enterAccountPhoneNum,
                        title: "",
                        controller: ovoAccountNumController,
                      )
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
                        keyboardType: TextInputType.number,
                        isTitle: false,
                        hintText:
                            AppLocalizations.of(context)!.enterAccountPhoneNum,
                        title: "",
                        controller: danaAccountNumController,
                      )
                    : Container()
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _itemChange(String itemValue, bool isSelected, bool isDestination) {
    setState(() {
      if (isSelected) {
        print(itemValue);
        selectedIndex.add(Facility(name: itemValue));
      } else {
        print(itemValue + " remove");
        selectedIndex.remove(itemValue);
      }
    });
  }
}
