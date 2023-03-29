class LocationCategory {
  const LocationCategory({required this.locations});
  final List<String> locations;

  static fromJson(Map<String, dynamic> data) {
    return LocationCategory(locations: data['locations'] ?? []);
  }
}

class StudyCategory {
  const StudyCategory({required this.courses});
  final List<String> courses;

  static fromJson(Map<String, dynamic> data) {
    return StudyCategory(courses: data['courses'] ?? []);
  }
}
