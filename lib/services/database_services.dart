import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trip_boy/common/shared_code.dart';
import 'package:trip_boy/common/user_data.dart';
import 'package:trip_boy/models/booking_model.dart';
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

  Future<UserModel?> addDefaultPatientUser(String uid, String? email,
      String name, String? phoneNumber, String photoUrl, String role) async {
    QuerySnapshot querySnapshot =
        await users.where("uid", isEqualTo: uid).get();
    UserModel userModel = UserModel(
        role: role,
        email: email,
        name: name,
        password: "",
        phoneNumber: phoneNumber == null ? "" : phoneNumber,
        profileImage: photoUrl,
        uid: uid);
    if (querySnapshot.docs.isEmpty) {
      await users
          .add(userModel.toJson())
          .then((value) => print('User Added'))
          .catchError((error) => print("Error: " + error.toString()));
    }
    return null;
  }

  Future<UserModel> getUserData(uid) async {
    Map<String, dynamic> data = {};
    QuerySnapshot querySnapshot =
        await users.where("uid", isEqualTo: uid).get();
    for (var index = 0; index < querySnapshot.docs.length; index++) {
      data = querySnapshot.docs[index].data() as Map<String, dynamic>;
    }
    return UserModel.fromMap(data);
  }

  Future<dynamic> updateUserData(
      uid, phoneNumber, email, name, imageUrl) async {
    QuerySnapshot querySnapshot =
        await users.where("uid", isEqualTo: uid).get();
    for (var i = 0; i < querySnapshot.size; i++) {
      await users
          .doc(querySnapshot.docs[i].id)
          .update({
            "user_name": name,
            "user_phone_number": phoneNumber,
            "user_profile_image": imageUrl,
            "user_email": email
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
      List<FacilityHotelModel> facilityList,
      double rating,
      List<ImageHotel> images,
      String name,
      String googleMapsLink,
      List<RoomHotel> roomsList,
      List<PaymentMethodHotel> paymentMethod) async {
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
        paymentMethod: paymentMethod,
        userId: UserData().uid);
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
      String ticketType,
      List<PaymentMethodEvent> paymentMethod) async {
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
        userId: UserData().uid,
        paymentMethod: paymentMethod);
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
      List<PaymentMethodRestaurant> paymentMethod) async {
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
        paymentMethod: paymentMethod);
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
      String timeOpen,
      List<PaymentMethodDestination> paymentMethod) async {
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
        userId: UserData().uid,
        paymentMethod: paymentMethod);
    await destination
        .add(data.toJson())
        .then((value) => print('Destination Added'))
        .catchError((error) => print("Error: " + error.toString()));
  }

  Future addBookingDataEvent(
      int paymentTotal,
      String bookingDate,
      String note,
      String paymentMethod,
      String contentName,
      String contentType,
      double contentRating,
      String contentDesc,
      List<PaymentMethodEvent> paymentMethods) async {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    var paymentExpired = SharedCode.dateAndTimeFormat
        .format(DateTime.now().add(Duration(hours: 1)));

    BookingModel dataBooking = BookingModel(
        id: getRandomString(28),
        userId: UserData().uid,
        booking: Booking(
            note: note,
            content: ContentModel(
                paymentMethod: paymentMethods,
                description: contentDesc,
                name: contentName,
                rating: contentRating,
                type: contentType,
                userId: UserData().uid),
            bookingDate: bookingDate,
            paymentMethod: paymentMethod,
            paymentTotal: paymentTotal),
        payment: Payment(
            id: "",
            receiptImage: "",
            paymentMethod: paymentMethod,
            paymentAmount: paymentTotal,
            paymentStatus: paymentTotal == 0 ? "done" : "process",
            receiptSentAt: "",
            paymentExpiresAt: paymentExpired),
        paymentStatus: paymentTotal == 0 ? "done" : "process",
        createdAt: SharedCode.dateAndTimeFormat.format(DateTime.now()),
        updatedAt: SharedCode.dateAndTimeFormat.format(DateTime.now()));
    QuerySnapshot snapshot =
        await users.where("uid", isEqualTo: UserData().uid).get();
    for (var data in snapshot.docs) {
      await users
              .doc(data.id)
              .collection("order")
              .add(dataBooking.toJson())
              .then((value) => print('Booking Data Added'))
          // .catchError((error) => print("Error: " + error.toString()))
          ;
    }
  }

  Future<bool> checkPayment() async {
    List<BookingModel> list = [];
    bool isAny = false;
    QuerySnapshot snapshot =
        await users.where("uid", isEqualTo: UserData().uid).get();
    for (var data in snapshot.docs) {
      QuerySnapshot snapshot2 = await users
          .doc(data.id)
          .collection("order")
          .where("payment_status", isEqualTo: "process")
          .get();
      for (var data in snapshot2.docs) {
        Map<String, dynamic> mapData = data.data() as Map<String, dynamic>;
        BookingModel model = BookingModel.fromJson(mapData);
        list.add(model);
      }
    }
    isAny = list.isNotEmpty ? true : false;
    return isAny;
  }

  Future<List<BookingModel>> getBookingData() async {
    List<BookingModel> list = [];
    QuerySnapshot snapshot =
        await users.where("uid", isEqualTo: UserData().uid).get();
    for (var data in snapshot.docs) {
      QuerySnapshot snapshot2 =
          await users.doc(data.id).collection("order").get();
      for (var data in snapshot2.docs) {
        Map<String, dynamic> mapData = data.data() as Map<String, dynamic>;
        BookingModel model = BookingModel.fromJson(mapData);
        list.add(model);
      }
    }

    return list;
  }

  Future<List<String>> getBookingId() async {
    List<String> bookingIdList = [];
    QuerySnapshot snapshot =
        await users.where("uid", isEqualTo: UserData().uid).get();
    for (var data in snapshot.docs) {
      QuerySnapshot snapshot2 =
          await users.doc(data.id).collection("order").get();
      for (var data in snapshot2.docs) {
        bookingIdList.add(data.id);
      }
    }

    return bookingIdList;
  }

  Future<void> deleteContent(String contentId, String type) async {
    type == "restaurant"
        ? await restaurants.doc(contentId).delete()
        : type == "event"
            ? await events.doc(contentId).delete()
            : type == "hotel"
                ? await hotels.doc(contentId).delete()
                : await destination.doc(contentId).delete();
  }

  Future<List<String>> getContentId(String type) async {
    List<String> contentIdList = [];
    QuerySnapshot snapshot = type == "restaurant"
        ? await restaurants.get()
        : type == "event"
            ? await events.get()
            : type == "hotel"
                ? await hotels.get()
                : await destination.get();

    for (var i in snapshot.docs) {
      contentIdList.add(i.id);
    }
    return contentIdList;
  }

  Future<void> updateReceiptPayment(receiptImage, orderId) async {
    QuerySnapshot querySnapshot =
        await users.where("uid", isEqualTo: UserData().uid).get();

    for (var i = 0; i < querySnapshot.size; i++) {
      await users
          .doc(querySnapshot.docs[i].id)
          .collection("order")
          .doc(orderId)
          .set({
            "payment": {
              "payment_status": "in-review",
              "receipt_image": receiptImage,
              "receipt_sent_at":
                  SharedCode.dateAndTimeFormat.format(DateTime.now())
            },
            "updated_at": SharedCode.dateAndTimeFormat.format(DateTime.now()),
            "payment_status": "in-review",
          }, SetOptions(merge: true))
          .then((value) => print('Receipt Payment Updated'))
          .catchError((error) => print("Error: " + error.toString()));
    }
  }

  Future<String> getOrderId(String id) async {
    String orderId = "";
    QuerySnapshot snapshot =
        await users.where("uid", isEqualTo: UserData().uid).get();

    for (var i in snapshot.docs) {
      QuerySnapshot snapshot = await users
          .doc(i.id)
          .collection("order")
          .where("id", isEqualTo: id)
          .get();
      for (var i in snapshot.docs) {
        orderId = i.id;
      }
    }
    return orderId;
  }

  Future<List<BookingModel>> getOrderAdmin() async {
    List<BookingModel> listData = [];
    QuerySnapshot snapshot = await users.get();

    for (var i in snapshot.docs) {
      QuerySnapshot snap = await users.doc(i.id).collection("order").get();
      for (var i in snap.docs) {
        Map<String, dynamic> mapData = i.data() as Map<String, dynamic>;
        BookingModel model = BookingModel.fromJson(mapData);
        listData.add(model);
      }
    }
    return listData;
  }

  Future<UserModel> getOrderUserData(uid) async {
    Map<String, dynamic> data = {};
    QuerySnapshot querySnapshot =
        await users.where("uid", isEqualTo: uid).get();
    for (var index in querySnapshot.docs) {
      data = index.data() as Map<String, dynamic>;
    }
    return UserModel.fromMap(data);
  }

  Future<void> updatePaymentAccept(userId, orderId) async {
    QuerySnapshot querySnapshot =
        await users.where("uid", isEqualTo: userId).get();

    print("orderId: " + orderId);
    for (var i = 0; i < querySnapshot.size; i++) {
      await users
          .doc(querySnapshot.docs[i].id)
          .collection("order")
          .doc(orderId)
          .set({
            "payment": {
              "payment_status": "done",
            },
            "updated_at": SharedCode.dateAndTimeFormat.format(DateTime.now()),
            "payment_status": "done",
          }, SetOptions(merge: true))
          .then((value) => print('updatePaymentAccept Updated'))
          .catchError((error) => print("Error: " + error.toString()));
    }
  }

  Future<void> updatePaymentReject(userId,orderId) async {
    QuerySnapshot querySnapshot =
        await users.where("uid", isEqualTo: userId).get();

    for (var i = 0; i < querySnapshot.size; i++) {
      await users
          .doc(querySnapshot.docs[i].id)
          .collection("order")
          .doc(orderId)
          .set({
            "payment": {
              "payment_status": "canceled",
            },
            "updated_at": SharedCode.dateAndTimeFormat.format(DateTime.now()),
            "payment_status": "canceled",
          }, SetOptions(merge: true))
          .then((value) => print('updatePaymentReject Updated'))
          .catchError((error) => print("Error: " + error.toString()));
    }
  }

  Future<String> getOrderIdAdmin(String userId, String id) async {
    String orderId = "";
    QuerySnapshot snapshot =
        await users.where("uid", isEqualTo: userId).get();

    for (var i in snapshot.docs) {
      QuerySnapshot snapshot = await users
          .doc(i.id)
          .collection("order")
          .where("id", isEqualTo: id)
          .get();
      for (var i in snapshot.docs) {
        orderId = i.id;
      }
    }
    return orderId;
  }
}
