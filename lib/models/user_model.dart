import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String role, email, uid, name, phoneNumber, profileImage;

  UserModel(
      {required this.uid,
      required this.role,
      required this.email,
      required this.profileImage,
      required this.name,
      required this.phoneNumber});

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
        );

  Map<String, Object?> toJson() {
    return {
      'uid': uid,
      'role': role,
      'user_email': email,
      'user_name': name,
      'user_phone_number': phoneNumber,
      'user_profile_image': profileImage,
      'created_at': FieldValue.serverTimestamp()
    };
  }
}
