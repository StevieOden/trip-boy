import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

EventModel? eventModelFromJson(String str) =>
    EventModel.fromJson(json.decode(str));

String eventModelToJson(EventModel? data) => json.encode(data!.toJson());

class EventModel {
  EventModel(
      {this.name,
      this.imageUrl,
      this.description,
      this.meetLinks,
      this.rating,
      this.price,
      this.ticketType,
      required this.timeHeld,
      this.terms,
      required this.type});

  String? name;
  String? imageUrl;
  String? description;
  String? meetLinks;
  double? rating;
  int? price;
  String? ticketType;
  String type;
  DateTime timeHeld;
  List<Term?>? terms;

  factory EventModel.fromJson(Map<String, dynamic> json) {
    Timestamp timeHeld = json["time_held"];
    return EventModel(
      name: json["name"],
      imageUrl: json["image_url"] == null ? "":json["image_url"],
      description: json["description"],
      meetLinks: json["meet_links"],
      rating: json["rating"].toDouble(),
      price: json["price"] == null ? 0 : json["price"],
      ticketType: json["ticket_type"],
      type: json["type"],
      timeHeld: timeHeld.toDate(),
      terms: json["terms"] == null
          ? []
          : List<Term?>.from(json["terms"]!.map((x) => Term.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "image_url": imageUrl,
        "description": description,
        "meet_links": meetLinks,
        "rating": rating,
        "price": price,
        "ticket_type": ticketType,
        "type": type,
        "time_held": Timestamp.fromDate(
          DateTime(timeHeld.year, timeHeld.month, timeHeld.day),
        ),
        "terms": terms == null
            ? []
            : List<dynamic>.from(terms!.map((x) => x!.toJson())),
      };
}

class Term {
  Term({
    this.text,
  });

  String? text;

  factory Term.fromJson(Map<String, dynamic> json) => Term(
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
      };
}
