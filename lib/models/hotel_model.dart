// To parse this JSON data, do
//
//     final hotelModel = hotelModelFromJson(jsonString);

import 'dart:convert';

HotelModel hotelModelFromJson(String str) => HotelModel.fromJson(json.decode(str));

String hotelModelToJson(HotelModel data) => json.encode(data.toJson());

class HotelModel {
    HotelModel({
        required this.address,
        required this.description,
        required this.facility,
        required this.googleMapsLink,
        required this.images,
        required this.name,
        required this.rating,
        required this.rooms,
        required this.paymentMethod,
        required this.type,
        required this.userId,
    });

    String address;
    String description;
    List<FacilityModel> facility;
    String googleMapsLink;
    List<ImageHotel> images;
    String name;
    double rating;
    List<RoomHotel> rooms;
    List<PaymentMethodHotel> paymentMethod;
    String type;
    String userId;

    factory HotelModel.fromJson(Map<String, dynamic> json) => HotelModel(
        address: json["address"],
        description: json["description"],
        facility: List<FacilityModel>.from(json["facility"].map((x) => FacilityModel.fromJson(x))),
        googleMapsLink: json["google_maps_link"],
        images: List<ImageHotel>.from(json["images"].map((x) => ImageHotel.fromJson(x))),
        name: json["name"],
        rating: json["rating"]?.toDouble(),
        rooms: List<RoomHotel>.from(json["rooms"].map((x) => RoomHotel.fromJson(x))),
        paymentMethod: List<PaymentMethodHotel>.from(json["payment_method"].map((x) => PaymentMethodHotel.fromJson(x))),
        type: json["type"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "description": description,
        "facility": List<dynamic>.from(facility.map((x) => x.toJson())),
        "google_maps_link": googleMapsLink,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "name": name,
        "rating": rating,
        "rooms": List<dynamic>.from(rooms.map((x) => x.toJson())),
        "payment_method": List<dynamic>.from(paymentMethod.map((x) => x.toJson())),
        "type": type,
        "user_id": userId,
    };
}

class FacilityModel {
    FacilityModel({
        required this.name,
    });

    String name;

    factory FacilityModel.fromJson(Map<String, dynamic> json) => FacilityModel(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

class ImageHotel {
    ImageHotel({
        required this.imageUrl,
    });

    String imageUrl;

    factory ImageHotel.fromJson(Map<String, dynamic> json) => ImageHotel(
        imageUrl: json["image_url"],
    );

    Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
    };
}

class PaymentMethodHotel {
    PaymentMethodHotel({
        required this.method,
        required this.number,
    });

    String method;
    String number;

    factory PaymentMethodHotel.fromJson(Map<String, dynamic> json) => PaymentMethodHotel(
        method: json["method"],
        number: json["number"],
    );

    Map<String, dynamic> toJson() => {
        "method": method,
        "number": number,
    };
}

class RoomHotel {
    RoomHotel({
        required this.imageUrl,
        required this.sizeRoom,
        required this.priceRoom,
        required this.description,
    });

    String imageUrl;
    String sizeRoom;
    int priceRoom;
    String description;

    factory RoomHotel.fromJson(Map<String, dynamic> json) => RoomHotel(
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
