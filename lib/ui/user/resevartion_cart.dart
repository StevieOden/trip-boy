import 'package:flutter/material.dart';
import 'package:trip_boy/ui/user/reservation_ticket.dart';

import '../../common/app_text_styles.dart';
import '../../common/color_values.dart';
import 'detail_page.dart';

class ResevartionCart extends StatefulWidget {
  ResevartionCart({Key? key}) : super(key: key);

  @override
  State<ResevartionCart> createState() => _ResevartionCartState();
}

class _ResevartionCartState extends State<ResevartionCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Alam Sutra Boyolali',
          style: AppTextStyles.appTitlew500s16(ColorValues().blackColor),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(ReservationTicket);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: ColorValues().primaryColor,
          ),
        ),
      ),
      body: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Pesanan Anda',
            style: AppTextStyles.appTitlew400s14(ColorValues().blackColor),
          ),
          Text('29 Nov 2022',
              style: AppTextStyles.appTitlew400s14(ColorValues().blackColor))
        ],
      )),
    );
  }
}
