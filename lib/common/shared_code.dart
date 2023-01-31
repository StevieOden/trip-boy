import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/restaurant_model.dart';
import '../services/database_services.dart';
import 'app_text_styles.dart';
import 'color_values.dart';

class SharedCode {
  static DateFormat dateFormat = DateFormat('dd MMM yyyy, hh:mm');

  static Future<User?> checkUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? _user;

    _auth.authStateChanges().listen((event) {
      _user = event;
    });
    await Future.delayed(const Duration(seconds: 1));
    return _user;
  }

  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  Future<XFile> getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: 1800, maxHeight: 1800);
    return pickedFile!;
  }

  static noData(context) {
    return Expanded(
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset("assets/svg_image/noDataActivity.svg"),
          Text(
            AppLocalizations.of(context)!.noAdded,
            style: AppTextStyles.appTitlew500s14(ColorValues().blackColor),
          )
        ],
      )),
    );
  }
}
