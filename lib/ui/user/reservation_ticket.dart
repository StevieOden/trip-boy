import 'package:flutter/material.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/color_values.dart';

import 'detail_page.dart';

class ReservationTicket extends StatefulWidget {
  ReservationTicket({Key? key}) : super(key: key);

  @override
  State<ReservationTicket> createState() => _ReservationTicketState();
}

class _ReservationTicketState extends State<ReservationTicket> {
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
            Navigator.of(context).pop(DetailPage);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: ColorValues().primaryColor,
          ),
        ),
      ),
    );
  }
}
