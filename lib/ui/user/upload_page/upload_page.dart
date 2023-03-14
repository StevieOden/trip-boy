import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/common/user_data.dart';
import 'package:trip_boy/component/alert_dialog.dart';
import 'package:trip_boy/component/custom_dialog.dart';
import 'package:trip_boy/component/loading.dart';
import 'package:trip_boy/component/vertical_card.dart';
import 'package:trip_boy/models/content_model.dart';
import 'package:trip_boy/ui/user/upload_page/upload_detail.dart';

import '../../../common/app_text_styles.dart';
import '../../../common/color_values.dart';
import '../../../component/upload_list.dart';

import '../../../models/destination_model.dart';
import '../../../models/event_model.dart';
import '../../../models/hotel_model.dart';
import '../../../models/restaurant_model.dart';
import '../../../services/database_services.dart';

class UploadPage extends StatefulWidget {
  UploadPage({Key? key}) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  int tabIndex = 0;
  bool _isLoading = false;
  List<Map> uploadList = [];
  List<RestaurantModel> restaurantData = [];
  List<EventModel> eventData = [];
  List<DestinationModel> destinationData = [];
  List<HotelModel> hotelData = [];
  List<String> contentId = [];
  List allData = [];
  int indexUploadData = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getAllData();
  }

  Future<void> combineAllList() async {
    allData.addAll(restaurantData);
    allData.addAll(destinationData);
    allData.addAll(hotelData);
    allData.addAll(eventData);
    // allData.sort((a, b) => b.rating.compareTo(a.rating));
    print(allData.length);
  }

  Future<void> getAllData() async {
    setLoading(true);
    restaurantData =
        await DatabaseService().getRestaurantData(true, UserData().uid);
    eventData = await DatabaseService().getEventData(true, UserData().uid);
    destinationData =
        await DatabaseService().getDestinationData(true, UserData().uid);
    hotelData = await DatabaseService().getHotelData(true, UserData().uid);
    combineAllList();
    setLoading(false);
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

  @override
  Widget build(BuildContext context) {
    uploadList = [
      {
        "title": AppLocalizations.of(context)!.restaurant,
        "image": "assets/svg_image/uploadRestaurant.svg"
      },
      {
        "title": AppLocalizations.of(context)!.tour,
        "image": "assets/svg_image/uploadDestination.svg"
      },
      {
        "title": AppLocalizations.of(context)!.hotel,
        "image": "assets/svg_image/uploadHotel.svg"
      },
      {
        "title": AppLocalizations.of(context)!.event,
        "image": "assets/svg_image/uploadEvent.svg"
      }
    ];
    return Scaffold(
      body: _isLoading
          ? Loading()
          : Column(
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
                            allData.clear();
                            getAllData();
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
                            allData.clear();
                            getAllData();
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
          SvgPicture.asset("assets/svg_image/noDataActivity.svg"),
          Text(
            AppLocalizations.of(context)!.noAdded,
            style: AppTextStyles.appTitlew500s14(ColorValues().blackColor),
          )
        ],
      )),
    );
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UploadDetail(
            index: indexUploadData,
            hintTextType: uploadList[indexUploadData]["title"],
          ),
        ));
    if (!mounted) return;
    Navigator.pop(context);
    allData.clear();
    getAllData();
  }

  buildUploadList() {
    return _isLoading
        ? Expanded(child: Loading())
        : UploadList(
            indexCallback: (val) => indexUploadData = val,
            navPush: () {
              _navigateAndDisplaySelection(context);
            },
            uploadList: uploadList,
          );
  }

  Future<void> deleteContentData(index) async {
    contentId = await DatabaseService().getContentId(allData[index].type);
    for (var i = 0; i < contentId.length; i++) {
      setState(() {
        DatabaseService().deleteContent(contentId[i], allData[index].type);
      });
    }
    Navigator.pop(context);
    getAllData();
    allData.clear();
  }

  addedList() {
    return allData.isEmpty
        ? noData()
        : Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 15.sp, right: 15.sp),
              child: ListView.builder(
                itemCount: allData.length,
                itemBuilder: (context, index) => VerticalCard(
                    deleteFunction: () {
                      CustomDialog.showConfirmation(
                          context,
                          () => deleteContentData(index),
                          Text(AppLocalizations.of(context)!.deleteConfirmation,
                              style: AppTextStyles.appTitlew400s12(
                                  ColorValues().blackColor)));
                    },
                    isUploadedPage: true,
                    imageUrl: allData[index].type == "event"
                        ? allData[index].imageUrl
                        : allData[index].images!.isEmpty
                            ? ""
                            : allData[index].images!.first.imageUrl != ""
                                ? allData[index].images!.first.imageUrl
                                : "",
                    title: allData[index].name,
                    subDistrict: allData[index].type == "event"
                        ? ""
                        : allData[index].address!.split(',')[0] == ""
                            ? allData[index].address!.split(',')[0]
                            : allData[index].address!.split(',')[3],
                    price: allData[index].type == "restaurant"
                        ? allData[index].menu!.first.price.toString()
                        : allData[index].type == "hotel"
                            ? allData[index].rooms!.first.priceRoom.toString()
                            : allData[index].type == "event"
                                ? allData[index].price.toString()
                                : allData[index]
                                    .tickets!
                                    .first
                                    .price
                                    .toString(),
                    rating: allData[index].rating.toString()),
              ),
            ),
          );
  }
}
