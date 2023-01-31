import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:trip_boy/common/shared_code.dart';
import 'package:trip_boy/component/circle_button.dart';
import 'package:trip_boy/component/horizontal_card.dart';
import 'package:trip_boy/component/loading.dart';
import 'package:trip_boy/component/search_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/component/vertical_card.dart';
import 'package:trip_boy/models/destination_model.dart';
import 'package:trip_boy/models/event_model.dart';
import 'package:trip_boy/models/facility_model.dart';
import 'package:trip_boy/models/hotel_model.dart';
import 'package:trip_boy/services/database_services.dart';
import 'package:trip_boy/ui/user/detail_page.dart';
import '../../common/app_text_styles.dart';
import '../../common/color_values.dart';
import '../../common/user_data.dart';
import '../../models/restaurant_model.dart';
import 'dashboard_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateFormat format = DateFormat("dd-MM-yyyy");
  bool _isLoading = true;
  List<RestaurantModel> restaurantsData = [];
  List<HotelModel> hotelData = [];
  List<DestinationModel> destinationData = [];
  List<EventModel> eventData = [];
  List allData = [];
  final TextEditingController _searchController = TextEditingController();
  List allDataFiltered = [];
  String query = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllData();
  }

  Future<void> combineAllList() async {
    allData.addAll(hotelData);
    allData.addAll(restaurantsData);
    allData.addAll(destinationData);
    allData.sort((a, b) => b.rating.compareTo(a.rating));
    allDataFiltered = allData;
    print(" data filtered length : ${allDataFiltered.length}");
  }

  Future<void> getAllData() async {
    setLoading(true);
    restaurantsData =
        await DatabaseService().getRestaurantData(false, UserData().uid);
    hotelData = await DatabaseService().getHotelData(false, UserData().uid);
    destinationData =
        await DatabaseService().getDestinationData(false, UserData().uid);
    eventData = await DatabaseService().getEventData(false, UserData().uid);
    combineAllList();
    setLoading(false);
  }

  void searchData(String keyword) {
    final list = allData.where((list) {
      final titleLower = list.name!.toLowerCase();
      final searchLower = keyword.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      query = keyword;
      allDataFiltered = list;
      print(" data filtered length : ${allDataFiltered.length}");
    });
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
    List allDataAfterFilter =
        allData.where((element) => element.name != "").toList();
    List<EventModel> listAfterFilter = eventData.where(
      (element) {
        return element.name != "";
      },
    ).toList();
    FocusScopeNode currentFocus = FocusScope.of(context);
    return GestureDetector(
      onTap: () {
        if (!currentFocus.hasPrimaryFocus) {
          allDataFiltered = allData;
          _searchController.clear();
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: _isLoading
            ? Loading()
            : Container(
                height: MediaQuery.of(context).size.height.sp,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 5.h,
                          margin: EdgeInsets.only(
                              left: 15.sp, right: 15.sp, top: 10.sp),
                          width: MediaQuery.of(context).size.width.w,
                          child: SearchBar(
                            controller: _searchController,
                            onChanged: searchData,
                          )),
                      allDataFiltered.length != allData.length
                          ? Container(
                              margin: EdgeInsets.only(
                                  left: 15.sp, right: 15.sp, top: 15),
                              child: _buildSearchList(allDataFiltered),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 15.sp, right: 15.sp, top: 15),
                                  child: _buildCircleButton(),
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 10.sp),
                                    child:
                                        _buildHighlightEvent(listAfterFilter)),
                                Container(
                                    margin: EdgeInsets.only(
                                        left: 12.sp,
                                        top: 10.sp,
                                        right: 12.sp,
                                        bottom: 10.sp),
                                    child: _buildRecommend(allDataAfterFilter)),
                              ],
                            ),
                    ],
                  ),
                )),
      ),
    );
  }

  _buildCircleButton() {
    return Row(
      children: [
        CircleButton(
          icon: Icons.restaurant,
          title: AppLocalizations.of(context)!.restaurant,
          onTap: () {
            setState(() {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardPage(
                      selectedIndex: 1,
                      exploreSelectionIndex: 0,
                    ),
                  ));
            });
          },
        ),
        CircleButton(
          icon: Icons.hotel,
          title: AppLocalizations.of(context)!.hotel,
          onTap: () {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardPage(
                      selectedIndex: 1,
                      exploreSelectionIndex: 1,
                    ),
                  ));
            });
          },
        ),
        CircleButton(
          icon: Icons.map,
          title: AppLocalizations.of(context)!.tour,
          onTap: () {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardPage(
                      selectedIndex: 1,
                      exploreSelectionIndex: 2,
                    ),
                  ));
            });
          },
        ),
        CircleButton(
          icon: Icons.event,
          title: AppLocalizations.of(context)!.event,
          onTap: () {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardPage(
                      selectedIndex: 1,
                      exploreSelectionIndex: 3,
                    ),
                  ));
            });
          },
        )
      ],
    );
  }

  _buildHighlightEvent(listAfterFilter) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 15.sp,
          ),
          child: Text(
            AppLocalizations.of(context)!.highlight_event,
            style: AppTextStyles.appTitlew500s14(ColorValues().blackColor),
          ),
        ),
        SizedBox(
          height: 5.sp,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(
              left: 12.sp,
              right: 12.sp,
            ),
            child: Row(
              children: [
                for (var i = 0; i < listAfterFilter.length; i++)
                  HorizontalCard(
                    title: listAfterFilter[i].name!,
                    rating: listAfterFilter[i].rating,
                    heldAt: format.format(listAfterFilter[i].timeHeld),
                    price: listAfterFilter[i].price!.toString(),
                    imageUrl: listAfterFilter[i].imageUrl!,
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildRecommend(allDataAfterFilter) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 3.sp,
          ),
          child: Text(
            AppLocalizations.of(context)!.recommendation,
            style: AppTextStyles.appTitlew500s14(ColorValues().blackColor),
          ),
        ),
        SizedBox(
          height: 5.sp,
        ),
        Column(
          children: [
            for (var i = 0; i < allDataAfterFilter.length; i++)
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          facilityList: allDataAfterFilter[i].type == "hotel" ||
                                  allDataAfterFilter[i].type == "destination"
                              ? allDataAfterFilter[i].facility
                              : [],
                          price: allDataAfterFilter[i].type == "restaurant"
                              ? allDataAfterFilter[i]
                                  .menus
                                  .first
                                  .price
                                  .toString()
                              : allDataAfterFilter[i].type == "hotel"
                                  ? allDataAfterFilter[i]
                                      .rooms
                                      .first
                                      .priceRoom
                                      .toString()
                                  : allDataAfterFilter[i].tickets,
                          roomList: allDataAfterFilter[i].type == "hotel"
                              ? allDataAfterFilter[i].rooms
                              : [],
                          googleMapsUrl: allDataAfterFilter[i].googleMapsLink,
                          type: allDataAfterFilter[i].type,
                          imageUrl: allDataAfterFilter[i]
                                      .images!
                                      .first!
                                      .imagesUrl !=
                                  ""
                              ? allDataAfterFilter[i].images!.first!.imagesUrl
                              : "",
                          name: allDataAfterFilter[i].name,
                          rating: allDataAfterFilter[i].rating,
                          location:
                              allDataAfterFilter[i].alamat.split(', ')[0] == ""
                                  ? allDataAfterFilter[i].alamat.split(', ')[0]
                                  : allDataAfterFilter[i]
                                      .alamat
                                      .split(', ')[3]
                                      .split('. ')[1],
                          fullLocation: allDataAfterFilter[i].alamat,
                          timeClose: allDataAfterFilter[i].type ==
                                      "restaurant" ||
                                  allDataAfterFilter[i].type == "destination"
                              ? allDataAfterFilter[i].timeClosed
                              : "",
                          timeOpen: allDataAfterFilter[i].type ==
                                      "restaurant" ||
                                  allDataAfterFilter[i].type == "destination"
                              ? allDataAfterFilter[i].timeOpen
                              : "",
                          description: allDataAfterFilter[i].description,
                          imageList: allDataAfterFilter[i].images!.isNotEmpty
                              ? allDataAfterFilter[i].images!
                              : [],
                        ),
                      ));
                },
                child: VerticalCard(
                  title: allDataAfterFilter[i].name,
                  subDistrict: allDataAfterFilter[i].alamat.split(', ')[0] == ""
                      ? allDataAfterFilter[i].alamat.split(', ')[0]
                      : allDataAfterFilter[i].alamat.split(', ')[3],
                  price: allDataAfterFilter[i].type == "restaurant"
                      ? allDataAfterFilter[i].menus.first.price.toString()
                      : allDataAfterFilter[i].type == "hotel"
                          ? allDataAfterFilter[i]
                              .rooms
                              .first
                              .priceRoom
                              .toString()
                          : allDataAfterFilter[i]
                              .tickets
                              .first
                              .price
                              .toString(),
                  rating: allDataAfterFilter[i].rating.toString(),
                  imageUrl: allDataAfterFilter[i].images!.isNotEmpty
                      ? allDataAfterFilter[i].images!.first!.imagesUrl
                      : "",
                ),
              )
          ],
        ),
      ],
    );
  }

  noData(context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset("assets/svg_image/noDataActivity.svg"),
        Text(
          AppLocalizations.of(context)!.noData,
          style: AppTextStyles.appTitlew500s14(ColorValues().blackColor),
        )
      ],
    ));
  }

  _buildSearchList(allDataAfterFilter) {
    return allDataAfterFilter.length == 0
        ? Container(
            child: noData(context),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < allDataAfterFilter.length; i++)
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            facilityList: allDataAfterFilter[i].type ==
                                        "hotel" ||
                                    allDataAfterFilter[i].type == "destination"
                                ? allDataAfterFilter[i].facility
                                : [],
                            price: allDataAfterFilter[i].type == "restaurant"
                                ? allDataAfterFilter[i]
                                    .menus
                                    .first
                                    .price
                                    .toString()
                                : allDataAfterFilter[i].type == "hotel"
                                    ? allDataAfterFilter[i]
                                        .rooms
                                        .first
                                        .priceRoom
                                        .toString()
                                    : allDataAfterFilter[i].tickets,
                            roomList: allDataAfterFilter[i].type == "hotel"
                                ? allDataAfterFilter[i].rooms
                                : [],
                            googleMapsUrl: allDataAfterFilter[i].googleMapsLink,
                            type: allDataAfterFilter[i].type,
                            imageUrl: allDataAfterFilter[i]
                                        .images!
                                        .first!
                                        .imagesUrl !=
                                    ""
                                ? allDataAfterFilter[i].images!.first!.imagesUrl
                                : "",
                            name: allDataAfterFilter[i].name,
                            rating: allDataAfterFilter[i].rating,
                            location: allDataAfterFilter[i]
                                        .alamat
                                        .split(', ')[0] ==
                                    ""
                                ? allDataAfterFilter[i].alamat.split(', ')[0]
                                : allDataAfterFilter[i]
                                    .alamat
                                    .split(', ')[3]
                                    .split('. ')[1],
                            fullLocation: allDataAfterFilter[i].alamat,
                            timeClose: allDataAfterFilter[i].type ==
                                        "restaurant" ||
                                    allDataAfterFilter[i].type == "destination"
                                ? allDataAfterFilter[i].timeClosed
                                : "",
                            timeOpen: allDataAfterFilter[i].type ==
                                        "restaurant" ||
                                    allDataAfterFilter[i].type == "destination"
                                ? allDataAfterFilter[i].timeOpen
                                : "",
                            description: allDataAfterFilter[i].description,
                            imageList: allDataAfterFilter[i].images!.isNotEmpty
                                ? allDataAfterFilter[i].images!
                                : [],
                          ),
                        ));
                  },
                  child: VerticalCard(
                    title: allDataAfterFilter[i].name,
                    subDistrict:
                        allDataAfterFilter[i].alamat.split(', ')[0] == ""
                            ? allDataAfterFilter[i].alamat.split(', ')[0]
                            : allDataAfterFilter[i].alamat.split(', ')[3],
                    price: allDataAfterFilter[i].type == "restaurant"
                        ? allDataAfterFilter[i].menus.first.price.toString()
                        : allDataAfterFilter[i].type == "hotel"
                            ? allDataAfterFilter[i]
                                .rooms
                                .first
                                .priceRoom
                                .toString()
                            : allDataAfterFilter[i]
                                .tickets
                                .first
                                .price
                                .toString(),
                    rating: allDataAfterFilter[i].rating.toString(),
                    imageUrl: allDataAfterFilter[i].images!.isNotEmpty
                        ? allDataAfterFilter[i].images!.first!.imagesUrl
                        : "",
                  ),
                ),
            ],
          );
  }
}
