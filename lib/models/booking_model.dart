// To parse this JSON data, do
//
//     final bookingModel = bookingModelFromJson(jsonString);

import 'dart:convert';

import 'package:trip_boy/models/content_model.dart';

BookingModel bookingModelFromJson(String str) =>
    BookingModel.fromJson(json.decode(str));

String bookingModelToJson(BookingModel data) => json.encode(data.toJson());

class BookingModel {
  BookingModel({
    required this.id,
    required this.userId,
    required this.booking,
    required this.payment,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String userId;
  Booking booking;
  Payment payment;
  String paymentStatus;
  String createdAt;
  String updatedAt;

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        id: json["id"],
        userId: json["user_id"],
        booking: Booking.fromJson(json["booking"]),
        payment: Payment.fromJson(json["payment"]),
        paymentStatus: json["payment_status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "booking": booking.toJson(),
        "payment": payment.toJson(),
        "payment_status": paymentStatus,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Booking {
  Booking({
    required this.content,
    required this.bookingDate,
    required this.paymentTotal,
    required this.paymentMethod,
    required this.note,
  });

  ContentModel content;
  String bookingDate;
  int paymentTotal;
  String paymentMethod;
  String note;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        content: ContentModel.fromJson(json["content"]),
        bookingDate: json["booking_date"],
        paymentTotal: json["payment_total"],
        paymentMethod: json["payment_method"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "content": content.toJson(),
        "booking_date": bookingDate,
        "payment_total": paymentTotal,
        "payment_method": paymentMethod,
        "note": note,
      };
}

class Payment {
  Payment({
    required this.id,
    required this.receiptImage,
    required this.paymentMethod,
    required this.paymentAmount,
    required this.paymentStatus,
    required this.receiptSentAt,
    required this.paymentExpiresAt,
  });

  String id;
  String paymentMethod;
  int paymentAmount;
  String paymentStatus;
  String receiptSentAt;
  String receiptImage;
  String paymentExpiresAt;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        paymentMethod: json["payment_method"],
        paymentAmount: json["payment_amount"],
        paymentStatus: json["payment_status"],
        receiptImage: json["receipt_image"],
        receiptSentAt: json["receipt_sent_at"],
        paymentExpiresAt: json["payment_expires_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "payment_method": paymentMethod,
        "payment_amount": paymentAmount,
        "payment_status": paymentStatus,
        "receipt_image": receiptImage,
        "receipt_sent_at": receiptSentAt,
        "payment_expires_at": paymentExpiresAt,
      };
}
