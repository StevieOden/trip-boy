import 'package:flutter/material.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/color_values.dart';
import 'package:trip_boy/component/BuildTextFormField.dart';
import 'package:trip_boy/ui/user/resevartion_cart.dart';

import 'detail_page.dart';

class ReservationTicket extends StatefulWidget {
  ReservationTicket({Key? key}) : super(key: key);

  @override
  State<ReservationTicket> createState() => _ReservationTicketState();
}

class _ReservationTicketState extends State<ReservationTicket> {
  TextEditingController name = TextEditingController();
  TextEditingController desc = TextEditingController();

  @override
  void initState() {
    name.text = '';
    desc.text = '';
    super.initState();
  }

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
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: 'Nama',
                      hintText: 'Masukan Nama'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: 'Tanggal',
                      hintText: 'Masukan tanggal Check - In dan Check- Out'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: 'Guest',
                      hintText: 'Tiket masuk belum termasuk parkir dll.'),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 20),
                  child: Text(
                    'Informasi Lainya',
                    style:
                        AppTextStyles.appTitlew500s14(ColorValues().blackColor),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Text(
                    '''Buka :
Senin - Jumat mulai jam 10.00 WIB
Sabtu - Minggu mulai jam 09.00 WIB
        
Harap hadir tepat waktu minimal 30 menit sebelum Sesi dimulai dan maksimal toleransi keterlambatan adalah 10 menit dari waktu Sesi yang dipilh''',
                    style:
                        AppTextStyles.appTitlew400s14(ColorValues().blackColor),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 20),
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
                    padding: EdgeInsets.only(
                      left: 8,
                      right: 8,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorValues().primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => ResevartionCart())),
                      child: Text('Pesan',
                          style: AppTextStyles.appTitlew500s16(
                            Colors.white,
                          )),
                    ))
              ],
            ),
          ),
        ));
  }
}
