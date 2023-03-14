import 'package:flutter/material.dart';
import 'package:trip_boy/component/BuildTextFormField.dart';
import 'package:trip_boy/ui/user/tour_reservation_ticket.dart';

import '../../common/app_text_styles.dart';
import '../../common/color_values.dart';
import 'detail_payment_method.dart';
import 'event_reservation_ticket.dart';
import 'event_resevartion_cart.dart';

class TourReservationCart extends StatefulWidget {
  TourReservationCart({Key? key}) : super(key: key);

  @override
  State<TourReservationCart> createState() => _TourReservationCartState();
}

class _TourReservationCartState extends State<TourReservationCart> {
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
            Navigator.of(context).pop(EventReservationTicket);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: ColorValues().primaryColor,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pesanan Anda',
                        style: AppTextStyles.appTitlew500s14(
                            ColorValues().blackColor),
                      ),
                      Text('29 Nov 2022',
                          style: AppTextStyles.appTitlew500s14(
                              ColorValues().blackColor))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '1x Tiket Masuk',
                        style: AppTextStyles.appTitlew400s12(
                            ColorValues().blackColor),
                      ),
                      Text('75.000',
                          style: AppTextStyles.appTitlew700s12(
                              ColorValues().blackColor))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tiket berlaku hanya untuk 1 orang',
                        style: AppTextStyles.appTitlew400s12(
                            ColorValues().blackColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Color.fromARGB(255, 227, 227, 227),
                    thickness: 3,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Notes',
                    style:
                        AppTextStyles.appTitlew500s14(ColorValues().blackColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BuildTextFormField(
                    hintText: 'Tambah catatan',
                    title: '',
                    isTitle: false,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Divider(
                    color: Color.fromARGB(255, 227, 227, 227),
                    thickness: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal',
                        style: AppTextStyles.appTitlew400s12(
                            ColorValues().blackColor),
                      ),
                      Text('760.000',
                          style: AppTextStyles.appTitlew500s12(
                              ColorValues().blackColor))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order fee',
                        style: AppTextStyles.appTitlew400s12(
                            ColorValues().blackColor),
                      ),
                      Text('20.000',
                          style: AppTextStyles.appTitlew500s12(
                              ColorValues().blackColor))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Color.fromARGB(255, 227, 227, 227),
              thickness: 6,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Text(
                'Detail Pembayaran',
                style: AppTextStyles.appTitlew500s12(ColorValues().blackColor),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPaymentMethod(
                        selectedPaymentMethod: "",
                        paymentList: [],
                        paymentMethod: (val) {},
                      ),
                    ));
              },
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Container(
                                width: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorValues().greyColor),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  'OVO',
                                  style: AppTextStyles.appTitlew500s12(
                                      ColorValues().greyColor),
                                ))),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            'OVO Cash',
                            style: AppTextStyles.appTitlew500s14(
                                ColorValues().blackColor),
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.keyboard_arrow_right_outlined, size: 20)
                  ],
                ),
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: AppTextStyles.appTitlew400s12(
                            ColorValues().blackColor),
                      ),
                      Text('Rp75000',
                          style: AppTextStyles.appTitlew500s12(
                              ColorValues().blackColor))
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorValues().primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)))),
                      onPressed: () {},
                      child: Text('Pesan',
                          style: AppTextStyles.appTitlew500s14(
                            Colors.white,
                          )),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
