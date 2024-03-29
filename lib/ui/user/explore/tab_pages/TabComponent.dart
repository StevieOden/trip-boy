import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/color_values.dart';
import '../../../../common/user_data.dart';
import '../../../../component/skeleton.dart';
import '../../../../component/vertical_card.dart';
import '../../../../models/content_model.dart';
import '../../../../models/destination_model.dart';
import '../../../../models/event_model.dart';
import '../../../../models/hotel_model.dart';
import '../../../../models/restaurant_model.dart';
import '../../../../services/database_services.dart';
import '../../detail_page.dart';

class TabComponent extends StatefulWidget {
  TabController tabController;
  TabComponent({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  State<TabComponent> createState() => _TabComponentState();
}

class _TabComponentState extends State<TabComponent> {
  bool _isLoading = true;
  List<RestaurantModel> restaurantData = [];
  List<DestinationModel> destinationData = [];
  List<HotelModel> hotelData = [];
  List allData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllData();
  }

  Future<void> getAllData() async {
    setLoading(true);
    restaurantData =
        await DatabaseService().getRestaurantData(false, UserData().uid);
    destinationData =
        await DatabaseService().getDestinationData(false, UserData().uid);
    hotelData = await DatabaseService().getHotelData(false, UserData().uid);
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
    if (widget.tabController.index == 0) {
      allData = restaurantData;
    } else if (widget.tabController.index == 1) {
      allData = hotelData;
    } else if (widget.tabController.index == 2) {
      allData = destinationData;
    }
    return _isLoading
        ? NewsCardSkeltonTab()
        : SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
              child: Column(
                children: [
                  buildPopular(allData),
                  buildRekomendasi(allData),
                  buildListAll(allData)
                ],
              ),
            ),
          );
  }

  Widget buildRekomendasi(List listData) {
    return Container(
      margin: EdgeInsets.only(top: 10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.recommendation,
            style: AppTextStyles.appTitlew500s14(ColorValues().blackColor),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.sp),
            height: MediaQuery.of(context).size.height * 0.35.sp,
            width: MediaQuery.of(context).size.width.sp,
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              children: List.generate(
                listData.length,
                (index) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            menuRestaurantsList:
                                listData[index].type == "restaurant"
                                    ? listData[index].menu
                                    : [],
                            facilityList: listData[index].type == "hotel" ||
                                    listData[index].type == "destination"
                                ? listData[index].facility!
                                : [],
                            price: listData[index].type == "restaurant"
                                ? listData[index].menu!.isEmpty
                                    ? ""
                                    : listData[index]
                                        .menu!
                                        .first
                                        .price
                                        .toString()
                                : listData[index].type == "hotel"
                                    ? listData[index]
                                        .rooms!
                                        .first
                                        .priceRoom
                                        .toString()
                                    : listData[index].tickets,
                            roomList: listData[index].type == "hotel"
                                ? listData[index].rooms!
                                : [],
                            googleMapsUrl: listData[index].googleMapsLink!,
                            type: listData[index].type,
                            imageUrl:
                                listData[index].images!.first.imageUrl != ""
                                    ? listData[index].images!.first.imageUrl
                                    : "",
                            name: listData[index].name,
                            rating: listData[index].rating,
                            location:
                                listData[index].address!.split(',')[0] == ""
                                    ? listData[index].address!.split(',')[0]
                                    : listData[index]
                                        .address!
                                        .split(',')[3]
                                        .split('.')[1],
                            fullLocation: listData[index].address!,
                            timeClose: listData[index].type == "restaurant" ||
                                    listData[index].type == "destination"
                                ? listData[index].timeClosed!
                                : "",
                            timeOpen: listData[index].type == "restaurant" ||
                                    listData[index].type == "destination"
                                ? listData[index].timeOpen!
                                : "",
                            description: listData[index].description,
                            imageList: listData[index].images!.isNotEmpty
                                ? listData[index].images!
                                : [],
                          ),
                        ));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        listData[index].images!.isEmpty
                            ? Image.asset("assets/png_image/logo.png",
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high)
                            : listData[index]
                                    .images!
                                    .first
                                    .imageUrl
                                    .startsWith("/")
                                ? Image(
                                    image: FileImage(
                                    File(
                                        listData[index].images!.first.imageUrl),
                                  ))
                                : listData[index].images!.first.imageUrl ==
                                            "" ||
                                        listData[index].images!.isEmpty == ""
                                    ? Image.asset("assets/png_image/logo.png",
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.high)
                                    : Image.network(
                                        listData[index].images!.first.imageUrl,
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.high),
                        Container(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            color:
                                ColorValues().veryBlackColor.withOpacity(0.45),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(listData[index].name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.appTitlew500s12(
                                        Colors.white)),
                              ),
                              Expanded(
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: ColorValues().starColor,
                                    ),
                                    Text(listData[index].rating.toString(),
                                        style: AppTextStyles.appTitlew500s12(
                                            Colors.white)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildPopular(List list) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        AppLocalizations.of(context)!.popular,
        style: AppTextStyles.appTitlew500s14(ColorValues().blackColor),
      ),
      Container(
          margin: EdgeInsets.only(top: 5.sp),
          height: MediaQuery.of(context).size.height * 0.35.sp,
          width: MediaQuery.of(context).size.width.sp,
          child: GridView.custom(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverQuiltedGridDelegate(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              pattern: [
                QuiltedGridTile(2, 1),
                QuiltedGridTile(1, 1),
                QuiltedGridTile(1, 1),
              ],
            ),
            childrenDelegate: SliverChildBuilderDelegate(
                (context, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                menuRestaurantsList:
                                    list[index].type == "restaurant"
                                        ? list[index].menu
                                        : [],
                                facilityList: list[index].type == "hotel" ||
                                        list[index].type == "destination"
                                    ? list[index].facility!
                                    : [],
                                price: list[index].type == "restaurant"
                                    ? list[index].menu!.isEmpty
                                        ? ""
                                        : list[index]
                                            .menu!
                                            .first
                                            .price
                                            .toString()
                                    : list[index].type == "hotel"
                                        ? list[index]
                                            .rooms!
                                            .first
                                            .priceRoom
                                            .toString()
                                        : list[index].tickets,
                                roomList: list[index].type == "hotel"
                                    ? list[index].rooms!
                                    : [],
                                googleMapsUrl: list[index].googleMapsLink!,
                                type: list[index].type,
                                imageUrl:
                                    list[index].images!.first.imageUrl != ""
                                        ? list[index].images!.first.imageUrl
                                        : "",
                                name: list[index].name,
                                rating: list[index].rating,
                                location:
                                    list[index].address!.split(',')[0] == ""
                                        ? list[index].address!.split(',')[0]
                                        : list[index]
                                            .address!
                                            .split(',')[3]
                                            .split('.')[1],
                                fullLocation: list[index].address!,
                                timeClose: list[index].type == "restaurant" ||
                                        list[index].type == "destination"
                                    ? list[index].timeClosed!
                                    : "",
                                timeOpen: list[index].type == "restaurant" ||
                                        list[index].type == "destination"
                                    ? list[index].timeOpen!
                                    : "",
                                description: list[index].description,
                                imageList: list[index].images!.isNotEmpty
                                    ? list[index].images!
                                    : [],
                              ),
                            ));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            list[index].images!.isEmpty
                                ? Image.asset("assets/png_image/logo.png",
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high)
                                : list[index]
                                        .images!
                                        .first
                                        .imageUrl
                                        .startsWith("/")
                                    ? Image(
                                        image: FileImage(
                                        File(
                                            list[index].images!.first.imageUrl),
                                      ))
                                    : list[index].images!.first.imageUrl ==
                                                "" ||
                                            list[index].images!.isEmpty == ""
                                        ? Image.asset(
                                            "assets/png_image/logo.png",
                                            fit: BoxFit.cover,
                                            filterQuality: FilterQuality.high)
                                        : Image.network(
                                            list[index].images!.first.imageUrl,
                                            fit: BoxFit.cover,
                                            filterQuality: FilterQuality.high),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                color: ColorValues()
                                    .veryBlackColor
                                    .withOpacity(0.45),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(list[index].name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyles.appTitlew500s12(
                                            Colors.white)),
                                  ),
                                  Expanded(
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: ColorValues().starColor,
                                        ),
                                        Text(list[index].rating.toString(),
                                            style:
                                                AppTextStyles.appTitlew500s12(
                                                    Colors.white)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                childCount: list.length > 3 ? 3 : list.length),
          ))
    ]);
  }

  buildListAll(List listData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 3.sp,
          ),
          child: Text(
            widget.tabController.index == 0
                ? AppLocalizations.of(context)!.allRestaurant
                : widget.tabController.index == 1
                    ? AppLocalizations.of(context)!.allHotel
                    : widget.tabController.index == 2
                        ? AppLocalizations.of(context)!.allTour
                        : AppLocalizations.of(context)!.allEvent,
            style: AppTextStyles.appTitlew500s14(ColorValues().blackColor),
          ),
        ),
        SizedBox(
          height: 5.sp,
        ),
        Column(
          children: [
            for (var i = 0; i < listData.length; i++)
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          menuRestaurantsList: listData[i].type == "restaurant"
                              ? listData[i].menu
                              : [],
                          facilityList: listData[i].type == "hotel" ||
                                  listData[i].type == "destination"
                              ? listData[i].facility!
                              : [],
                          price: listData[i].type == "restaurant"
                              ? listData[i].menu!.first.price.toString()
                              : listData[i].type == "hotel"
                                  ? listData[i]
                                      .rooms!
                                      .first
                                      .priceRoom
                                      .toString()
                                  : listData[i].tickets,
                          roomList: listData[i].type == "hotel"
                              ? listData[i].rooms!
                              : [],
                          googleMapsUrl: listData[i].googleMapsLink!,
                          type: listData[i].type,
                          imageUrl: listData[i].images!.first.imageUrl != ""
                              ? listData[i].images!.first.imageUrl
                              : "",
                          name: listData[i].name,
                          rating: listData[i].rating,
                          location: listData[i].address!.split(', ')[0] == ""
                              ? listData[i].address!.split(', ')[0]
                              : listData[i].address!.split(', ')[3],
                          fullLocation: listData[i].address!,
                          timeClose: listData[i].type == "restaurant" ||
                                  listData[i].type == "destination"
                              ? listData[i].timeClosed!
                              : "",
                          timeOpen: listData[i].type == "restaurant" ||
                                  listData[i].type == "destination"
                              ? listData[i].timeOpen!
                              : "",
                          description: listData[i].description,
                          imageList: listData[i].images!.isNotEmpty
                              ? listData[i].images!
                              : [],
                        ),
                      ));
                },
                child: VerticalCard(
                  deleteFunction: () {},
                  isShowRating: true,
                  title: listData[i].name,
                  subDistrict: listData[i].address!.split(',')[0] == ""
                      ? listData[i].address!.split(',')[0]
                      : listData[i].address!.split(',')[3],
                  price: listData[i].type == "restaurant"
                      ? listData[i].menu!.isEmpty
                          ? ""
                          : listData[i].menu!.first.price.toString()
                      : listData[i].type == "hotel"
                          ? listData[i].rooms!.first.priceRoom.toString()
                          : listData[i].tickets!.first.price.toString(),
                  rating: listData[i].rating.toString(),
                  imageUrl: listData[i].images!.isEmpty
                      ? ""
                      : listData[i].images!.first.imageUrl,
                ),
              )
          ],
        ),
      ],
    );
  }
}

