import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/color_values.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_boy/component/vertical_card.dart';
import 'package:trip_boy/models/hotel_model.dart';
import 'package:trip_boy/ui/user/menu_detail_restaurant.dart';
import 'package:trip_boy/ui/user/event_reservation_ticket.dart';
import 'package:trip_boy/ui/user/tour_reservation_ticket.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/content_model.dart';

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
  String? timeHeld;
  var price;
  double rating;
  List imageList;
  List<RoomHotel> roomList;
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
      this.timeHeld,
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
                  child: SingleChildScrollView(
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
                children: [
                  Text(
                    widget.description,
                    maxLines: isReadMore ? null : 8,
                    overflow: TextOverflow.fade,
                    style:
                        AppTextStyles.appTitlew400s12(ColorValues().blackColor),
                  ),
                  isReadMore
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              isReadMore = false;
                            });
                          },
                          child: Text(AppLocalizations.of(context)!.readMore,
                              style: AppTextStyles.appTitlew400s12(
                                  ColorValues().primaryColor)),
                        )
                      : InkWell(
                          onTap: () {
                            setState(() {
                              isReadMore = true;
                            });
                          },
                          child: Text(AppLocalizations.of(context)!.readMore,
                              style: AppTextStyles.appTitlew400s12(
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
                              child: widget.imageList[index]!.imageUrl == ""
                                  ? Image.asset("assets/png_image/logo.png",
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.high)
                                  : Image.network(
                                      widget.imageList[index]!.imageUrl,
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.high),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  color: widget.imageList.length == 3
                                      ? ColorValues()
                                          .veryBlackColor
                                          .withOpacity(0.6)
                                      : ColorValues()
                                          .veryBlackColor
                                          .withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: index == 2
                                    ? Center(
                                        child: Text(
                                          "+ ${widget.imageList.length - 3}",
                                          style: AppTextStyles.appTitlew400s18(
                                              Colors.white),
                                        ),
                                      )
                                    : Container()),
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
                        builder: (context) => MenuDetailPage(),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 170.sp,
          width: MediaQuery.of(context).size.width.sp,
          child: Stack(
            children: [
              widget.imageUrl == ""
                  ? Image.asset("",
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
                margin: EdgeInsets.only(
                  left: 12.sp,
                  bottom: 12.sp,
                ),
                child: Text(
                  widget.name,
                  style: AppTextStyles.appTitlew500s18(Colors.white),
                ),
              ),
            ],
          ),
        ),
        buildDescFestival()
      ],
    );
  }

  Widget buildDescFestival() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(
          left: 20,
          top: 20,
        ),
        child: (Text(
          'Deskripsi',
          style: AppTextStyles.appTitlew500s14(ColorValues().blackColor),
        )),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
        child: Text(
          '''
Event kali ini cukup berbeda dengan mengusung tema makanan yaitu street food indonesia yang khsusnya adalah makanan khas Boyolali. Dengan berbagai macam rasa bentuk dari masing masing wilayah Boyolali.....selengkapnya''',
          style: AppTextStyles.appTitlew400s12(ColorValues().blackColor),
        ),
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Icon(
              Icons.location_on_outlined,
              size: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Text(
              'Alun-Alun Kidul Boyolali',
              style: AppTextStyles.appTitlew400s14(ColorValues().blackColor),
            ),
          )
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Icon(
              Icons.date_range,
              size: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Text(
              '03-10 Desember 2022',
              style: AppTextStyles.appTitlew400s14(ColorValues().blackColor),
            ),
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20, top: 20),
        child: Text(
          'Informasi Lainnya',
          style: AppTextStyles.appTitlew500s14(ColorValues().blackColor),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20, top: 10),
        child: Text(
          '''
Buka:
Senin - Sabtu mulai jam 10.00
Minggu mulai 06.00''',
          style: AppTextStyles.appTitlew400s12(ColorValues().blackColor),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20, top: 10),
        child: Text(
          '''Pemesanan tiket dapat dilakukan minimal 
6 jam sebelum festival dimulai
''',
          style: AppTextStyles.appTitlew400s12(ColorValues().blackColor),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20, top: 10),
        child: Text(
          'Ketentuan Pengunjung',
          style: AppTextStyles.appTitlew500s14(ColorValues().blackColor),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20, top: 10),
        child: Text(
          '''
1.) Sebelum Kunjungan, Pastikan Pengunjung telah  memiliki tiket digital yang telah di booking melalui Aplikasi T-Boy, tunjukkan tiket digital tersebut kepada petugas untuk dilakukan pengecekkan agar dapat di tukar menjadi tiket gelang.

2.) 1 Akun T-Boy hanya berlaku untuk 1 Orang.

3.)Pengunjung Festival harus dalam kondisi sehat, apabila terjadi gejala tidak sehat (flu, batuk, demam di atas 37,3 C) maka tidak diperkenankan untuk masuk kearea festival.

4.)Setiap Pengunjung wajib menggunakan masker dan mengikuti pengukuran suhu tubuh dan wajib scan di Aplikasi Peduli Lindungi.''',
          style: AppTextStyles.appTitlew400s12(ColorValues().blackColor),
        ),
      ),
      Container(
          margin: EdgeInsets.only(bottom: 10, top: 15),
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: ColorValues().primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)))),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EventReservationTicket())),
            child: Text('Pesan Tiket',
                style: AppTextStyles.appTitlew500s14(
                  Colors.white,
                )),
          ))
    ]);
  }
}
