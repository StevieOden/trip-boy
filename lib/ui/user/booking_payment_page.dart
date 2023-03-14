import 'package:flutter/material.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_boy/common/shared_code.dart';
import 'package:trip_boy/component/BuildTextFormField.dart';
import 'package:trip_boy/services/database_services.dart';

import '../../common/color_values.dart';

class BookingPaymentPage extends StatefulWidget {
  String title, paymentMethod, accountNumber, orderId;
  int paymentTotal;
  BookingPaymentPage(
      {super.key,
      required this.title,
      required this.orderId,
      required this.paymentTotal,
      required this.paymentMethod,
      required this.accountNumber});

  @override
  State<BookingPaymentPage> createState() => _BookingPaymentPageState();
}

class _BookingPaymentPageState extends State<BookingPaymentPage> {
  String receiptImage = "";

  @override
  Widget build(BuildContext context) {
    print("orderId: " + widget.orderId);
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    widget.title,
                    style: AppTextStyles.appTitlew500s16(
                        ColorValues().veryBlackColor),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.paymentMethod,
                    style:
                        AppTextStyles.appTitlew400s12(ColorValues().blackColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.paymentMethod.toUpperCase(),
                    style:
                        AppTextStyles.appTitlew500s14(ColorValues().blackColor),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 5,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.paymentTotal,
                    style:
                        AppTextStyles.appTitlew400s12(ColorValues().blackColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Rp${widget.paymentTotal.toString()}",
                    style:
                        AppTextStyles.appTitlew500s14(ColorValues().blackColor),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 5,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.accountNumber,
                    style:
                        AppTextStyles.appTitlew400s12(ColorValues().blackColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      widget.accountNumber.toString(),
                      style:
                          AppTextStyles.accountNumber(ColorValues().blackColor),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 5,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: BuildTextFormField(
                isUploadImage: true,
                hintText: "",
                title: AppLocalizations.of(context)!.receiptPayment,
                imagePath: (val) => receiptImage = val,
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorValues().primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  onPressed: () async {
                    receiptImage != ""
                        ? DatabaseService()
                            .updateReceiptPayment(receiptImage, widget.orderId)
                        : null;
                    Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context)!.booking,
                      style: AppTextStyles.appTitlew500s14(
                        Colors.white,
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
