import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  final name = FirebaseAuth.instance.currentUser!.displayName;
  final email = FirebaseAuth.instance.currentUser!.email;
  final phoneNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
  final profileImage = FirebaseAuth.instance.currentUser!.photoURL;
  final uid = FirebaseAuth.instance.currentUser!.uid;
}
