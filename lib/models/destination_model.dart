import 'dart:convert';

DestinationModel destinationModelFromJson(String str) => DestinationModel.fromJson(json.decode(str));

String destinationModelToJson(DestinationModel data) => json.encode(data.toJson());

class DestinationModel {
    DestinationModel({
        required this.address,
        required this.description,
        required this.facility,
        required this.googleMapsLink,
        required this.images,
        required this.name,
        required this.rating,
        required this.tickets,
        required this.paymentMethod,
        required this.timeClosed,
        required this.timeOpen,
        required this.type,
        required this.userId,
    });

    String address;
    String description;
    List<FacilityDestinationModel> facility;
    String googleMapsLink;
    List<ImageDestination> images;
    String name;
    double rating;
    List<TicketDestination> tickets;
    List<PaymentMethodDestination> paymentMethod;
    String timeClosed;
    String timeOpen;
    String type;
    String userId;

    factory DestinationModel.fromJson(Map<String, dynamic> json) => DestinationModel(
        address: json["address"],
        description: json["description"],
        facility: List<FacilityDestinationModel>.from(json["facility"].map((x) => FacilityDestinationModel.fromJson(x))),
        googleMapsLink: json["google_maps_link"],
        images: List<ImageDestination>.from(json["images"].map((x) => ImageDestination.fromJson(x))),
        name: json["name"],
        rating: json["rating"],
        tickets: List<TicketDestination>.from(json["tickets"].map((x) => TicketDestination.fromJson(x))),
        paymentMethod: List<PaymentMethodDestination>.from(json["payment_method"].map((x) => PaymentMethodDestination.fromJson(x))),
        timeClosed: json["time_closed"],
        timeOpen: json["time_open"],
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
        "tickets": List<dynamic>.from(tickets.map((x) => x.toJson())),
        "payment_method": List<dynamic>.from(paymentMethod.map((x) => x.toJson())),
        "time_closed": timeClosed,
        "time_open": timeOpen,
        "type": type,
        "user_id": userId,
    };
}

class FacilityDestinationModel {
    FacilityDestinationModel({
        required this.name,
    });

    String name;

    factory FacilityDestinationModel.fromJson(Map<String, dynamic> json) => FacilityDestinationModel(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

class ImageDestination {
    ImageDestination({
        required this.imageUrl,
    });

    String imageUrl;

    factory ImageDestination.fromJson(Map<String, dynamic> json) => ImageDestination(
        imageUrl: json["image_url"],
    );

    Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
    };
}
class PaymentMethodDestination {
    PaymentMethodDestination({
        required this.method,
        required this.number,
    });

    String method;
    String number;

    factory PaymentMethodDestination.fromJson(Map<String, dynamic> json) => PaymentMethodDestination(
        method: json["method"],
        number: json["number"],
    );

    Map<String, dynamic> toJson() => {
        "method": method,
        "number": number,
    };
}

class TicketDestination {
    TicketDestination({
        required this.name,
        required this.price,
    });

    String name;
    int price;

    factory TicketDestination.fromJson(Map<String, dynamic> json) => TicketDestination(
        name: json["name"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
    };
}
