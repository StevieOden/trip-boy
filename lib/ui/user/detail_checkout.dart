import 'package:flutter/material.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/component/BuildTextFormField.dart';
import 'package:trip_boy/ui/user/detail_payment_method.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../common/color_values.dart';

class DetailCheckout extends StatefulWidget {
  DetailCheckout({Key? key}) : super(key: key);

  @override
  State<DetailCheckout> createState() => _DetailCheckoutState();
}

class _DetailCheckoutState extends State<DetailCheckout> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'D’ASMO RESTO - Pulisen',
          style: AppTextStyles.appTitlew500s14(ColorValues().blackColor),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: ColorValues().primaryColor,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: Text('Pesanan Anda',
                      style: AppTextStyles.appTitlew500s16(
                          ColorValues().blackColor))),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 20,
                ),
                child: Container(
                  margin: EdgeInsets.only(
                    right: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '1x Nasi Goreng Babat',
                        style: AppTextStyles.appTitlew400s14(
                            ColorValues().blackColor),
                      ),
                      Text(
                        '23.000',
                        style: AppTextStyles.appTitlew400s14(
                            ColorValues().blackColor),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: Divider(
                  color: Color.fromARGB(255, 239, 239, 239),
                  thickness: 2,
                  indent: 10,
                  endIndent: 10,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text('Orang juga membeli',
                    style: AppTextStyles.appTitlew400s14(
                        ColorValues().blackColor)),
              ),
              Container(
                height: 100,
                margin: EdgeInsets.only(
                  left: 10,
                ),
                width: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 222, 222, 222),
                              borderRadius: BorderRadius.circular(15)),
                          width: 200,
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Divider(
                  color: Color.fromARGB(255, 239, 239, 239),
                  thickness: 2,
                  indent: 10,
                  endIndent: 10,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal',
                      style: AppTextStyles.appTitlew400s14(
                          ColorValues().blackColor),
                    ),
                    Text(
                      '23.000',
                      style: AppTextStyles.appTitlew400s14(
                          ColorValues().blackColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order fee',
                      style: AppTextStyles.appTitlew400s14(
                          ColorValues().blackColor),
                    ),
                    Text(
                      '   3.000',
                      style: AppTextStyles.appTitlew400s14(
                          ColorValues().blackColor),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Color.fromARGB(255, 239, 239, 239),
                thickness: 5,
              ),
              Container(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    'Booking Tempat',
                    style:
                        AppTextStyles.appTitlew500s16(ColorValues().blackColor),
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Booking meja',
                      style: AppTextStyles.appTitlew400s14(
                          ColorValues().blackColor),
                    ),
                    Switch(
                      value: light,
                      activeColor: ColorValues().primaryColor,
                      onChanged: (value) {
                        setState(() {
                          light = value;
                        });
                      },
                    )
                  ],
                ),
              ),
              !light
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.numberOfGuests,
                            style: AppTextStyles.appTitlew400s14(
                                ColorValues().blackColor),
                          ),
                          Container(
                            width: 100,
                            child: BuildTextFormField(
                              keyboardType: TextInputType.number,
                              hintText: '',
                              title: '',
                              isTitle: false,
                            ),
                          )
                        ],
                      ),
                    ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Color.fromARGB(255, 239, 239, 239),
                thickness: 5,
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPaymentMethod(
                          selectedPaymentMethod: "",
                          paymentList: [],
                          paymentMethod: (val) {
                            
                          },
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
            ],
          ),
        ),
      ),
    );
  }
}
