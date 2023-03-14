// To parse this JSON data, do
//
//     final eventModel = eventModelFromJson(jsonString);

import 'dart:convert';

EventModel eventModelFromJson(String str) => EventModel.fromJson(json.decode(str));

String eventModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
    EventModel({
        required this.description,
        this.imageUrl,
        this.meetLink,
        required this.name,
        this.price,
        this.rating,
        this.terms,
        this.paymentMethod,
        this.ticketType,
        this.timeHeld,
        required this.type,
        this.userId,
    });

    String description;
    String? imageUrl;
    String? meetLink;
    String name;
    int? price;
    double?  rating;
    List<TermEvent>?  terms;
    List<PaymentMethodEvent>?  paymentMethod;
    String ? ticketType;
    String?  timeHeld;
    String type;
    String ? userId;

    factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        description: json["description"],
        imageUrl: json["image_url"],
        meetLink: json["meet_link"],
        name: json["name"],
        price: json["price"],
        rating: json["rating"]?.toDouble(),
        terms: List<TermEvent>.from(json["terms"].map((x) => TermEvent.fromJson(x))),
        paymentMethod: List<PaymentMethodEvent>.from(json["payment_method"].map((x) => PaymentMethodEvent.fromJson(x))),
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
        "terms": List<dynamic>.from(terms!.map((x) => x.toJson())),
        "payment_method": List<dynamic>.from(paymentMethod!.map((x) => x.toJson())),
        "ticket_type": ticketType,
        "time_held": timeHeld,
        "type": type,
        "user_id": userId,
    };
}

class PaymentMethodEvent {
    PaymentMethodEvent({
        required this.method,
        required this.number,
    });

    String method;
    String number;

    factory PaymentMethodEvent.fromJson(Map<String, dynamic> json) => PaymentMethodEvent(
        method: json["method"],
        number: json["number"],
    );

    Map<String, dynamic> toJson() => {
        "method": method,
        "number": number,
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
