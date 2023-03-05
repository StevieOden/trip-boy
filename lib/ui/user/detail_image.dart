import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../common/color_values.dart';

class DetailImage extends StatelessWidget {
  List imageList;
  DetailImage({super.key, required this.imageList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              child: Container(
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 12),
                width: MediaQuery.of(context).size.width.sp,
                child: GridView.count(
                    crossAxisSpacing: 10,
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    children: List.generate(
                      imageList.length,
                      (index) {
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: imageList[index]!.imageUrl.startsWith("/")
                                  ? Image(
                                      image: FileImage(
                                      File(imageList[index]!.imageUrl),
                                    ))
                                  : imageList[index]!.imageUrl == ""
                                      ? Image.asset("assets/png_image/logo.png",
                                          fit: BoxFit.cover,
                                          filterQuality: FilterQuality.high)
                                      : Image.network(
                                          imageList[index]!.imageUrl,
                                          fit: BoxFit.cover,
                                          filterQuality: FilterQuality.high),
                            ),
                          ],
                        );
                      },
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
