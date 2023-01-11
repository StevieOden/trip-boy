import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String title, description, ticketType, imageUrl;
  int price;
  DateTime generatedAt, heldAt;
  EventModel(
      {required this.imageUrl,
      required this.title,
      required this.description,
      required this.price,
      required this.ticketType,
      required this.generatedAt,
      required this.heldAt});

  Map<String, Object?> toJson() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'description': description,
      'price': price,
      'ticketType': ticketType,
      'heldAt': heldAt,
      'generatedAt': FieldValue.serverTimestamp()
    };
  }
}
