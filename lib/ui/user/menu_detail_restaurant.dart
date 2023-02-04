import 'package:flutter/material.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/color_values.dart';

import 'detail_page.dart';

class MenuDetailPage extends StatefulWidget {
  MenuDetailPage({Key? key}) : super(key: key);

  @override
  State<MenuDetailPage> createState() => _MenuDetailPageState();
}

class _MenuDetailPageState extends State<MenuDetailPage> {
  List<String> chipList = ['Semua', 'Minuman', 'Makanan', 'Jajanan'];
  List<Map> gridViewMenu = [
    {"name": "Nasi Goreng Ati", "image": "", "price": 25000},
    {"name": "Nasi Goreng Ati", "image": "", "price": 25000},
    {"name": "Nasi Goreng Ati", "image": "", "price": 25000},
    {"name": "Nasi Goreng Ati", "image": "", "price": 25000},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: ColorValues().primaryColor,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'D’ASMO RESTO',
              style: AppTextStyles.appTitlew500s16(ColorValues().blackColor),
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
                    Text('Jam Buka')
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
            builGridView()
          ],
        ),
      ),
    );
  }

  Widget buildChipsCategory() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 0; i < 4; i++)
            Container(
              padding: EdgeInsets.only(left: 5, right: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorValues().primaryColor),
              child: Row(
                children: [
                  chipList[i] == 'Semua'
                      ? Icon(
                          Icons.grid_view_rounded,
                          size: 17,
                          color: Colors.white,
                        )
                      : chipList[i] == 'Minuman'
                          ? Icon(
                              Icons.wine_bar_rounded,
                              size: 17,
                              color: Colors.white,
                            )
                          : chipList[i] == 'Makanan'
                              ? Icon(
                                  Icons.fastfood,
                                  size: 17,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.tapas,
                                  size: 17,
                                  color: Colors.white,
                                ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Text(
                      chipList[i],
                      style: AppTextStyles.appTitlew500s10(Colors.white),
                    ),
                  )
                ],
              ),
              height: 30,
            ),
        ],
      ),
    );
  }

  Widget builGridView() {
    return Container(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: gridViewMenu.length < 4 ? gridViewMenu.length : 4,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: Column(
              children: [
                Stack(
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
                Text(gridViewMenu[index]['name'])
              ],
            ),
          );
        },
      ),
    );
  }
}
