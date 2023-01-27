import 'dart:convert';
import 'images_model.dart';

RestaurantModel? restaurantModelFromJson(String str) =>
    RestaurantModel.fromJson(json.decode(str));

String restaurantModelToJson(RestaurantModel? data) =>
    json.encode(data!.toJson());

class RestaurantModel {
  RestaurantModel(
      {this.name,
      this.alamat,
      this.description,
      this.rating,
      this.timeClosed,
      this.timeOpen,
      this.menus,
      this.googleMapsLink,
      this.images,
      this.userId,
      required this.type});

  String? name;
  String? alamat;
  String? description;
  double? rating;
  String? timeClosed;
  String? timeOpen;
  String? googleMapsLink;
  String? userId;
  String type;
  List<Menu?>? menus;
  List<ImageModel?>? images;

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        name: json["name"] == null ? "" : json["name"],
        alamat: json["alamat"] == null ? "" : json["alamat"],
        description: json["description"] == null ? "" : json["description"],
        rating: json["rating"] == null ? "" : json["rating"].toDouble(),
        timeClosed: json["time_closed"] == null ? "" : json["time_closed"],
        timeOpen: json["time_open"] == null ? "" : json["time_open"],
        googleMapsLink:
            json["google_maps_link"] == null ? "" : json["google_maps_link"],
        type: json["type"] == null ? "" : json["type"],
        userId: json["user"],
        menus: json["menu"] == null
            ? []
            : List<Menu?>.from(json["menu"]!.map((x) => Menu.fromJson(x))),
        images: json["images"] == null
            ? []
            : List<ImageModel?>.from(
                json["images"]!.map((x) => ImageModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nama_resto": name,
        "alamat": alamat,
        "description": description,
        "rating": rating,
        "time_closed": timeClosed,
        "time_open": timeOpen,
        "googleMapsLink": googleMapsLink,
        "type": type,
        "user":userId,
        "menu": menus == null
            ? []
            : List<dynamic>.from(menus!.map((x) => x!.toJson())),
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x!.toJson())),
      };
}

class Menu {
  Menu({
    this.name,
    this.desc,
    this.imageUrl,
    this.price,
  });

  String? name;
  String? desc;
  String? imageUrl;
  int? price;

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
