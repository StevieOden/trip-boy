import 'package:flutter/material.dart';

import '../../common/app_text_styles.dart';
import '../../common/color_values.dart';

class DetailPaymentMethod extends StatefulWidget {
  DetailPaymentMethod({Key? key}) : super(key: key);

  @override
  State<DetailPaymentMethod> createState() => _DetailPaymentMethodState();
}

class _DetailPaymentMethodState extends State<DetailPaymentMethod> {
  List<String> paymentMethods = ['OVO', 'Cash', 'BCA', 'BRI', 'Mandiri'];
  String selectedPaymentMethods = 'OVO';
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
            for (var pm in paymentMethods)
              RadioListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                dense: true,
                value: pm,
                groupValue: selectedPaymentMethods,
                title: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        width: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorValues().greyColor),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: EdgeInsets.all(5),
                        child: Text(
                          pm,
                          style: AppTextStyles.appTitlew500s12(
                              ColorValues().greyColor),
                        )),
                    Expanded(child: Container())
                  ],
                ),
                onChanged: (currentUser) {
                  setState(() {
                    selectedPaymentMethods = currentUser!;
                  });
                },
                selected: selectedPaymentMethods == pm,
                activeColor: ColorValues().primaryColor,
              ),
            // Row(
            //   children: [
            //     Container(
            //         margin: EdgeInsets.only(top: 10),
            //         width: 60,
            //         alignment: Alignment.center,
            //         decoration: BoxDecoration(
            //           border: Border.all(color: ColorValues().greyColor),
            //           borderRadius: BorderRadius.circular(6),
            //         ),
            //         padding: EdgeInsets.all(5),
            //         child: Text(
            //           paymentMethods[i],
            //           style: AppTextStyles.appTitlew500s12(
            //               ColorValues().greyColor),
            //         )),
            //     RadioBu
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
