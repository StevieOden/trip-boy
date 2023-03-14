import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/color_values.dart';
import 'package:trip_boy/component/vertical_card.dart';
import 'package:trip_boy/models/restaurant_model.dart';
import 'package:trip_boy/ui/user/detail_checkout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../common/user_data.dart';
import '../../services/database_services.dart';

class MenuDetailPage extends StatefulWidget {
  String restaurantName, address, timeOpen, timeClosed;
  double rating;
  List<MenuRestaurant> listRestaurantsMenu;
  MenuDetailPage(
      {Key? key,
      required this.restaurantName,
      required this.rating,
      required this.address,
      required this.timeOpen,
      required this.timeClosed,
      required this.listRestaurantsMenu})
      : super(key: key);

  @override
  State<MenuDetailPage> createState() => _MenuDetailPageState();
}

class _MenuDetailPageState extends State<MenuDetailPage> {
  List<String> chipList = [];
  List<Map> gridViewMenu = [
    {"name": "Nasi Goreng Ati", "image": "", "price": 25000},
    {"name": "Nasi Goreng Ati", "image": "", "price": 25000},
    {"name": "Nasi Goreng Ati", "image": "", "price": 25000},
    {"name": "Nasi Goreng Ati", "image": "", "price": 25000},
  ];
  int _choiceIndex = 0;
  ScrollController? _scrollController;
  final dataKeyAll = new GlobalKey();
  final dataKeyDrink = new GlobalKey();
  final dataKeyFood = new GlobalKey();
  final dataKeySnack = new GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    print(widget.listRestaurantsMenu);
  }

  @override
  Widget build(BuildContext context) {
    chipList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.drink,
      AppLocalizations.of(context)!.food,
      AppLocalizations.of(context)!.snack
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: ColorValues().primaryColor,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.restaurantName,
                  style:
                      AppTextStyles.appTitlew500s16(ColorValues().blackColor),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 18,
                          color: Colors.yellow.shade400,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(widget.rating.toString())
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 18,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(widget.address)
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.watch_later_outlined,
                          size: 18,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(AppLocalizations.of(context)!.timeOpen)
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Text('${widget.timeOpen} - ${widget.timeClosed}')
                      ],
                    ),
                  ],
                ),
                buildChipsCategory(),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    Container(key: dataKeyAll, child: builGridView()),
                    Container(key: dataKeyDrink, child: buildBlankCardDrink()),
                    Container(key: dataKeyFood, child: buildBlankCardFood()),
                    Container(key: dataKeySnack, child: buildBlankCardSnack())
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15, top: 15),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorValues().primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailCheckout())),
                  child: Text(AppLocalizations.of(context)!.cart)),
            )
          ],
        ),
      ),
    );
  }

  Widget buildChipsCategory() {
    return Container(
      child: Row(
        children: [
          for (int i = 0; i < chipList.length; i++)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 2, right: 2),
                child: ChoiceChip(
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        chipList[i],
                        style: AppTextStyles.appTitlew500s10(Colors.white),
                      )
                    ],
                  ),
                  selected: _choiceIndex == i,
                  selectedColor: ColorValues().primaryColor,
                  onSelected: (bool selected) {
                    setState(() {
                      _choiceIndex = selected ? i : 0;
                      var scrollPosition = _choiceIndex == 1
                          ? dataKeyDrink.currentContext
                          : _choiceIndex == 2
                              ? dataKeyFood.currentContext
                              : _choiceIndex == 3
                                  ? dataKeySnack.currentContext
                                  : dataKeyAll.currentContext;
                      Scrollable.ensureVisible(scrollPosition!);
                    });
                  },
                  backgroundColor: ColorValues().greyColor,
                  labelStyle: AppTextStyles.appTitlew500s10(Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget builGridView() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.listRestaurantsMenu.length < 4
            ? widget.listRestaurantsMenu.length
            : 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.8),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 150,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: widget.listRestaurantsMenu[index].imageUrl.startsWith("/")
                    ? Image(
                        image: FileImage(
                        File(widget.listRestaurantsMenu[index].imageUrl),
                      ))
                    :widget.listRestaurantsMenu[index].imageUrl == ""
                          ? Image.asset("assets/png_image/logo.png",
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high)
                          : Image.network(
                              widget.listRestaurantsMenu[index].imageUrl,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        color: ColorValues().veryBlackColor.withOpacity(0.45),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.listRestaurantsMenu[index].name,
                style: AppTextStyles.appTitlew400s14(ColorValues().blackColor),
              ),
              Text(
                widget.listRestaurantsMenu[index].price.toString(),
                style: AppTextStyles.appTitlew500s14(ColorValues().blackColor),
              )
            ],
          );
        },
      ),
    );
  }

  Widget buildBlankCardDrink() {
    List<MenuRestaurant> listRestaurantDrink = [];
    listRestaurantDrink.addAll(widget.listRestaurantsMenu
        .where((element) => element.type == "minuman"));
    return listRestaurantDrink.isEmpty
        ? Container()
        : Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.drink,
                    style: AppTextStyles.appTitlew500s16(
                        ColorValues().blackColor)),
                SizedBox(
                  height: 8,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listRestaurantDrink.length,
                  itemBuilder: (context, index) {
                    return VerticalCard(
                      deleteFunction: () {
                        
                      },
                        isElevated: false,
                        isShowRating: false,
                        title: listRestaurantDrink[index].name,
                        subDistrict: "",
                        price: listRestaurantDrink[index].price.toString(),
                        rating: "",
                        imageUrl: listRestaurantDrink[index].imageUrl);
                  },
                ),
              ],
            ),
          );
  }

  Widget buildBlankCardFood() {
    List<MenuRestaurant> listRestaurantFood = [];
    listRestaurantFood.addAll(widget.listRestaurantsMenu
        .where((element) => element.type == "makanan"));
    return listRestaurantFood.isEmpty
        ? Container()
        : Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.food,
                    style: AppTextStyles.appTitlew500s16(
                        ColorValues().blackColor)),
                SizedBox(
                  height: 8,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listRestaurantFood.length,
                  itemBuilder: (context, index) {
                    return VerticalCard(
                       deleteFunction: () {
                        
                      },
                        isElevated: false,
                        title: listRestaurantFood[index].name,
                        subDistrict: listRestaurantFood[index].desc,
                        price: listRestaurantFood[index].price.toString(),
                        rating: "",
                        imageUrl: listRestaurantFood[index].imageUrl);
                  },
                ),
              ],
            ),
          );
  }

  Widget buildBlankCardSnack() {
    List<MenuRestaurant> listRestaurantSnack = [];
    listRestaurantSnack.addAll(
        widget.listRestaurantsMenu.where((element) => element.type == "snack"));
    return listRestaurantSnack.isEmpty
        ? Container()
        : Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.snack,
                    style: AppTextStyles.appTitlew500s16(
                        ColorValues().blackColor)),
                SizedBox(
                  height: 8,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listRestaurantSnack.length,
                  itemBuilder: (context, index) {
                    return VerticalCard(
                       deleteFunction: () {
                        
                      },
                        isElevated: false,
                        title: listRestaurantSnack[index].name,
                        subDistrict: listRestaurantSnack[index].desc,
                        price: listRestaurantSnack[index].price.toString(),
                        rating: "",
                        imageUrl: listRestaurantSnack[index].imageUrl);
                  },
                ),
              ],
            ),
          );
  }
}
