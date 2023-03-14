import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/color_values.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_boy/component/vertical_card.dart';
import 'package:trip_boy/models/event_model.dart';
import 'package:trip_boy/models/hotel_model.dart';
import 'package:trip_boy/ui/user/detail_image.dart';
import 'package:trip_boy/ui/user/menu_detail_restaurant.dart';
import 'package:trip_boy/ui/user/event_reservation_ticket.dart';
import 'package:trip_boy/ui/user/tour_reservation_ticket.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/shared_code.dart';
import '../../models/content_model.dart';
import '../../models/destination_model.dart';
import '../../models/restaurant_model.dart';

class DetailPage extends StatefulWidget {
  String type,
      imageUrl,
      name,
      location,
      fullLocation,
      timeOpen,
      timeClose,
      description,
      googleMapsUrl;
  String? timeHeld, ticketType;
  var price;
  double rating;
  List imageList;
  List<RoomHotel> roomList;
  List<MenuRestaurant> menuRestaurantsList;
  List<TermEvent>? termList;
  List<PaymentMethodEvent>? paymentMethodEvent;
  List? paymentMethod;
  List facilityList;
  DetailPage(
      {super.key,
      required this.type,
      required this.imageUrl,
      required this.name,
      required this.price,
      required this.rating,
      required this.location,
      required this.fullLocation,
      required this.timeOpen,
      required this.timeClose,
      required this.menuRestaurantsList,
      this.termList,
      this.timeHeld,
      this.ticketType,
      this.paymentMethodEvent,
      this.paymentMethod,
      required this.description,
      required this.imageList,
      required this.googleMapsUrl,
      required this.roomList,
      required this.facilityList});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  bool isReadMore = false;
  TabController? hotelTabController;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hotelTabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var length = widget.imageList.length > 3 ? 3 : widget.imageList.length;
    return Scaffold(
      body: SafeArea(
        child: Container(
            height: MediaQuery.of(context).size.height.sp,
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        iconSize: 20,
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: ColorValues().primaryColor,
                        )),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.detail,
                        style: AppTextStyles.appTitlew500s16(
                            ColorValues().veryBlackColor),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Container(
                    // height: MediaQuery.of(context).size.height * 0.7.sp,
                    width: MediaQuery.of(context).size.width.sp,
                    child: widget.type == "restaurant"
                        ? buildRestaurantDetail(length)
                        : widget.type == "hotel"
                            ? buildHotelDetail(length)
                            : widget.type == "event"
                                ? buildEventDetail()
                                : buildDestinationDetail(),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  buildRestaurantDetail(length) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 170.sp,
          width: MediaQuery.of(context).size.width.sp,
          child: widget.imageUrl.startsWith("/")
              ? Image(
                  image: FileImage(
                  File(widget.imageUrl),
                ))
              : widget.imageUrl == ""
                  ? Image.asset("assets/png_image/logo.png",
                      fit: BoxFit.cover, filterQuality: FilterQuality.high)
                  : Image.network(widget.imageUrl,
                      fit: BoxFit.cover, filterQuality: FilterQuality.high),
        ),
        SizedBox(
          height: 10.sp,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: AppTextStyles.appTitlew500s16(ColorValues().blackColor),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Icon(
                      Icons.star,
                      color: ColorValues().starColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5.sp,
                    ),
                    Text(
                      widget.rating.toString(),
                      style: AppTextStyles.appTitlew400s12(
                          ColorValues().blackColor),
                    )
                  ]),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: ColorValues().blackColor),
                      Text(widget.location)
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Icon(
                      Icons.schedule,
                      color: ColorValues().blackColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5.sp,
                    ),
                    Text(
                      AppLocalizations.of(context)!.timeOpen,
                      style: AppTextStyles.appTitlew400s12(
                          ColorValues().blackColor),
                    )
                  ]),
                  Wrap(
                    children: [
                      Text(widget.timeOpen),
                      Text(" - "),
                      Text(widget.timeClose),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 5.sp,
              ),
              Wrap(
                spacing: 2,
                children: [
                  Text(
                    widget.description,
                    maxLines: isReadMore ? null : 3,
                    overflow: TextOverflow.fade,
                    style:
                        AppTextStyles.appTitlew400s12(ColorValues().blackColor),
                  ),
                  widget.description.length < 100
                      ? Container()
                      : isReadMore
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  isReadMore = false;
                                });
                              },
                              child: Text(
                                  AppLocalizations.of(context)!.showLess,
                                  style: AppTextStyles.appTitlew500s12(
                                      ColorValues().primaryColor)),
                            )
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  isReadMore = true;
                                });
                              },
                              child: Text(
                                  AppLocalizations.of(context)!.readMore,
                                  style: AppTextStyles.appTitlew500s12(
                                      ColorValues().primaryColor)),
                            )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                AppLocalizations.of(context)!.galery,
                style: AppTextStyles.appTitlew400s16(ColorValues().blackColor),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                width: MediaQuery.of(context).size.width.sp,
                height: 100.sp,
                child: GridView.count(
                    crossAxisSpacing: 10,
                    crossAxisCount: 3,
                    children: List.generate(
                      length,
                      (index) {
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: widget.imageList[index]!.imageUrl
                                      .startsWith("/")
                                  ? Image(
                                      image: FileImage(
                                      File(widget.imageList[index]!.imageUrl),
                                    ))
                                  : widget.imageList[index]!.imageUrl == ""
                                      ? Image.asset("assets/png_image/logo.png",
                                          fit: BoxFit.cover,
                                          filterQuality: FilterQuality.high)
                                      : Image.network(
                                          widget.imageList[index]!.imageUrl,
                                          fit: BoxFit.cover,
                                          filterQuality: FilterQuality.high),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (index == 2) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailImage(
                                            imageList: widget.imageList),
                                      ));
                                }
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: index != 2 ||
                                            widget.imageList.length == 3
                                        ? Colors.transparent
                                        : ColorValues()
                                            .veryBlackColor
                                            .withOpacity(0.75),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: index == 2
                                      ? widget.imageList.length == 3
                                          ? Container()
                                          : Center(
                                              child: Text(
                                                "+ ${widget.imageList.length - 3}",
                                                style: AppTextStyles
                                                    .appTitlew700s18(
                                                        Colors.white),
                                              ),
                                            )
                                      : Container()),
                            ),
                          ],
                        );
                      },
                    )),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                width: MediaQuery.of(context).size.width.sp,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MenuDetailPage(
                          listRestaurantsMenu: widget.menuRestaurantsList,
                          restaurantName: widget.name,
                          rating: widget.rating,
                          address: widget.location,
                          timeClosed: widget.timeClose,
                          timeOpen: widget.timeOpen,
                        ),
                      ));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.showMenu,
                      style: AppTextStyles.appTitlew400s14(
                          ColorValues().primaryColor),
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Color(0xFF6F38C5).withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
              ),
            ],
          ),
        ),
      ],
    );
  }

  buildHotelDetail(length) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 170.sp,
          width: MediaQuery.of(context).size.width.sp,
          child: Stack(
            children: [
              widget.imageUrl.startsWith("/")
                  ? Image(
                      image: FileImage(
                      File(widget.imageUrl),
                    ))
                  : widget.imageUrl == ""
                      ? Image.asset("assets/png_image/logo.png",
                          fit: BoxFit.cover, filterQuality: FilterQuality.high)
                      : Image.network(widget.imageUrl,
                          fit: BoxFit.cover, filterQuality: FilterQuality.high),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, ColorValues().veryBlackColor],
                  ),
                  color: ColorValues().veryBlackColor.withOpacity(0.45),
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(left: 12.sp, bottom: 12.sp),
                child: Text(
                  widget.name,
                  style: AppTextStyles.appTitlew500s20(Colors.white),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on,
                    color: ColorValues().blackColor,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5.sp,
                  ),
                  Expanded(child: Text(widget.fullLocation))
                ],
              ),
              Row(children: [
                Icon(
                  Icons.star,
                  color: ColorValues().starColor,
                  size: 20,
                ),
                SizedBox(
                  width: 5.sp,
                ),
                Text(
                  widget.rating.toString(),
                  style:
                      AppTextStyles.appTitlew500s12(ColorValues().blackColor),
                )
              ]),
              SizedBox(
                height: 5.sp,
              ),
              Container(
                height: 30.sp,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () {
                      Uri uri = Uri.parse(widget.googleMapsUrl);
                      _launchInBrowser(uri);
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Color(0xFF6F38C5).withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      AppLocalizations.of(context)!.clickToOpenMaps,
                      style: AppTextStyles.appTitlew400s14(
                          ColorValues().primaryColor),
                    )),
              ),
              Container(
                height: 230.sp,
                child: buildTabBar(),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                width: MediaQuery.of(context).size.width.sp,
                child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      AppLocalizations.of(context)!.reservation,
                      style: AppTextStyles.appTitlew400s14(
                          ColorValues().primaryColor),
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Color(0xFF6F38C5).withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
              ),
            ],
          ),
        ),
      ],
    );
  }

  buildTabBar() {
    return Column(
      children: [
        TabBar(
            indicatorColor: ColorValues().primaryColor,
            labelColor: ColorValues().blackColor,
            controller: hotelTabController,
            tabs: [
              Tab(text: AppLocalizations.of(context)!.description),
              Tab(text: AppLocalizations.of(context)!.room),
              Tab(text: AppLocalizations.of(context)!.facility)
            ]),
        Expanded(
          child: TabBarView(
              clipBehavior: Clip.none,
              controller: hotelTabController,
              children: [
                buildDescriptionHotel(),
                buildRoomList(),
                buildFacilityHotel(),
              ]),
        )
      ],
    );
  }

  buildDescriptionHotel() {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        widget.description + widget.description + widget.description,
        textAlign: TextAlign.justify,
        style: AppTextStyles.appTitlew400s12(ColorValues().blackColor),
      ),
    );
  }

  buildRoomList() {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.roomList.length,
        itemBuilder: (context, index) {
          return VerticalCard(
             deleteFunction: () {
                        
                      },
            title: widget.roomList[index].sizeRoom,
            subDistrict: "",
            price: widget.roomList[index].priceRoom.toString(),
            rating: "",
            imageUrl: "",
            isShowRating: false,
          );
        },
      ),
    );
  }

  buildFacilityHotel() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width.sp,
      height: 50.sp,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        scrollDirection: Axis.vertical,
        itemCount: widget.facilityList.length,
        itemBuilder: (context, index) {
          var iconData = widget.facilityList[index]!.name == "toilet"
              ? Icons.wc
              : widget.facilityList[index]!.name == "mosque"
                  ? Icons.mosque
                  : widget.facilityList[index]!.name == "restaurant"
                      ? Icons.restaurant
                      : widget.facilityList[index]!.name == "swimming pool"
                          ? Icons.pool
                          : widget.facilityList[index]!.name == "wifi"
                              ? Icons.wifi
                              : widget.facilityList[index]!.name ==
                                      "smoking area"
                                  ? Icons.smoking_rooms
                                  : widget.facilityList[index]!.name ==
                                          "free breakfast"
                                      ? Icons.free_breakfast
                                      : widget.facilityList[index]!.name ==
                                              "bar"
                                          ? Icons.wine_bar
                                          : widget.facilityList[index]!.name ==
                                                  "easy reservation"
                                              ? Icons.book_online
                                              : null;
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.facilityList[index]!.name == "playground"
                    ? Image(
                        image: AssetImage("assets/png_image/playground.png"))
                    : Icon(iconData),
                Text(
                  widget.facilityList[index]!.name
                          .substring(0, 1)
                          .toUpperCase() +
                      widget.facilityList[index]!.name
                          .substring(1, widget.facilityList[index]!.name.length)
                          .toLowerCase(),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  buildDestinationDetail() {
    return Container(
      margin: EdgeInsets.only(left: 12.sp, right: 12.sp),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.sp,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 10.sp),
              child: Row(
                children: [
                  widget.imageUrl.startsWith("/")
                      ? Image(
                          image: FileImage(
                          File(widget.imageUrl),
                        ))
                      : widget.imageList.length == 0
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset("assets/png_image/logo.png",
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.high),
                            )
                          : Expanded(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: widget.imageUrl.startsWith("/")
                                          ? Image(
                                              image: FileImage(
                                              File(widget.imageUrl),
                                            ))
                                          : widget.imageList[0]!.imageUrl == ""
                                              ? Image.asset(
                                                  "assets/png_image/logo.png",
                                                  fit: BoxFit.cover,
                                                  filterQuality:
                                                      FilterQuality.high)
                                              : Image.network(
                                                  widget.imageList[0]!.imageUrl,
                                                  fit: BoxFit.cover,
                                                  filterQuality:
                                                      FilterQuality.high),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                  widget.imageList.length < 2
                      ? Container()
                      : SizedBox(
                          width: 10,
                        ),
                  widget.imageList.length < 2
                      ? Container()
                      : Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: widget.imageUrl.startsWith("/")
                                        ? Image(
                                            image: FileImage(
                                            File(widget.imageUrl),
                                          ))
                                        : widget.imageList[1]!.imageUrl == ""
                                            ? Image.asset(
                                                "assets/png_image/logo.png",
                                                fit: BoxFit.cover,
                                                filterQuality:
                                                    FilterQuality.high)
                                            : Image.network(
                                                widget.imageList[1]!.imageUrl,
                                                fit: BoxFit.cover,
                                                filterQuality:
                                                    FilterQuality.high)),
                              ),
                              widget.imageList.length < 3
                                  ? Container()
                                  : SizedBox(
                                      height: 10,
                                    ),
                              widget.imageList.length < 3
                                  ? Container()
                                  : Expanded(
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              widget.imageUrl.startsWith("/")
                                                  ? Image(
                                                      image: FileImage(
                                                      File(widget.imageUrl),
                                                    ))
                                                  : widget.imageList[2]!
                                                              .imageUrl ==
                                                          ""
                                                      ? Image.asset(
                                                          "assets/png_image/logo.png",
                                                          fit: BoxFit.cover,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high)
                                                      : Image.network(
                                                          widget.imageList[2]!
                                                              .imageUrl,
                                                          fit: BoxFit.cover,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high),
                                              widget.imageList.length > 3
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        color: ColorValues()
                                                            .veryBlackColor
                                                            .withOpacity(0.45),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Lihat Semua",
                                                          style: AppTextStyles
                                                              .appTitlew400s18(
                                                                  Colors.white),
                                                        ),
                                                      ))
                                                  : Container(),
                                            ],
                                          )),
                                    ),
                            ],
                          ),
                        )
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  widget.name,
                  style:
                      AppTextStyles.appTitlew500s14(ColorValues().blackColor),
                ),
                Spacer(),
                Row(children: [
                  Icon(
                    Icons.star,
                    color: ColorValues().starColor,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5.sp,
                  ),
                  Text(
                    widget.rating.toString(),
                    style:
                        AppTextStyles.appTitlew500s12(ColorValues().blackColor),
                  )
                ]),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  color: ColorValues().blackColor,
                  size: 20,
                ),
                SizedBox(
                  width: 5.sp,
                ),
                Expanded(child: Text(widget.fullLocation))
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.schedule,
                  color: ColorValues().blackColor,
                  size: 20,
                ),
                SizedBox(
                  width: 5.sp,
                ),
                Wrap(
                  children: [
                    Text(widget.timeOpen),
                    Text(" - "),
                    Text(widget.timeClose),
                  ],
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.confirmation_number,
                  color: ColorValues().blackColor,
                  size: 20,
                ),
                SizedBox(
                  width: 5.sp,
                ),
                for (var i = 0; i < widget.price.length; i++)
                  Wrap(
                    children: [
                      Text("Rp. "),
                      Text("${widget.price[i].price}"),
                      Text(" / "),
                      Text("Tiket"),
                    ],
                  )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              thickness: 2,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              AppLocalizations.of(context)!.description,
              style: AppTextStyles.appTitlew500s16(ColorValues().blackColor),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.description,
              maxLines: isReadMore ? null : 8,
              overflow: TextOverflow.fade,
              style: AppTextStyles.appTitlew400s12(ColorValues().blackColor),
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              thickness: 2,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              AppLocalizations.of(context)!.facility,
              style: AppTextStyles.appTitlew500s16(ColorValues().blackColor),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width.sp,
              height: 50.sp,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.facilityList.length,
                itemBuilder: (context, index) {
                  var iconData = widget.facilityList[index]!.name == "toilet"
                      ? Icons.wc
                      : widget.facilityList[index]!.name == "mosque"
                          ? Icons.mosque
                          : widget.facilityList[index]!.name == "restaurant"
                              ? Icons.restaurant
                              : widget.facilityList[index]!.name ==
                                      "swimming pool"
                                  ? Icons.pool
                                  : widget.facilityList[index]!.name == "wifi"
                                      ? Icons.wifi
                                      : widget.facilityList[index]!.name ==
                                              "smoking area"
                                          ? Icons.smoking_rooms
                                          : widget.facilityList[index]!.name ==
                                                  "free breakfast"
                                              ? Icons.lunch_dining
                                              : widget.facilityList[index]!
                                                          .name ==
                                                      "bar"
                                                  ? Icons.local_bar
                                                  : widget.facilityList[index]!
                                                              .name ==
                                                          "easy reservation"
                                                      ? Icons.receipt
                                                      : null;
                  return Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Column(
                      children: [
                        widget.facilityList[index]!.name == "playground"
                            ? Image.asset("assets/png_image/playground.png")
                            : Icon(iconData),
                        Text(widget.facilityList[index]!.name
                                .substring(0, 1)
                                .toUpperCase() +
                            widget.facilityList[index]!.name
                                .substring(
                                    1, widget.facilityList[index]!.name.length)
                                .toLowerCase())
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width.sp,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => TourReservationTicket())));
                    });
                  },
                  child: Text(
                    AppLocalizations.of(context)!.reserveTicket,
                    style: AppTextStyles.appTitlew400s14(
                        ColorValues().primaryColor),
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Color(0xFF6F38C5).withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
            ),
          ],
        ),
      ),
    );
  }

  buildEventDetail() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 170.sp,
            width: MediaQuery.of(context).size.width.sp,
            child: Stack(
              children: [
                widget.imageUrl.startsWith("/")
                    ? Image(
                        image: FileImage(
                        File(widget.imageUrl),
                      ))
                    : widget.imageUrl == ""
                        ? Image.asset("assets/png_image/logo.png",
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high)
                        : Image.network(widget.imageUrl,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        ColorValues().veryBlackColor
                      ],
                    ),
                    color: ColorValues().veryBlackColor.withOpacity(0.45),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  margin: EdgeInsets.only(
                    left: 12.sp,
                    right: 12.sp,
                    bottom: 12.sp,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.name,
                        style: AppTextStyles.appTitlew500s18(Colors.white),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: Icon(
                              Icons.star,
                              size: 20,
                              color: ColorValues().starColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: Text(
                              widget.rating.toString(),
                              style:
                                  AppTextStyles.appTitlew400s14(Colors.white),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: buildDescFestival()),
          Container(
              margin: SharedCode.globalMargin,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorValues().primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EventReservationTicket(
                        title: widget.name,
                        ticketPrice: widget.price,
                        terms: widget.termList!,
                        contentDesc: widget.description,
                        contentType: widget.type,
                        contentRating: widget.rating,
                        dateHeld: widget.timeClose,
                        paymentMethods: widget.paymentMethodEvent!))),
                child: Text(AppLocalizations.of(context)!.reserveTicket,
                    style: AppTextStyles.appTitlew500s14(
                      Colors.white,
                    )),
              ))
        ],
      ),
    );
  }

  Widget buildDescFestival() {
    return SingleChildScrollView(
      child: Container(
        margin: SharedCode.globalMargin,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            AppLocalizations.of(context)!.description,
            style: AppTextStyles.appTitlew500s14(ColorValues().blackColor),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              widget.description,
              textAlign: TextAlign.justify,
              style: AppTextStyles.appTitlew400s12(ColorValues().blackColor),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Icon(
                  Icons.confirmation_number,
                  size: 20,
                  color: ColorValues().blackColor,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: widget.price == 0
                        ? Text(
                            "Free",
                            style: AppTextStyles.appTitlew500s14(
                                ColorValues().blackColor),
                          )
                        : Text(
                            "Rp${widget.price.toString()} / guest",
                            style: AppTextStyles.appTitlew500s14(
                                ColorValues().blackColor),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      widget.ticketType![0].toUpperCase() +
                          widget.ticketType!.substring(1),
                      style: AppTextStyles.appTitlew500s14(
                          ColorValues().blackColor),
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Icon(
                  Icons.date_range,
                  size: 20,
                  color: ColorValues().blackColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  widget.timeClose,
                  style:
                      AppTextStyles.appTitlew500s14(ColorValues().blackColor),
                ),
              )
            ],
          ),
          widget.termList!.isEmpty
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    AppLocalizations.of(context)!.termTitle,
                    style:
                        AppTextStyles.appTitlew500s14(ColorValues().blackColor),
                  ),
                ),
          for (int i = 0; i < widget.termList!.length; i++)
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${(i + 1).toString()})"),
                  SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: Text(
                      "${widget.termList![i].text}",
                      textAlign: TextAlign.justify,
                      style: AppTextStyles.appTitlew400s12(
                          ColorValues().blackColor),
                    ),
                  ),
                ],
              ),
            ),
        ]),
      ),
    );
  }
}
