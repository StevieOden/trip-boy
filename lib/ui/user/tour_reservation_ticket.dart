import 'package:flutter/material.dart';
import 'package:trip_boy/ui/user/tour_reservation_cart.dart';

import '../../common/app_text_styles.dart';
import '../../common/color_values.dart';
import '../../component/BuildTextFormField.dart';
import 'detail_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'event_resevartion_cart.dart';

class TourReservationTicket extends StatefulWidget {
  TourReservationTicket({Key? key}) : super(key: key);

  @override
  State<TourReservationTicket> createState() => _TourReservationTicketState();
}

class _TourReservationTicketState extends State<TourReservationTicket> {
  TextEditingController name = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController dateCheckIn = TextEditingController();
  TextEditingController dateCheckOut = TextEditingController();

  @override
  void initState() {
    name.text = '';
    desc.text = '';
    super.initState();
  }

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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildTextFormField(
                  hintText: AppLocalizations.of(context)!.fillName,
                  title: AppLocalizations.of(context)!.name),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(AppLocalizations.of(context)!.checkInDate),
                TextButton(
                    onPressed: () {},
                    child: Text(AppLocalizations.of(context)!.clear))
              ]),
              BuildTextFormField(
                hintText: AppLocalizations.of(context)!.enterCheckInDate,
                title: "",
                isTitle: false,
                isDateForm: true,
                dateController: dateCheckIn,
              ),
              BuildTextFormField(
                hintText: AppLocalizations.of(context)!.enterCheckOutDate,
                title: AppLocalizations.of(context)!.checkOutDate,
                isDateForm: true,
                dateController: dateCheckOut,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.guest),
                  TextButton(
                      onPressed: () {},
                      child: Text(AppLocalizations.of(context)!.clear))
                ],
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
                        Text("Tiket Masuk",
                            style: AppTextStyles.appTitlew400s10(
                                ColorValues().blackColor)),
                        Text(
                          "Belum termasuk parkir dll",
                          style: AppTextStyles.appTitlew400s10(
                              ColorValues().lightGrayColor),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.remove)),
                        Text("2"),
                        IconButton(onPressed: () {}, icon: Icon(Icons.add))
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Informasi Lainya',
                  style:
                      AppTextStyles.appTitlew500s14(ColorValues().blackColor),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  '''Buka :
Senin - Jumat mulai jam 10.00 WIB
Sabtu - Minggu mulai jam 09.00 WIB
        
Harap hadir tepat waktu minimal 30 menit sebelum Sesi dimulai dan maksimal toleransi keterlambatan adalah 10 menit dari waktu Sesi yang dipilh''',
                  style:
                      AppTextStyles.appTitlew400s12(ColorValues().blackColor),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: AppTextStyles.appTitlew500s14(
                          ColorValues().blackColor),
                    ),
                    Text(
                      'Rp75000',
                      style: AppTextStyles.appTitlew500s14(
                          ColorValues().blackColor),
                    )
                  ],
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
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => TourReservationCart())),
                    child: Text(AppLocalizations.of(context)!.booking,
                        style: AppTextStyles.appTitlew500s14(
                          Colors.white,
                        )),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
