import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/color_values.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_boy/ui/user/detail_payment_method.dart';

class DetailMenu extends StatefulWidget {
  final String type;
  final String imageUrl;
  final String name;
  final String location;
  final String fullLocation;
  final String timeOpen;
  final String timeClose;
  final String description;
  final String googleMapsUrl;
  final String timeHeld;
  final String price;
  final double rating;
  final List imageList;
  const DetailMenu(
      {super.key,
      required this.type,
      required this.imageUrl,
      required this.name,
      required this.location,
      required this.fullLocation,
      required this.timeOpen,
      required this.timeClose,
      required this.description,
      required this.googleMapsUrl,
      required this.timeHeld,
      required this.price,
      required this.rating,
      required this.imageList});

  @override
  State<DetailMenu> createState() => _DetailMenu();
}

class _DetailMenu extends State<DetailMenu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        body: Column(
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
                            ? Image.asset("assets/png_image/kedaiMaeMoen.png",
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
                            Color.fromARGB(0, 255, 255, 255),
                            ColorValues().veryBlackColor
                          ],
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
                    Positioned(
                      top: 10,
                      left: 20,
                      child: Container(
                        padding: EdgeInsets.only(left: 2),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffFFFFFF)),
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 15,
                            color: ColorValues().primaryColor,
                          ),
                        ),
                        height: 30,
                        width: 30,
                      ),
                    )
                  ],
                )),
            Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "D'Asmo",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Nasi Goreng Ati",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Nasi goreng dengan + ati dan ampela",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: new EdgeInsets.all(1.0),
                            alignment: Alignment.topCenter,
                            child: Text(
                              "18.000",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                )),
            Divider(
              color: Color.fromARGB(255, 227, 227, 227),
              thickness: 5,
            ),
            Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Note to restaurant",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2),
                  ],
                )),
            Divider(
              color: Color.fromARGB(255, 227, 227, 227),
              thickness: 1,
            ),
            Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Add your request (subejct to restaurant direction)",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2),
                  ],
                )),
            Divider(
              color: Color.fromARGB(255, 227, 227, 227),
              thickness: 1,
            ),
            Container(
              child: Row(children: <Widget>[
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('-'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('+'),
                )
              ]),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(
                bottom: 15,
                top: 15,
                left: 20,
                right: 20,
              ),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorValues().primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailPaymentMethod(
                        paymentMethod: (val) {
                          
                        },
                        paymentList: [],
                        selectedPaymentMethod: "",
                      ))),
                  child: Text(AppLocalizations.of(context)!.cart)),
            )
          ],
        ),
      ),
    );
  }
}
