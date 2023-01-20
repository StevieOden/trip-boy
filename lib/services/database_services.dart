import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trip_boy/models/destination_model.dart';
import 'package:trip_boy/models/event_model.dart';
import 'package:trip_boy/models/facility_model.dart';
import 'package:trip_boy/models/hotel_model.dart';
import 'package:trip_boy/models/restaurant_model.dart';
import '../models/images_model.dart';
import '../models/user_model.dart';

class DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference restaurants =
      FirebaseFirestore.instance.collection('restaurants');
  CollectionReference hotels = FirebaseFirestore.instance.collection('hotels');
  CollectionReference events = FirebaseFirestore.instance.collection('events');
  CollectionReference destination =
      FirebaseFirestore.instance.collection('destination');

  Future<dynamic> addDefaultPatientUser(String uid, String email, String name,
      String phoneNumber, String photoUrl) async {
    QuerySnapshot querySnapshot =
        await users.where("uid", isEqualTo: uid).get();
    UserModel userModel = UserModel(
        role: "user_customer",
        email: email,
        name: name,
        phoneNumber: phoneNumber == null ? "" : phoneNumber,
        profileImage: photoUrl,
        uid: uid);
    if (querySnapshot.docs.isEmpty) {
      await users
          .add(userModel.toJson())
          .then((value) => print('User Added'))
          .catchError((error) => print("Error: " + error.toString()));
    }
  }

  Future<dynamic> getUserData(uid) async {
    Map<String, dynamic> data = {};
    QuerySnapshot querySnapshot =
        await users.where("uid", isEqualTo: uid).get();
    for (var index = 0; index < querySnapshot.docs.length; index++) {
      data = querySnapshot.docs[index].data() as Map<String, dynamic>;
    }
    return UserModel.fromMap(data);
  }

  Future<dynamic> updateUserData(uid, phoneNumber, name, imageUrl) async {
    QuerySnapshot querySnapshot =
        await users.where("uid", isEqualTo: uid).get();
    for (var i = 0; i < querySnapshot.size; i++) {
      await users
          .doc(querySnapshot.docs[i].id)
          .update({
            "user_name": name,
            "user_phone_number": phoneNumber,
            "user_profile_image": imageUrl
          })
          .then((value) => print('User Updated'))
          .catchError((error) => print("Error: " + error.toString()));
    }
  }

  Future<List<RestaurantModel>> getRestaurantData() async {
    List<RestaurantModel> restaurantsData = [];
    QuerySnapshot snapshot = await restaurants.get();
    for (var data in snapshot.docs) {
      Map<String, dynamic> mapData = data.data() as Map<String, dynamic>;
      RestaurantModel restaurantModel = RestaurantModel.fromJson(mapData);
      restaurantsData.add(restaurantModel);
    }
    return restaurantsData;
  }

  Future<List<HotelModel>> getHotelData() async {
    List<HotelModel> hotelData = [];
    QuerySnapshot snapshot = await hotels.get();
    for (var data in snapshot.docs) {
      Map<String, dynamic> mapData = data.data() as Map<String, dynamic>;
      HotelModel hotelModel = HotelModel.fromJson(mapData);
      hotelData.add(hotelModel);
    }
    return hotelData;
  }

  Future<List<DestinationModel>> getDestinationData() async {
    List<DestinationModel> destinationData = [];
    QuerySnapshot snapshot = await destination.get();
    for (var data in snapshot.docs) {
      Map<String, dynamic> mapData = data.data() as Map<String, dynamic>;
      DestinationModel destinationModel = DestinationModel.fromJson(mapData);
      destinationData.add(destinationModel);
    }
    return destinationData;
  }

  Future<List<EventModel>> getEventData() async {
    List<EventModel> eventData = [];
    QuerySnapshot snapshot = await events.get();
    for (var data in snapshot.docs) {
      Map<String, dynamic> mapData = data.data() as Map<String, dynamic>;
      EventModel eventModel = EventModel.fromJson(mapData);
      eventData.add(eventModel);
    }
    return eventData;
  }

  Future addHotelData(
      String alamat,
      String description,
      List<Facility> facilityList,
      double rating,
      List<ImageModel> imageList,
      String name,
      String googleMapsLink,
      List<Room> roomsList) async {
    HotelModel data = HotelModel(
        type: "hotel",
        alamat: alamat,
        description: description,
        facility: facilityList,
        rating: rating,
        images: imageList,
        googleMapsLink: googleMapsLink,
        name: name,
        rooms: roomsList);
    await hotels
        .add(data.toJson())
        .then((value) => print('Hotel Added'))
        .catchError((error) => print("Error: " + error.toString()));
  }

  Future addEventData(
      DateTime timeHeld,
      String description,
      String imageUrl,
      String meetLinks,
      String name,
      int price,
      double rating,
      List<Term> termList,
      String ticketType) async {
    EventModel data = EventModel(
        timeHeld: timeHeld,
        description: description,
        imageUrl: imageUrl,
        meetLinks: meetLinks,
        name: name,
        price: price,
        rating: rating,
        terms: termList,
        ticketType: ticketType,
        type: "event");
    await events
        .add(data.toJson())
        .then((value) => print('Event Added'))
        .catchError((error) => print("Error: " + error.toString()));
  }

  Future addRestaurantData(
      String alamat,
      String description,
      String googleMapsLink,
      List<ImageModel> images,
      List<Menu> menus,
      String name,
      double rating,
      String timeClosed,
      String timeOpen) async {
    RestaurantModel data = RestaurantModel(
      type: "restaurant",
      alamat: alamat,
      description: description,
      googleMapsLink: googleMapsLink,
      images: images,
      menus: menus,
      name: name,
      rating: rating,
      timeClosed: timeClosed,
      timeOpen: timeOpen,
    );
    await restaurants
        .add(data.toJson())
        .then((value) => print('Restaurant Added'))
        .catchError((error) => print("Error: " + error.toString()));
  }

  Future addDestinationData(
      String alamat,
      String description,
      List<Facility> facilities,
      List<ImageModel> images,
      String name,
      String googleMapsLink,
      double rating,
      List<Ticket> tickets,
      String timeClosed,
      String timeOpen) async {
    DestinationModel data = DestinationModel(
      type: "destination",
      alamat: alamat,
      description: description,
      facility: facilities,
      images: images,
      name: name,
      googleMapLink: googleMapsLink,
      rating: rating,
      tickets: tickets,
      timeClosed: timeClosed,
      timeOpen: timeOpen,
    );
    await destination
        .add(data.toJson())
        .then((value) => print('Destination Added'))
        .catchError((error) => print("Error: " + error.toString()));
  }
}
