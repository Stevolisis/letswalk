import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

typedef Locations = List<String>;
typedef Courses = List<String>;

class MessageRepository {
  static final _firestore = FirebaseFirestore.instance;

  static Future sendStudyMessage(
      {required String course, required String message}) async {
    _firestore.collection('chats').doc().set({
      'type': "course-based",
      'message': message,
      'senderRegNo': FirebaseAuth.instance.currentUser!.displayName
    });
  }

  static Future sendCommuteMessge({
    required String from,
    required String to,
    required String message,
  }) async {
    _firestore.collection('chats').doc().set({
      'type': "location-based",
      'message': message,
      'from': from,
      'to': to,
      'senderRegNo': FirebaseAuth.instance.currentUser!.displayName
    });
  }
}
