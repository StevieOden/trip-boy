import 'package:flutter/material.dart';

import '../../common/app_text_styles.dart';
import '../../common/color_values.dart';

import '../../models/content_model.dart';
import '../../models/event_model.dart';

typedef void StringCallback(String val);

class DetailPaymentMethod extends StatefulWidget {
  StringCallback paymentMethod;
  String selectedPaymentMethod;
  List<PaymentMethodEvent> paymentList;
  DetailPaymentMethod(
      {Key? key,
      required this.paymentMethod,
      required this.selectedPaymentMethod,
      required this.paymentList})
      : super(key: key);

  @override
  State<DetailPaymentMethod> createState() => _DetailPaymentMethodState();
}

class _DetailPaymentMethodState extends State<DetailPaymentMethod> {
  List<Map> paymentMethods = [
    {"image": "assets/png_image/bca-logo.png", "name": "bca"},
    {"image": 'assets/png_image/mandiri-logo.png', "name": "mandiri"},
    {"image": 'assets/png_image/bri-logo.png', "name": "bri"},
    {"image": 'assets/png_image/bni-logo.png', "name": "bni"},
    {"image": 'assets/png_image/ovo-logo.png', "name": "ovo"},
    {"image": 'assets/png_image/dana-logo.png', "name": "dana"},
  ];
  String selectedPaymentMethods = '';

  //payment method variable
  bool bcaValue = false;
  bool mandiriValue = false;
  bool briValue = false;
  bool bniValue = false;
  bool ovoValue = false;
  bool danaValue = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedPaymentMethods = widget.selectedPaymentMethod.isEmpty
        ? 'BCA'
        : widget.selectedPaymentMethod;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Metode Pembayaran',
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
        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                'Ingin membayar dengan apa?',
                style: AppTextStyles.appTitlew500s16(ColorValues().blackColor),
              ),
            ),
            for (var pm in widget.paymentList)
              RadioListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                dense: true,
                value: pm.method,
                groupValue: selectedPaymentMethods,
                title: Row(
                  children: [
                    Image(
                        width: 60,
                        height: 30,
                        image: AssetImage(paymentMethods[
                                paymentMethods.indexWhere(
                                    (element) => element["name"] == pm.method)]
                            ["image"])),
                    Expanded(child: Container())
                  ],
                ),
                onChanged: (currentUser) {
                  setState(() {
                    selectedPaymentMethods = currentUser!;
                    widget.paymentMethod(currentUser);
                  });
                },
                selected: selectedPaymentMethods == pm,
                activeColor: ColorValues().primaryColor,
              ),
          ],
        ),
      ),
    );
  }
}
