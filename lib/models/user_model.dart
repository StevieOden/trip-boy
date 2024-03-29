import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? role, email, uid, name, phoneNumber, profileImage, password;

  UserModel(
      {this.uid,
      this.role,
      this.email,
       this.profileImage,
       this.name,
       this.phoneNumber,
       this.password});

  UserModel.fromMap(Map<String, Object?> json)
      : this(
          uid: json['uid'] != null ? json['uid'] as String : "",
          role: json['role']! as String,
          email: json['user_email']! as String,
          name: json['user_name'] != null ? json['user_name']! as String : '',
          phoneNumber: json['user_phone_number'] != null
              ? json['user_phone_number']! as String
              : '',
          profileImage: json['user_profile_image'] != null
              ? json['user_profile_image']! as String
              : '',
              password: json['password'] != null ? json['password']! as String : '',
        );

  Map<String, Object?> toJson() {
    return {
      'uid': uid,
      'role': role,
      'user_email': email,
      'user_name': name,
      'user_phone_number': phoneNumber,
      'user_profile_image': profileImage,
      'password': password,
      'created_at': FieldValue.serverTimestamp()
    };
  }
}
