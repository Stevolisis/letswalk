import 'package:cloud_firestore/cloud_firestore.dart';

typedef Locations = List<String>;
typedef Courses = List<String>;

class TemplateRepository {
  static final _firestore = FirebaseFirestore.instance;

  static Future<Locations> loadLocations() async {
    final Locations locations = [];

    // final locationsSnapshot = await _firestore
    //     .collection('template')
    //     .where('type', isEqualTo: 'location-based')
    //     .get();

    // for (final location in locationsSnapshot.docs) {
    //   locations.add(location.data() as String);
    // }

    return locations;
  }

  static Future<Courses> loadCourses() async {
    final Courses courses = [];

    // final coursesSnapshot = await _firestore
    //     .collection('template')
    //     .where('type', isEqualTo: 'study-based')
    //     .get();

    // for (final course in coursesSnapshot.docs) {
    //   courses.add(course.data() as String);
    // }

    return courses;
  }
}
