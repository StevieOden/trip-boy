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
    List<PaymentMethod> paymentMethod;
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
        paymentMethod: List<PaymentMethod>.from(json["payment_method"].map((x) => PaymentMethod.fromJson(x))),
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
        required this.name,
        required this.desc,
        required this.imageUrl,
        required this.price,
    });

    String name;
    String desc;
    String imageUrl;
    int price;

    factory MenuRestaurant.fromJson(Map<String, dynamic> json) => MenuRestaurant(
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

class PaymentMethod {
    PaymentMethod({
        this.bca,
        this.mandiri,
        this.bri,
        this.bni,
        this.ovo,
        this.dana,
    });

    Bca? bca;
    Bca? mandiri;
    Bca? bri;
    Bca? bni;
    Dana? ovo;
    Dana? dana;

    factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        bca: json["bca"] == null ? null : Bca.fromJson(json["bca"]),
        mandiri: json["mandiri"] == null ? null : Bca.fromJson(json["mandiri"]),
        bri: json["bri"] == null ? null : Bca.fromJson(json["bri"]),
        bni: json["bni"] == null ? null : Bca.fromJson(json["bni"]),
        ovo: json["ovo"] == null ? null : Dana.fromJson(json["ovo"]),
        dana: json["dana"] == null ? null : Dana.fromJson(json["dana"]),
    );

    Map<String, dynamic> toJson() => {
        "bca": bca?.toJson(),
        "mandiri": mandiri?.toJson(),
        "bri": bri?.toJson(),
        "bni": bni?.toJson(),
        "ovo": ovo?.toJson(),
        "dana": dana?.toJson(),
    };
}

class Bca {
    Bca({
        required this.accountNumber,
    });

    String accountNumber;

    factory Bca.fromJson(Map<String, dynamic> json) => Bca(
        accountNumber: json["account_number"],
    );

    Map<String, dynamic> toJson() => {
        "account_number": accountNumber,
    };
}

class Dana {
    Dana({
        required this.phoneNumber,
    });

    String phoneNumber;

    factory Dana.fromJson(Map<String, dynamic> json) => Dana(
        phoneNumber: json["phone_number"],
    );

    Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
    };
}
