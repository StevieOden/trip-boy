import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

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
}
