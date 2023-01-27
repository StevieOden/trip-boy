// To parse this JSON data, do
//
//     final hotelModel = hotelModelFromJson(jsonString);

import 'dart:convert';

import 'facility_model.dart';
import 'images_model.dart';

HotelModel? hotelModelFromJson(String str) =>
    HotelModel.fromJson(json.decode(str));

String hotelModelToJson(HotelModel? data) => json.encode(data!.toJson());

class HotelModel {
  HotelModel({
    this.name,
    this.alamat,
    this.description,
    this.rating,
    this.facility,
    this.images,
    this.rooms,
    this.googleMapsLink,
    this.userId,
    required this.type,
  });

  String? name;
  String? alamat;
  String? description;
  String? googleMapsLink;
  String type;
  String? userId;
  double? rating;
  List<Facility?>? facility;
  List<ImageModel?>? images;
  List<Room?>? rooms;

  factory HotelModel.fromJson(Map<String, dynamic> json) => HotelModel(
        name: json["name"] == null ? "" : json["name"],
        alamat: json["alamat"] == null ? "" : json["alamat"],
        description: json["description"] == null ? "" : json["description"],
        rating: json["rating"] == null ? 0 : json["rating"],
        googleMapsLink: json["google_maps_link"],
        type: json["type"] == null ? "" : json["type"],
        userId: json["user"] == null ? "" : json["user"],
        facility: json["facility"] == null
            ? []
            : List<Facility?>.from(
                json["facility"]!.map((x) => Facility.fromJson(x))),
        images: json["images"] == null
            ? []
            : List<ImageModel?>.from(
                json["images"]!.map((x) => ImageModel.fromJson(x))),
        rooms: json["rooms"] == null
            ? []
            : List<Room?>.from(json["rooms"]!.map((x) => Room.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "alamat": alamat,
        "description": description,
        "rating": rating,
        "type": type,
        "google_maps_link": googleMapsLink,
        "user": userId,
        "facility": facility == null
            ? []
            : List<dynamic>.from(facility!.map((x) => x!.toJson())),
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x!.toJson())),
        "rooms": rooms == null
            ? []
            : List<dynamic>.from(rooms!.map((x) => x!.toJson())),
      };
}

class Room {
  Room({
    this.sizeRoom,
    this.priceRoom,
    this.description,
    this.image,
  });

  String? sizeRoom;
  int? priceRoom;
  String? description, image;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        sizeRoom: json["size_room"],
        priceRoom: json["price"],
        description: json["description"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "size_room": sizeRoom,
        "price": priceRoom,
        "description": description,
        "image": image,
      };
}
