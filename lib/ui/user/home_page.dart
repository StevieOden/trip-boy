import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:trip_boy/component/circle_button.dart';
import 'package:trip_boy/component/custom_dialog.dart';
import 'package:trip_boy/component/horizontal_card.dart';
import 'package:trip_boy/component/loading.dart';
import 'package:trip_boy/component/search_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/component/vertical_card.dart';
import 'package:trip_boy/models/booking_model.dart';
import 'package:trip_boy/models/destination_model.dart';
import 'package:trip_boy/models/event_model.dart';
import 'package:trip_boy/models/hotel_model.dart';
import 'package:trip_boy/models/restaurant_model.dart';
import 'package:trip_boy/services/database_services.dart';
import 'package:trip_boy/ui/user/detail_page.dart';
import 'package:trip_boy/ui/user/edit_profile.dart';
import '../../common/app_text_styles.dart';
import '../../common/color_values.dart';
import '../../common/user_data.dart';
import '../../component/alert_dialog.dart';
import '../../models/content_model.dart';
import '../../models/user_model.dart';
import 'dashboard_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateFormat format = DateFormat("dd-MM-yyyy");
  bool _isLoading = true;
  List<BookingModel> bookingData = [];
  List<RestaurantModel> restaurantData = [];
  List<EventModel> eventData = [];
  List<DestinationModel> destinationData = [];
  List<HotelModel> hotelData = [];
  List allData = [];
  final TextEditingController _searchController = TextEditingController();
  List allDataFiltered = [];
  String query = "";
  String phoneNumber = "";
  String email = "";
  String name = "";
  String uid = "";
  ValueNotifier<bool> isPayed = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    getAllData();
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditProfile(uid: UserData().uid),
        ));
    if (!mounted) return;
    Navigator.pop(context);
    getUserData();
  }

  Future<void> combineAllList() async {
    allData = [...restaurantData, ...destinationData, ...hotelData];
    allData.sort((a, b) => b.rating.compareTo(a.rating));
    allDataFiltered = allData;
  }

  Future<void> getUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      uid = user!.uid;
      UserModel userData = await DatabaseService().getUserData(uid);
      name = userData.name!;
      phoneNumber = userData.phoneNumber!;
      email = userData.email!;
      name.isEmpty || phoneNumber.isEmpty || email.isEmpty
          ? CustomDialog.showWarningProfileIncomplete(
              context,
              () {
                setState(() {
                  _navigateAndDisplaySelection(context);
                });
              },
            )
          : null;
    } catch (e) {
      throw ("error : " + e.toString());
    }
  }

  Future<void> getAllData() async {
    setLoading(true);
    getUserData();
    isPayed.value = await DatabaseService().checkPayment();
    restaurantData =
        await DatabaseService().getRestaurantData(false, UserData().uid);
    eventData = await DatabaseService().getEventData(false, UserData().uid);
    destinationData =
        await DatabaseService().getDestinationData(false, UserData().uid);
    hotelData = await DatabaseService().getHotelData(false, UserData().uid);
    combineAllList();
    setLoading(false);
  }

  void searchData(String keyword) {
    final list = allData.where((list) {
      final titleLower = list.name.toLowerCase();
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
                                ValueListenableBuilder(
                                  valueListenable: isPayed,
                                  builder: (context, value, child) =>
                                      !isPayed.value
                                          ? Container()
                                          : Card(
                                              color:
                                                  ColorValues().lightRedColor,
                                              margin: EdgeInsets.only(
                                                  left: 15.sp,
                                                  right: 15.sp,
                                                  top: 15),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/svg_image/paymentWarning.svg',
                                                        height: 100,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .paymentWarning,
                                                              style: AppTextStyles
                                                                  .appTitlew700s16(
                                                                      ColorValues()
                                                                          .blackColor),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Container(
                                                              width: 100,
                                                              child:
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pushReplacement(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (context) => DashboardPage(
                                                                                selectedIndex: 2,
                                                                              ),
                                                                            ));
                                                                      },
                                                                      style: ElevatedButton.styleFrom(
                                                                          backgroundColor: ColorValues()
                                                                              .redColor),
                                                                      child:
                                                                          Text(
                                                                        "Pay",
                                                                        style: AppTextStyles.appTitlew500s12(
                                                                            Colors.white),
                                                                      )),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 15.sp, right: 15.sp, top: 15),
                                  child: _buildCircleButton(),
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 10.sp),
                                    child: _buildHighlightEvent(eventData)),
                                Container(
                                    margin: EdgeInsets.only(
                                        left: 12.sp,
                                        top: 10.sp,
                                        right: 12.sp,
                                        bottom: 10.sp),
                                    child: _buildRecommend(allDataFiltered)),
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
              Navigator.push(
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

  _buildHighlightEvent(List<EventModel> listAfterFilter) {
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
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              paymentMethodEvent:
                                  listAfterFilter[i].paymentMethod,
                              menuRestaurantsList: [],
                              facilityList: [],
                              price: listAfterFilter[i].price,
                              roomList: [],
                              googleMapsUrl: listAfterFilter[i].meetLink!,
                              type: listAfterFilter[i].type,
                              imageUrl: listAfterFilter[i].imageUrl!,
                              name: listAfterFilter[i].name,
                              rating: listAfterFilter[i].rating!,
                              ticketType: listAfterFilter[i].ticketType,
                              termList: listAfterFilter[i].terms,
                              location: "",
                              fullLocation: "",
                              timeClose: listAfterFilter[i].timeHeld!,
                              timeOpen: "",
                              description: listAfterFilter[i].description,
                              imageList: [],
                            ),
                          ));
                    },
                    child: HorizontalCard(
                      title: listAfterFilter[i].name,
                      rating: listAfterFilter[i].rating,
                      heldAt: listAfterFilter[i].timeHeld,
                      price: listAfterFilter[i].price.toString(),
                      imageUrl: listAfterFilter[i].imageUrl!,
                    ),
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildRecommend(List allDataAfterFilter) {
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
                          paymentMethod: allDataAfterFilter[i].paymentMethod,
                          menuRestaurantsList:
                              allDataAfterFilter[i].type == "restaurant"
                                  ? allDataAfterFilter[i].menu
                                  : [],
                          facilityList: allDataAfterFilter[i].type == "hotel" ||
                                  allDataAfterFilter[i].type == "destination"
                              ? allDataAfterFilter[i].facility!
                              : [],
                          price: allDataAfterFilter[i].type == "restaurant"
                              ? allDataAfterFilter[i]
                                  .menu!
                                  .first
                                  .price
                                  .toString()
                              : allDataAfterFilter[i].type == "hotel"
                                  ? allDataAfterFilter[i]
                                      .rooms!
                                      .first
                                      .priceRoom
                                      .toString()
                                  : allDataAfterFilter[i].tickets,
                          roomList: allDataAfterFilter[i].type == "hotel"
                              ? allDataAfterFilter[i].rooms!
                              : [],
                          googleMapsUrl: allDataAfterFilter[i].googleMapsLink!,
                          type: allDataAfterFilter[i].type,
                          imageUrl:
                              allDataAfterFilter[i].images!.first.imageUrl != ""
                                  ? allDataAfterFilter[i].images!.first.imageUrl
                                  : "",
                          name: allDataAfterFilter[i].name,
                          rating: allDataAfterFilter[i].rating,
                          location:
                              allDataAfterFilter[i].address!.split(',')[0] == ""
                                  ? allDataAfterFilter[i].address!.split(',')[0]
                                  : allDataAfterFilter[i]
                                      .address!
                                      .split(',')[3],
                          fullLocation: allDataAfterFilter[i].address!,
                          timeClose: allDataAfterFilter[i].type ==
                                      "restaurant" ||
                                  allDataAfterFilter[i].type == "destination"
                              ? allDataAfterFilter[i].timeClosed
                              : "",
                          timeOpen: allDataAfterFilter[i].type ==
                                      "restaurant" ||
                                  allDataAfterFilter[i].type == "destination"
                              ? allDataAfterFilter[i].timeOpen!
                              : "",
                          description: allDataAfterFilter[i].description,
                          imageList: allDataAfterFilter[i].images!.isNotEmpty
                              ? allDataAfterFilter[i].images!
                              : [],
                        ),
                      ));
                },
                child: VerticalCard(
                  deleteFunction: () {},
                  isShowRating: true,
                  title: allDataAfterFilter[i].name,
                  subDistrict:
                      allDataAfterFilter[i].address!.split(',')[0] == ""
                          ? allDataAfterFilter[i].address!.split(',')[0]
                          : allDataAfterFilter[i].address!.split(',')[3],
                  price: allDataAfterFilter[i].type == "restaurant"
                      ? allDataAfterFilter[i].menu!.isEmpty
                          ? ""
                          : allDataAfterFilter[i].menu!.first.price.toString()
                      : allDataAfterFilter[i].type == "hotel"
                          ? allDataAfterFilter[i]
                              .rooms!
                              .first
                              .priceRoom
                              .toString()
                          : allDataAfterFilter[i]
                              .tickets!
                              .first
                              .price
                              .toString(),
                  rating: allDataAfterFilter[i].rating.toString(),
                  imageUrl: allDataAfterFilter[i].images!.isNotEmpty
                      ? allDataAfterFilter[i].images!.first.imageUrl
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

  _buildSearchList(List allDataAfterFilter) {
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
                            paymentMethod:
                                allDataAfterFilter[i].paymentMethod.isEmpty
                                    ? []
                                    : allDataAfterFilter[i].paymentMethod,
                            menuRestaurantsList:
                                allDataAfterFilter[i].type == "restaurant"
                                    ? allDataAfterFilter[i].menu
                                    : [],
                            facilityList: allDataAfterFilter[i].type ==
                                        "hotel" ||
                                    allDataAfterFilter[i].type == "destination"
                                ? allDataAfterFilter[i].facility!
                                : [],
                            price: allDataAfterFilter[i].type == "restaurant"
                                ? allDataAfterFilter[i]
                                    .menu!
                                    .first
                                    .price
                                    .toString()
                                : allDataAfterFilter[i].type == "hotel"
                                    ? allDataAfterFilter[i]
                                        .rooms!
                                        .first
                                        .priceRoom
                                        .toString()
                                    : allDataAfterFilter[i].tickets,
                            roomList: allDataAfterFilter[i].type == "hotel"
                                ? allDataAfterFilter[i].rooms!
                                : [],
                            googleMapsUrl:
                                allDataAfterFilter[i].googleMapsLink!,
                            type: allDataAfterFilter[i].type,
                            imageUrl: allDataAfterFilter[i]
                                        .images!
                                        .first
                                        .imageUrl !=
                                    ""
                                ? allDataAfterFilter[i].images!.first.imageUrl
                                : "",
                            name: allDataAfterFilter[i].name,
                            rating: allDataAfterFilter[i].rating,
                            location: allDataAfterFilter[i]
                                        .address!
                                        .split(',')[0] ==
                                    ""
                                ? allDataAfterFilter[i].address!.split(',')[0]
                                : allDataAfterFilter[i].address!.split(',')[3],
                            fullLocation: allDataAfterFilter[i].address!,
                            timeClose: allDataAfterFilter[i].type ==
                                        "restaurant" ||
                                    allDataAfterFilter[i].type == "destination"
                                ? allDataAfterFilter[i].timeClosed!
                                : "",
                            timeOpen: allDataAfterFilter[i].type ==
                                        "restaurant" ||
                                    allDataAfterFilter[i].type == "destination"
                                ? allDataAfterFilter[i].timeOpen!
                                : "",
                            description: allDataAfterFilter[i].description,
                            imageList: allDataAfterFilter[i].images!.isNotEmpty
                                ? allDataAfterFilter[i].images!
                                : [],
                          ),
                        ));
                  },
                  child: VerticalCard(
                    deleteFunction: () {},
                    isShowRating: true,
                    title: allDataAfterFilter[i].name,
                    subDistrict: allDataAfterFilter[i].type == "event"
                        ? ""
                        : allDataAfterFilter[i].address!.split(',')[0] == ""
                            ? allDataAfterFilter[i].address!.split(',')[0]
                            : allDataAfterFilter[i].address!.split(',')[3],
                    price: allDataAfterFilter[i].type == "restaurant"
                        ? allDataAfterFilter[i].menu!.first.price.toString()
                        : allDataAfterFilter[i].type == "hotel"
                            ? allDataAfterFilter[i]
                                .rooms!
                                .first
                                .priceRoom
                                .toString()
                            : allDataAfterFilter[i].type == "destination"
                                ? allDataAfterFilter[i]
                                    .tickets!
                                    .first
                                    .price
                                    .toString()
                                : allDataAfterFilter[i].price.toString(),
                    rating: allDataAfterFilter[i].rating.toString(),
                    imageUrl: allDataAfterFilter[i].type == "event"
                        ? allDataAfterFilter[i].imageUrl
                        : allDataAfterFilter[i].images!.isNotEmpty
                            ? allDataAfterFilter[i].images!.first.imageUrl
                            : "",
                  ),
                ),
            ],
          );
  }
}
