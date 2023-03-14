import 'package:flutter/material.dart';
import 'package:trip_boy/component/BuildTextFormField.dart';
import 'package:trip_boy/component/loading.dart';
import 'package:trip_boy/services/database_services.dart';
import 'package:trip_boy/ui/user/detail_payment_method.dart';
import 'package:trip_boy/ui/user/event_reservation_ticket.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../common/app_text_styles.dart';
import '../../common/color_values.dart';
import '../../models/content_model.dart';
import '../../models/event_model.dart';

class EventResevartionCart extends StatefulWidget {
  String title, dateCheckIn, contentType, contentDesc;
  double contentRating;
  int totalPrice;
  int ticketCount;
  List<PaymentMethodEvent> paymentMethodsEvent;
  EventResevartionCart(
      {Key? key,
      required this.title,
      required this.dateCheckIn,
      required this.ticketCount,
      required this.totalPrice,
      required this.contentType,
      required this.contentDesc,
      required this.contentRating,
      required this.paymentMethodsEvent})
      : super(key: key);

  @override
  State<EventResevartionCart> createState() => _EventResevartionCartState();
}

class _EventResevartionCartState extends State<EventResevartionCart> {
  String paymentMethod = "";

  List<Map> paymentMethods = [
    {"image": "assets/png_image/bca-logo.png", "name": "bca"},
    {"image": 'assets/png_image/mandiri-logo.png', "name": "mandiri"},
    {"image": 'assets/png_image/bri-logo.png', "name": "bri"},
    {"image": 'assets/png_image/bni-logo.png', "name": "bni"},
    {"image": 'assets/png_image/ovo-logo.png', "name": "ovo"},
    {"image": 'assets/png_image/dana-logo.png', "name": "dana"},
  ];
  late TextEditingController noteController;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    noteController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                widget.title,
                style: AppTextStyles.appTitlew500s16(ColorValues().blackColor),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.reservationTitle,
                              style: AppTextStyles.appTitlew500s14(
                                  ColorValues().blackColor),
                            ),
                            Text(widget.dateCheckIn,
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
                              '${widget.ticketCount}x Tiket Masuk',
                              style: AppTextStyles.appTitlew400s12(
                                  ColorValues().blackColor),
                            ),
                            widget.totalPrice == 0
                                ? Text("Free",
                                    style: AppTextStyles.appTitlew700s12(
                                        ColorValues().blackColor))
                                : Text(widget.totalPrice.toString(),
                                    style: AppTextStyles.appTitlew700s12(
                                        ColorValues().blackColor))
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(
                          color: Color.fromARGB(255, 227, 227, 227),
                          thickness: 3,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          AppLocalizations.of(context)!.note,
                          style: AppTextStyles.appTitlew500s14(
                              ColorValues().blackColor),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        BuildTextFormField(
                          hintText: AppLocalizations.of(context)!.addNote,
                          title: '',
                          isTitle: false,
                          controller: noteController,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Color.fromARGB(255, 227, 227, 227),
                    thickness: 6,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: Text(
                      AppLocalizations.of(context)!.choosePaymentMethod,
                      style: AppTextStyles.appTitlew500s12(
                          ColorValues().blackColor),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPaymentMethod(
                              selectedPaymentMethod: paymentMethod,
                              paymentList: widget.paymentMethodsEvent,
                              paymentMethod: (val) =>
                                  setState(() => paymentMethod = val),
                            ),
                          ));
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          paymentMethod == ""
                              ? Expanded(child: Container())
                              : Image(
                                  width: 60,
                                  height: 50,
                                  image: AssetImage(paymentMethods
                                      .where((element) =>
                                          element["name"] == paymentMethod)
                                      .first["image"])),
                          Icon(Icons.keyboard_arrow_right_outlined, size: 20)
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
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
                            widget.totalPrice == 0
                                ? Text("Free",
                                    style: AppTextStyles.appTitlew700s12(
                                        ColorValues().blackColor))
                                : Text('Rp${widget.totalPrice}',
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
                            onPressed: () {
                              addData();
                            },
                            child: Text(AppLocalizations.of(context)!.booking,
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

  Future<void> addData() async {
    setState(() {
      _isLoading = true;
    });
    // String idContent = await DatabaseService().getContentIdEvent(widget.title);
    DatabaseService().addBookingDataEvent(
        widget.totalPrice,
        widget.dateCheckIn,
        noteController.text,
        paymentMethod,
        widget.title,
        widget.contentType,
        0,
        widget.contentDesc,
        widget.paymentMethodsEvent);

    setState(() {
      _isLoading = false;
    });
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context, false);
  }
}
