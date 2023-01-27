// To parse this JSON data, do
//
//     final destinationModel = destinationModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trip_boy/models/images_model.dart';

import 'facility_model.dart';

DestinationModel? destinationModelFromJson(String str) =>
    DestinationModel.fromJson(json.decode(str));

String destinationModelToJson(DestinationModel? data) =>
    json.encode(data!.toJson());

class DestinationModel {
  DestinationModel(
      {this.name,
      this.alamat,
      this.description,
      this.rating,
      this.timeClosed,
      this.timeOpen,
      this.facility,
      this.images,
      this.tickets,
      this.googleMapsLink,
      this.userId,
      required this.type});

  String? name;
  String? alamat;
  String? description;
  String? googleMapsLink;
  String type;
  double? rating;
  String? timeClosed;
  String? timeOpen;
  String? userId;
  List<Facility?>? facility;
  List<ImageModel?>? images;
  List<Ticket?>? tickets;

  factory DestinationModel.fromJson(Map<String, dynamic> json) =>
      DestinationModel(
        name: json["name"] == null?"":json["name"],
        alamat: json["alamat"] == null?"":json["alamat"],
        description: json["description"] == null?"":json["description"],
        rating: json["rating"] == null?0:json["rating"],
        timeClosed: json["time_closed"] == null ? "": json["time_closed"],
        timeOpen: json["time_open"] == null ? "":json["time_open"],
        googleMapsLink: json["google_maps_link"] == null ? "":json["google_maps_link"],
        type: json["type"] == null ? "" : json["type"],
        userId: json["user"] == null ? "": json["user"],
        facility: json["facility"] == null
            ? []
            : List<Facility?>.from(
                json["facility"]!.map((x) => Facility.fromJson(x))),
        images: json["images"] == null
            ? []
            : List<ImageModel>.from(
                json["images"]!.map((x) => ImageModel.fromJson(x))),
        tickets: json["tickets"] == null
            ? []
            : List<Ticket?>.from(
                json["tickets"]!.map((x) => Ticket.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "alamat": alamat,
        "description": description,
        "rating": rating,
        "time_closed": timeClosed,
        "time_open": timeOpen,
        "google_maps_link": googleMapsLink,
        "type": type,
        "user": userId,
        "facility": facility == null
            ? []
            : List<dynamic>.from(facility!.map((x) => x!.toJson())),
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x!.toJson())),
        "tickets": tickets == null
            ? []
            : List<dynamic>.from(tickets!.map((x) => x!.toJson())),
      };
}

class Ticket {
  Ticket({
    this.name,
    this.price,
  });

  String? name;
  int? price;

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
      };
}
