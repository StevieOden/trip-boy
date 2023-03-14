import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/color_values.dart';
import 'package:trip_boy/component/BuildTextFormField.dart';
import 'package:trip_boy/models/event_model.dart';
import 'package:trip_boy/ui/user/event_resevartion_cart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventReservationTicket extends StatefulWidget {
  String title, contentType, contentDesc, dateHeld;
  double contentRating;
  int ticketPrice;
  List<TermEvent> terms;
  List<PaymentMethodEvent> paymentMethods;
  EventReservationTicket(
      {Key? key,
      required this.title,
      required this.ticketPrice,
      required this.terms,
      required this.contentType,
      required this.contentDesc,
      required this.contentRating,
      required this.dateHeld,
      required this.paymentMethods})
      : super(key: key);

  @override
  State<EventReservationTicket> createState() => _EventReservationTicketState();
}

class _EventReservationTicketState extends State<EventReservationTicket> {
  TextEditingController desc = TextEditingController();
  TextEditingController dateCheckIn = TextEditingController();
  final ValueNotifier<int> totalPrice = ValueNotifier<int>(0);

  int guestCount = 1;

  static final dateForm = GlobalKey<FormState>();

  @override
  void initState() {
    desc.text = '';
    totalPrice.value = widget.ticketPrice;
    dateCheckIn = TextEditingController(
        text:
            "${widget.dateHeld.split(", ")[0]}, ${widget.dateHeld.split(", ")[1]}");
    print("paymentMethod: " + widget.paymentMethods.toString());
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
        body: Form(
          key: dateForm,
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.date,
                              style: AppTextStyles.appTitlew400s14(
                                  ColorValues().blackColor),
                            ),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    dateCheckIn.clear();
                                  });
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.clear,
                                  style: AppTextStyles.appTitlew500s12(
                                      ColorValues().primaryColor),
                                ))
                          ]),
                      BuildTextFormField(
                        hintText: AppLocalizations.of(context)!.enterDate,
                        title: "",
                        isTitle: false,
                        isDateForm: true,
                        dateController: dateCheckIn,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.dateWarning;
                          }
                          return null;
                        },
                      ),
                      Text(
                        AppLocalizations.of(context)!.guest,
                        style: AppTextStyles.appTitlew400s14(
                            ColorValues().blackColor),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        AppLocalizations.of(context)!.ticketAlert,
                        style: AppTextStyles.appTitlew400s12(
                            ColorValues().blackColor),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppLocalizations.of(context)!.entryTicket,
                                    style: AppTextStyles.appTitlew400s10(
                                        ColorValues().blackColor)),
                                Text(
                                  AppLocalizations.of(context)!.ticketDesc,
                                  style: AppTextStyles.appTitlew400s10(
                                      ColorValues().lightGrayColor),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (guestCount != 1) {
                                          guestCount--;
                                          totalPrice.value =
                                              widget.ticketPrice * guestCount;
                                        }
                                      });
                                    },
                                    icon: Icon(Icons.remove)),
                                Text(guestCount.toString()),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        guestCount++;
                                        totalPrice.value = totalPrice.value =
                                            widget.ticketPrice * guestCount;
                                        ;
                                      });
                                    },
                                    icon: Icon(Icons.add))
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        AppLocalizations.of(context)!.otherInfo,
                        style: AppTextStyles.appTitlew400s14(
                            ColorValues().blackColor),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Wrap(
                        spacing: 3,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.eventTime + " :",
                            style: AppTextStyles.appTitlew400s12(
                                ColorValues().blackColor),
                          ),
                          Text(
                            widget.dateHeld,
                            style: AppTextStyles.appTitlew400s12(
                                ColorValues().blackColor),
                          ),
                        ],
                      ),
                      widget.terms.isEmpty
                          ? Container()
                          : Container(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                AppLocalizations.of(context)!.termTitle,
                                style: AppTextStyles.appTitlew500s14(
                                    ColorValues().blackColor),
                              ),
                            ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              for (int i = 0; i < widget.terms.length; i++)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("${(i + 1).toString()})"),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${widget.terms[i].text}",
                                          textAlign: TextAlign.justify,
                                          style: AppTextStyles.appTitlew400s12(
                                              ColorValues().blackColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: totalPrice,
                  builder: (context, value, child) => Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: AppTextStyles.appTitlew500s14(
                              ColorValues().blackColor),
                        ),
                        totalPrice.value == 0
                            ? Text(
                                "Free",
                                style: AppTextStyles.appTitlew500s14(
                                    ColorValues().blackColor),
                              )
                            : Text(
                                "Rp${totalPrice.value.toString()}",
                                style: AppTextStyles.appTitlew500s14(
                                    ColorValues().blackColor),
                              )
                      ],
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 10, top: 15),
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorValues().primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                      onPressed: () {
                        if (dateForm.currentState!.validate()) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EventResevartionCart(
                                    title: widget.title,
                                    dateCheckIn: dateCheckIn.text,
                                    ticketCount: guestCount,
                                    totalPrice: totalPrice.value,
                                    contentType: widget.contentType,
                                    contentDesc: widget.contentDesc,
                                    contentRating: widget.contentRating,
                                    paymentMethodsEvent: widget.paymentMethods,
                                  )));
                        }
                      },
                      child: Text(AppLocalizations.of(context)!.booking,
                          style: AppTextStyles.appTitlew500s14(
                            Colors.white,
                          )),
                    ))
              ],
            ),
          ),
        ));
  }
}
