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
    List<PaymentMethod> paymentMethod;
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
        paymentMethod: List<PaymentMethod>.from(json["payment_method"].map((x) => PaymentMethod.fromJson(x))),
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
