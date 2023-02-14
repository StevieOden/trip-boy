import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trip_boy/common/user_data.dart';
import 'package:trip_boy/models/content_model.dart';
import 'package:trip_boy/models/destination_model.dart';
import 'package:trip_boy/models/event_model.dart';
import 'package:trip_boy/models/hotel_model.dart';
import 'package:trip_boy/models/restaurant_model.dart';
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

  Future<List<HotelModel>> getHotelData(bool isUpload, String uid) async {
    List<HotelModel> hotelData = [];
    QuerySnapshot snapshotHotels = await hotels.get();
    QuerySnapshot snapshotHotels2 =
        await hotels.where("user_id", isEqualTo: uid).get();
    var snapHotel = isUpload ? snapshotHotels2 : snapshotHotels;

    for (var data in snapHotel.docs) {
      Map<String, dynamic> mapData = data.data() as Map<String, dynamic>;
      HotelModel hotelModel = HotelModel.fromJson(mapData);
      hotelData.add(hotelModel);
    }

    return hotelData;
  }

  Future<List<EventModel>> getEventData(bool isUpload, String uid) async {
    List<EventModel> eventData = [];
    QuerySnapshot snapshotEvent = await events.get();
    QuerySnapshot snapshotEvent2 =
        await events.where("user_id", isEqualTo: uid).get();
    var snapEvent = isUpload ? snapshotEvent2 : snapshotEvent;
    for (var data in snapEvent.docs) {
      Map<String, dynamic> mapData = data.data() as Map<String, dynamic>;
      EventModel eventModel = EventModel.fromJson(mapData);
      eventData.add(eventModel);
    }
    return eventData;
  }

  Future<List<DestinationModel>> getDestinationData(
      bool isUpload, String uid) async {
    List<DestinationModel> destinationData = [];
    QuerySnapshot snapshotDestination = await destination.get();
    QuerySnapshot snapshotDestination2 =
        await destination.where("user_id", isEqualTo: uid).get();
    var snapDestination = isUpload ? snapshotDestination2 : snapshotDestination;
    for (var data in snapDestination.docs) {
      Map<String, dynamic> mapData = data.data() as Map<String, dynamic>;
      DestinationModel destinationModel = DestinationModel.fromJson(mapData);
      destinationData.add(destinationModel);
    }
    return destinationData;
  }

  Future<List<RestaurantModel>> getRestaurantData(
      bool isUpload, String uid) async {
    List<RestaurantModel> restaurantsData = [];
    QuerySnapshot snapshot = await restaurants.get();
    QuerySnapshot snapshot2 =
        await restaurants.where("user_id", isEqualTo: uid).get();
    var snap = isUpload ? snapshot2 : snapshot;
    for (var data in snap.docs) {
      Map<String, dynamic> mapData = data.data() as Map<String, dynamic>;
      RestaurantModel restaurantModel = RestaurantModel.fromJson(mapData);
      restaurantsData.add(restaurantModel);
    }
    return restaurantsData;
  }

  Future addHotelData(
      String alamat,
      String description,
      List<FacilityModel> facilityList,
      double rating,
      List<ImageHotel> images,
      String name,
      String googleMapsLink,
      String latlongtude,
      List<RoomHotel> roomsList) async {
    HotelModel data = HotelModel(
        type: "hotel",
        address: alamat,
        description: description,
        facility: facilityList,
        rating: rating,
        images: images,
        googleMapsLink: googleMapsLink,
        name: name,
        rooms: roomsList,
        paymentMethod: [],
        userId: "");
    await hotels
        .add(data.toJson())
        .then((value) => print('Hotel Added'))
        .catchError((error) => print("Error: " + error.toString()));
  }

  Future addEventData(
      String timeHeld,
      String description,
      String imageUrl,
      String meetLinks,
      String name,
      int price,
      double rating,
      List<TermEvent> termList,
      String ticketType) async {
    EventModel data = EventModel(
        timeHeld: timeHeld,
        description: description,
        imageUrl: imageUrl,
        meetLink: meetLinks,
        name: name,
        price: price,
        rating: rating,
        terms: termList,
        ticketType: ticketType,
        type: "event",
        userId: "",
        paymentMethod: []);
    await events
        .add(data.toJson())
        .then((value) => print('Event Added'))
        .catchError((error) => print("Error: " + error.toString()));
  }

  Future addRestaurantData(
    String alamat,
    String description,
    String googleMapsLink,
    List<ImageModelRestaurant> images,
    List<MenuRestaurant> menus,
    String name,
    double rating,
    String timeClosed,
    String timeOpen,
  ) async {
    RestaurantModel data = RestaurantModel(
        type: "restaurant",
        address: alamat,
        description: description,
        googleMapsLink: googleMapsLink,
        images: images,
        menu: menus,
        name: name,
        rating: rating,
        timeClosed: timeClosed,
        timeOpen: timeOpen,
        userId: UserData().uid,
        paymentMethod: []);
    await restaurants
        .add(data.toJson())
        .then((value) => print('Restaurant Added'))
        .catchError((error) => print("Error: " + error.toString()));
  }

  Future addDestinationData(
      String alamat,
      String description,
      List<FacilityDestinationModel> facilities,
      List<ImageDestination> images,
      String name,
      String googleMapsLink,
      double rating,
      List<TicketDestination> tickets,
      String timeClosed,
      String timeOpen) async {
    DestinationModel data = DestinationModel(
        type: "destination",
        address: alamat,
        description: description,
        facility: facilities,
        images: images,
        name: name,
        googleMapsLink: googleMapsLink,
        rating: rating,
        tickets: tickets,
        timeClosed: timeClosed,
        timeOpen: timeOpen,
        userId: "",
        paymentMethod: []);
    await destination
        .add(data.toJson())
        .then((value) => print('Destination Added'))
        .catchError((error) => print("Error: " + error.toString()));
  }
}
