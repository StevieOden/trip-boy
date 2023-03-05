import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/color_values.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_boy/models/content_model.dart';
import 'package:trip_boy/ui/user/explore/tab_pages/EventPages.dart';
import 'package:trip_boy/ui/user/explore/tab_pages/TabComponent.dart';

import '../../../common/user_data.dart';
import '../../../component/search_bar.dart';
import '../../../component/skeleton.dart';
import '../../../component/vertical_card.dart';
import '../../../models/destination_model.dart';
import '../../../models/event_model.dart';
import '../../../models/hotel_model.dart';
import '../../../models/restaurant_model.dart';
import '../../../services/database_services.dart';
import '../detail_page.dart';

class ExplorePage extends StatefulWidget {
  int exploreSelectionIndex;
  ExplorePage({super.key, this.exploreSelectionIndex = 0});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<RestaurantModel> restaurantData = [];
  List<EventModel> eventData = [];
  List<DestinationModel> destinationData = [];
  List<HotelModel> hotelData = [];
  List allData = [];
  final TextEditingController _searchController = TextEditingController();
  List allDataFiltered = [];
  String query = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
        length: 4, vsync: this, initialIndex: widget.exploreSelectionIndex);
    getAllData();
  }

  Future<void> combineAllList() async {
    allData.addAll(restaurantData);
    allData.addAll(destinationData);
    allData.addAll(hotelData);
    allData.addAll(eventData);
    allData.sort((a, b) => b.rating.compareTo(a.rating));
    allDataFiltered = allData;
    print(" data filtered length : ${allDataFiltered.length}");
  }

  Future<void> getAllData() async {
    restaurantData =
        await DatabaseService().getRestaurantData(false, UserData().uid);
    eventData = await DatabaseService().getEventData(false, UserData().uid);
    destinationData =
        await DatabaseService().getDestinationData(false, UserData().uid);
    hotelData = await DatabaseService().getHotelData(false, UserData().uid);
    combineAllList();
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
              height: 5.h,
              margin: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 10.sp),
              width: MediaQuery.of(context).size.width.w,
              child: SearchBar(
                controller: _searchController,
                onChanged: searchData,
              )),
          bottom: allDataFiltered.length != allData.length
              ? null
              : TabBar(
                  unselectedLabelColor: Colors.black,
                  labelStyle:
                      AppTextStyles.appTitlew500s10(ColorValues().primaryColor),
                  labelColor: ColorValues().primaryColor,
                  indicatorColor: ColorValues().primaryColor,
                  controller: _tabController,
                  tabs: [
                      Tab(
                        text: AppLocalizations.of(context)!.restaurant,
                      ),
                      Tab(
                        text: AppLocalizations.of(context)!.hotel,
                      ),
                      Tab(
                        text: AppLocalizations.of(context)!.tour,
                      ),
                      Tab(
                        text: AppLocalizations.of(context)!.event,
                      ),
                    ]),
        ),
        body: allDataFiltered.length != allData.length
            ? Container(
                margin: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 15),
                child: _buildSearchList(allDataFiltered),
              )
            : TabBarView(controller: _tabController, children: [
                TabComponent(
                  tabController: _tabController!,
                ),
                TabComponent(
                  tabController: _tabController!,
                ),
                TabComponent(
                  tabController: _tabController!,
                ),
                EventPages()
              ]),
      ),
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
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < allDataAfterFilter.length; i++)
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              menuRestaurantsList:
                                  allDataAfterFilter[i].type == "restaurant"
                                      ? allDataAfterFilter[i].menu
                                      : [],
                              facilityList:
                                  allDataAfterFilter[i].type == "hotel" ||
                                          allDataAfterFilter[i].type ==
                                              "destination"
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
                                      : allDataAfterFilter[i].type ==
                                              "destination"
                                          ? allDataAfterFilter[i].tickets
                                          : allDataAfterFilter[i]
                                              .price
                                              .toString(),
                              roomList: allDataAfterFilter[i].type == "hotel"
                                  ? allDataAfterFilter[i].rooms!
                                  : [],
                              googleMapsUrl:
                                  allDataAfterFilter[i].type != "event"
                                      ? allDataAfterFilter[i].googleMapsLink!
                                      : allDataFiltered[i].meetLink,
                              type: allDataAfterFilter[i].type,
                              imageUrl: allDataAfterFilter[i].type == "event"
                                  ? allDataAfterFilter[i].imageUrl
                                  : allDataAfterFilter[i]
                                              .images!
                                              .first
                                              .imageUrl !=
                                          ""
                                      ? allDataAfterFilter[i]
                                          .images!
                                          .first
                                          .imageUrl
                                      : "",
                              name: allDataAfterFilter[i].name,
                              rating: allDataAfterFilter[i].rating,
                              location: allDataAfterFilter[i].type == "event"
                                  ? ""
                                  : allDataAfterFilter[i]
                                              .address!
                                              .split(', ')[0] ==
                                          ""
                                      ? allDataAfterFilter[i]
                                          .address!
                                          .split(', ')[0]
                                      : allDataAfterFilter[i]
                                          .address!
                                          .split(', ')[3]
                                          .split('. ')[1],
                              fullLocation:
                                  allDataAfterFilter[i].type == "event"
                                      ? ""
                                      : allDataAfterFilter[i].address!,
                              timeClose: allDataAfterFilter[i].type == "event"
                                  ? ""
                                  : allDataAfterFilter[i].type ==
                                              "restaurant" ||
                                          allDataAfterFilter[i].type ==
                                              "destination"
                                      ? allDataAfterFilter[i].timeClosed!
                                      : "",
                              timeOpen: allDataAfterFilter[i].type == "event"
                                  ? ""
                                  : allDataAfterFilter[i].type ==
                                              "restaurant" ||
                                          allDataAfterFilter[i].type ==
                                              "destination"
                                      ? allDataAfterFilter[i].timeOpen!
                                      : "",
                              description: allDataAfterFilter[i].description,
                              imageList: allDataAfterFilter[i].type == "event"
                                  ? []
                                  : allDataAfterFilter[i].images!.isNotEmpty
                                      ? allDataAfterFilter[i].images!
                                      : [],
                            ),
                          ));
                    },
                    child: VerticalCard(
                      isShowRating: true,
                      title: allDataAfterFilter[i].name,
                      subDistrict: allDataAfterFilter[i].type != "event"
                          ? allDataAfterFilter[i].address.split(',')[0] == ""
                              ? allDataAfterFilter[i].address.split(',')[0]
                              : allDataAfterFilter[i].address.split(',')[3]
                          : "",
                      price: allDataAfterFilter[i].type == "restaurant"
                          ? allDataAfterFilter[i].menu.first.price.toString()
                          : allDataAfterFilter[i].type == "hotel"
                              ? allDataAfterFilter[i]
                                  .rooms
                                  .first
                                  .priceRoom
                                  .toString()
                              : allDataAfterFilter[i].type == "destination"
                                  ? allDataAfterFilter[i]
                                      .tickets
                                      .first
                                      .price
                                      .toString()
                                  : allDataAfterFilter[i].price.toString(),
                      rating: allDataAfterFilter[i].rating.toString(),
                      imageUrl: allDataAfterFilter[i].type != "event"
                          ? allDataAfterFilter[i].images!.isNotEmpty
                              ? allDataAfterFilter[i].images!.first!.imageUrl
                              : ""
                          : allDataAfterFilter[i].imageUrl,
                    ),
                  ),
              ],
            ),
          );
  }
}

class NewsCardSkelton extends StatelessWidget {
  const NewsCardSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Skeleton(height: 120, width: 120),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Skeleton(width: 80),
              const SizedBox(height: 16 / 2),
              const Skeleton(),
              const SizedBox(height: 16 / 2),
              const Skeleton(),
              const SizedBox(height: 16 / 2),
              Row(
                children: const [
                  Expanded(
                    child: Skeleton(),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Skeleton(),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
