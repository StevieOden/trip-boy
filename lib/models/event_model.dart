// To parse this JSON data, do
//
//     final eventModel = eventModelFromJson(jsonString);

import 'dart:convert';

EventModel eventModelFromJson(String str) => EventModel.fromJson(json.decode(str));

String eventModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
    EventModel({
        required this.description,
        required this.imageUrl,
        required this.meetLink,
        required this.name,
        required this.price,
        required this.rating,
        required this.terms,
        required this.paymentMethod,
        required this.ticketType,
        required this.timeHeld,
        required this.type,
        required this.userId,
    });

    String description;
    String imageUrl;
    String meetLink;
    String name;
    int price;
    double rating;
    List<TermEvent> terms;
    List<PaymentMethod> paymentMethod;
    String ticketType;
    String timeHeld;
    String type;
    String userId;

    factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        description: json["description"],
        imageUrl: json["image_url"],
        meetLink: json["meet_link"],
        name: json["name"],
        price: json["price"],
        rating: json["rating"]?.toDouble(),
        terms: List<TermEvent>.from(json["terms"].map((x) => TermEvent.fromJson(x))),
        paymentMethod: List<PaymentMethod>.from(json["payment_method"].map((x) => PaymentMethod.fromJson(x))),
        ticketType: json["ticket_type"],
        timeHeld: json["time_held"],
        type: json["type"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "image_url": imageUrl,
        "meet_link": meetLink,
        "name": name,
        "price": price,
        "rating": rating,
        "terms": List<dynamic>.from(terms.map((x) => x.toJson())),
        "payment_method": List<dynamic>.from(paymentMethod.map((x) => x.toJson())),
        "ticket_type": ticketType,
        "time_held": timeHeld,
        "type": type,
        "user_id": userId,
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

class TermEvent {
    TermEvent({
        required this.text,
    });

    String text;

    factory TermEvent.fromJson(Map<String, dynamic> json) => TermEvent(
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "text": text,
    };
}