class NewsCardSkeltonTab extends StatelessWidget {
  const NewsCardSkeltonTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.sp),
        child: Column(
          children: [
            buildPopular(context),
            buildRekomendasi(context),
            buildListAll(context)
          ],
        ),
      ),
    );
  }

  buildListAll(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(
              left: 3.sp,
            ),
            child: Skeleton(
              height: 20,
              width: 100,
            )),
        SizedBox(
          height: 5.sp,
        ),
        Column(
          children: [
            for (var i = 0; i < 6; i++)
              Container(
                margin: EdgeInsets.only(bottom: 12.sp, top: 12.sp),
                child: Skeleton(
                  width: MediaQuery.of(context).size.width.sp,
                  height: 60.sp,
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget buildRekomendasi(context) {
    return Container(
      margin: EdgeInsets.only(top: 10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Skeleton(
            width: 100,
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(top: 5.sp),
            height: MediaQuery.of(context).size.height * 0.35.sp,
            width: MediaQuery.of(context).size.width.sp,
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              children: List.generate(
                4,
                (index) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black.withOpacity(0.04),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildPopular(context) {
    return Container(
      margin: EdgeInsets.only(top: 10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Skeleton(
            width: 100,
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(top: 5.sp),
            height: 200.sp,
            width: MediaQuery.of(context).size.width.sp,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3.sp,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black.withOpacity(0.04)),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black.withOpacity(0.04)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black.withOpacity(0.04)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
