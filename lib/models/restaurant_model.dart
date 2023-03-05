// To parse this JSON data, do
//
//     final restaurantModel = restaurantModelFromJson(jsonString);

import 'dart:convert';

RestaurantModel restaurantModelFromJson(String str) => RestaurantModel.fromJson(json.decode(str));

String restaurantModelToJson(RestaurantModel data) => json.encode(data.toJson());

class RestaurantModel {
    RestaurantModel({
        required this.address,
        required this.description,
        required this.googleMapsLink,
        required this.images,
        required this.menu,
        required this.paymentMethod,
        required this.name,
        required this.rating,
        required this.timeClosed,
        required this.timeOpen,
        required this.type,
        required this.userId,
    });

    String address;
    String description;
    String googleMapsLink;
    List<ImageModelRestaurant> images;
    List<MenuRestaurant> menu;
    List<PaymentMethodRestaurant> paymentMethod;
    String name;
    double rating;
    String? timeClosed;
    String timeOpen;
    String type;
    String userId;

    factory RestaurantModel.fromJson(Map<String, dynamic> json) => RestaurantModel(
        address: json["address"],
        description: json["description"],
        googleMapsLink: json["google_maps_link"],
        images: List<ImageModelRestaurant>.from(json["images"].map((x) => ImageModelRestaurant.fromJson(x))),
        menu: List<MenuRestaurant>.from(json["menu"].map((x) => MenuRestaurant.fromJson(x))),
        paymentMethod: List<PaymentMethodRestaurant>.from(json["payment_method"].map((x) => PaymentMethodRestaurant.fromJson(x))),
        name: json["name"],
        rating: json["rating"].toDouble(),
        timeClosed: json["time_closed"],
        timeOpen: json["time_open"],
        type: json["type"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "description": description,
        "google_maps_link": googleMapsLink,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "menu": List<dynamic>.from(menu.map((x) => x.toJson())),
        "payment_method": List<dynamic>.from(paymentMethod.map((x) => x.toJson())),
        "name": name,
        "rating": rating,
        "time_closed": timeClosed,
        "time_open": timeOpen,
        "type": type,
        "user_id": userId,
    };
}

class ImageModelRestaurant {
    ImageModelRestaurant({
        required this.imageUrl,
    });

    String imageUrl;

    factory ImageModelRestaurant.fromJson(Map<String, dynamic> json) => ImageModelRestaurant(
        imageUrl: json["image_url"],
    );

    Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
    };
}

class MenuRestaurant {
    MenuRestaurant({
      required this.type,
        required this.name,
        required this.desc,
        required this.imageUrl,
        required this.price,
    });

    String name;
    String desc;
    String imageUrl;
    String type;
    int price;

    factory MenuRestaurant.fromJson(Map<String, dynamic> json) => MenuRestaurant(
        name: json["name"],
        desc: json["desc"],
        imageUrl: json["image_url"],
        price: json["price"],
        type: json["type"]
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "desc": desc,
        "image_url": imageUrl,
        "price": price,
        "type":type
    };
}
class PaymentMethodRestaurant {
    PaymentMethodRestaurant({
        required this.method,
        required this.number,
    });

    String method;
    String number;

    factory PaymentMethodRestaurant.fromJson(Map<String, dynamic> json) => PaymentMethodRestaurant(
        method: json["method"],
        number: json["number"],
    );

    Map<String, dynamic> toJson() => {
        "method": method,
        "number": number,
    };
}