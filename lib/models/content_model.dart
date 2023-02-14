// To parse this JSON data, do
//
//     final contentModel = contentModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ContentModel contentModelFromJson(String str) =>
    ContentModel.fromJson(json.decode(str));

String contentModelToJson(ContentModel data) => json.encode(data.toJson());

class ContentModel {
  ContentModel({
    this.address,
    required this.description,
    this.facility,
    this.googleMapsLink,
    this.images,
    required this.name,
    required this.rating,
    this.tickets,
    this.timeClosed,
    this.timeOpen,
    required this.type,
    required this.userId,
    this.imageUrl,
    this.meetLink,
    this.price,
    this.terms,
    this.ticketType,
    this.timeHeld,
    this.rooms,
    this.menu,
    this.paymentMethod
  });

  String? address;
  String description;
  List<Facility>? facility;
  String? googleMapsLink;
  List<ImageModel>? images;
  String name;
  double rating;
  List<Ticket>? tickets;
  String? timeClosed;
  String? timeOpen;
  String type;
  String userId;
  String? imageUrl;
  String? meetLink;
  int? price;
  List<Term>? terms;
  String? ticketType;
  String? timeHeld;
  List<Room>? rooms;
  List<Menu>? menu;
      List<PaymentMethod>? paymentMethod;


  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      address: json["address"],
      description: json["description"],
      facility: json["facility"] == null
          ? []
          : List<Facility>.from(
              json["facility"]!.map((x) => Facility.fromJson(x))),
      googleMapsLink: json["google_maps_link"],
      images: json["images"] == null
          ? []
          : List<ImageModel>.from(
              json["images"]!.map((x) => ImageModel.fromJson(x))),
      name: json["name"],
      rating: json["rating"]?.toDouble(),
      tickets: json["tickets"] == null
          ? []
          : List<Ticket>.from(json["tickets"]!.map((x) => Ticket.fromJson(x))),
          paymentMethod: List<PaymentMethod>.from(json["payment_method"].map((x) => PaymentMethod.fromJson(x))),
      timeClosed: json["time_closed"],
      timeOpen: json["time_open"],
      type: json["type"],
      userId: json["user_id"],
      imageUrl: json["image_url"],
      meetLink: json["meet_link"],
      price: json["price"],
      terms: json["terms"] == null
          ? []
          : List<Term>.from(json["terms"]!.map((x) => Term.fromJson(x))),
      ticketType: json["ticket_type"],
      timeHeld:  json["time_held"],
      rooms: json["rooms"] == null
          ? []
          : List<Room>.from(json["rooms"]!.map((x) => Room.fromJson(x))),
      menu: json["menu"] == null
          ? []
          : List<Menu>.from(json["menu"]!.map((x) => Menu.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "address": address,
        "description": description,
        "facility": facility == null
            ? []
            : List<dynamic>.from(facility!.map((x) => x.toJson())),
        "google_maps_link": googleMapsLink,
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "name": name,
        "rating": rating,
        "tickets": tickets == null
            ? []
            : List<dynamic>.from(tickets!.map((x) => x.toJson())),
        "time_closed": timeClosed,
        "time_open": timeOpen,
        "type": type,
        "user_id": userId,
        "image_url": imageUrl,
        "meet_link": meetLink,
        "price": price,
        "terms": terms == null
            ? []
            : List<dynamic>.from(terms!.map((x) => x.toJson())),
        "ticket_type": ticketType,
        "payment_method": List<dynamic>.from(paymentMethod!.map((x) => x.toJson())),
        "time_held": timeHeld,
        "rooms": rooms == null
            ? []
            : List<dynamic>.from(rooms!.map((x) => x.toJson())),
        "menu": menu == null
            ? []
            : List<dynamic>.from(menu!.map((x) => x.toJson())),
      };
}

class Facility {
  Facility({
    required this.name,
  });

  String name;

  factory Facility.fromJson(Map<String, dynamic> json) => Facility(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class PaymentMethod {
    PaymentMethod({
        required this.method,
        required this.number,
    });

    String method;
    String number;

    factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        method: json["method"],
        number: json["number"],
    );

    Map<String, dynamic> toJson() => {
        "method": method,
        "number": number,
    };
}

class ImageModel {
  ImageModel({
    required this.imageUrl,
  });

  String imageUrl;

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
      };
}

class Menu {
  Menu({
    required this.name,
    required this.desc,
    required this.imageUrl,
    required this.price,
  });

  String name;
  String desc;
  String imageUrl;
  int price;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        name: json["name"],
        desc: json["desc"],
        imageUrl: json["image_url"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "desc": desc,
        "image_url": imageUrl,
        "price": price,
      };
}

class Room {
  Room({
    required this.imageUrl,
    required this.sizeRoom,
    required this.priceRoom,
    required this.description,
  });

  String imageUrl;
  String sizeRoom;
  int priceRoom;
  String description;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        imageUrl: json["image_url"],
        sizeRoom: json["size_room"],
        priceRoom: json["price_room"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
        "size_room": sizeRoom,
        "price_room": priceRoom,
        "description": description,
      };
}

class Term {
  Term({
    required this.text,
  });

  String text;

  factory Term.fromJson(Map<String, dynamic> json) => Term(
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
      };
}

class Ticket {
  Ticket({
    required this.name,
    required this.price,
  });

  String name;
  int price;

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
      };
}
