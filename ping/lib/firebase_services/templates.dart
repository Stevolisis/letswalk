import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

typedef Locations = List<String>;
typedef Courses = List<String>;

class TemplateRepository {
  static final _firestore = FirebaseFirestore.instance;

  static Future<Locations> loadLocations() async {
    final Locations locations = [];

    final locationsSnapshot = await _firestore
        .collection('template')
        .where('type', isEqualTo: 'location-based')
        .get();

    for (final location in locationsSnapshot.docs) {
      locations.addAll(
        (location.data()['locations'] as List<dynamic>).cast<String>(),
      );
    }
    return locations;
  }

  static Future<Courses> loadCourses() async {
    final Courses courses = [];

    final coursesSnapshot = await _firestore
        .collection('template')
        .where('type', isEqualTo: 'course-based')
        .get();

    for (final course in coursesSnapshot.docs) {
      courses
          .addAll((course.data()['courses'] as List<dynamic>).cast<String>());
    }
    return courses;
  }

  static uploadLocationStatus(
      {required String from, required String to}) async {
    final displayName = FirebaseAuth.instance.currentUser?.displayName;

    FirebaseFirestore.instance.collection('statuses').doc().set({
      'user': displayName,
      'type': 'location-based',
      'from': from,
      'to': to,
    });
  }

  static uploadStudyStatus({required String course}) async {
    final displayName = FirebaseAuth.instance.currentUser?.displayName;

    FirebaseFirestore.instance.collection('statuses').doc().set({
      'user': displayName,
      'type': 'study-based',
      'course': course,
    });
  }
}
