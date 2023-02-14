import 'package:flutter/material.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/color_values.dart';
import 'package:trip_boy/component/vertical_card.dart';
import 'package:trip_boy/ui/user/detail_checkout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MenuDetailPage extends StatefulWidget {
  MenuDetailPage({Key? key}) : super(key: key);

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
                  'D’ASMO RESTO',
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
                        Text('4.8 (32 Review)')
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
                        Text('Pulisen')
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
                        Text('13:00-21:00')
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
      height: 30,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 20, bottom: 10),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        separatorBuilder: (context, index) => Container(
          width: 3,
        ),
        itemBuilder: (context, index) => ChoiceChip(
          label: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                index == 0
                    ? Icon(
                        Icons.grid_view_rounded,
                        size: 13,
                        color: Colors.white,
                      )
                    : index == 1
                        ? Icon(
                            Icons.wine_bar_rounded,
                            size: 13,
                            color: Colors.white,
                          )
                        : index == 2
                            ? Icon(
                                Icons.fastfood,
                                size: 13,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.tapas,
                                size: 13,
                                color: Colors.white,
                              ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  chipList[index],
                  style: AppTextStyles.appTitlew500s10(Colors.white),
                )
              ],
            ),
          ),
          selected: _choiceIndex == index,
          selectedColor: ColorValues().primaryColor,
          onSelected: (bool selected) {
            setState(() {
              _choiceIndex = selected ? index : 0;
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
    );
  }

  Widget builGridView() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: gridViewMenu.length < 4 ? gridViewMenu.length : 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    gridViewMenu[index]["image"] == ""
                        ? Image.asset("assets/png_image/logo.png",
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high)
                        : Image.network(gridViewMenu[index]["image"],
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high),
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
              Container(
                margin: EdgeInsets.only(left: 6, top: 6),
                child: Text(
                  gridViewMenu[index]['name'],
                  style:
                      AppTextStyles.appTitlew400s14(ColorValues().blackColor),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 6, top: 6),
                child: Text(
                  gridViewMenu[index]['price'].toString(),
                  style:
                      AppTextStyles.appTitlew500s14(ColorValues().blackColor),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget buildBlankCardDrink() {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.drink,
              style: AppTextStyles.appTitlew500s16(ColorValues().blackColor)),
          SizedBox(
            height: 8,
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return VerticalCard(
                  isElevated: false,
                  title: "",
                  subDistrict: "",
                  price: "",
                  rating: "",
                  imageUrl: "");
            },
          ),
        ],
      ),
    );
  }

  Widget buildBlankCardFood() {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.food,
              style: AppTextStyles.appTitlew500s16(ColorValues().blackColor)),
          SizedBox(
            height: 8,
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return VerticalCard(
                  isElevated: false,
                  title: "",
                  subDistrict: "",
                  price: "",
                  rating: "",
                  imageUrl: "");
            },
          ),
        ],
      ),
    );
  }

  Widget buildBlankCardSnack() {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.snack,
              style: AppTextStyles.appTitlew500s16(ColorValues().blackColor)),
          SizedBox(
            height: 8,
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return VerticalCard(
                  isElevated: false,
                  title: "",
                  subDistrict: "",
                  price: "",
                  rating: "",
                  imageUrl: "");
            },
          ),
        ],
      ),
    );
  }
}
