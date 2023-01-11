import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityModel {
  String title, description, status, paymentType, type;
  int price;
  DateTime expiredAt, generatedAt;
  ActivityModel(
      {required this.title,
      required this.description,
      required this.price,
      required this.status,
      required this.type,
      required this.paymentType,
      required this.expiredAt,
      required this.generatedAt});

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'paymentType':paymentType,
      'status': status,
      'expiredAt': expiredAt,
      'generatedAt': FieldValue.serverTimestamp()
    };
  }
}
