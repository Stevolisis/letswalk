part of 'app_cubit.dart';

class AppState {
  const AppState({
    required this.locations,
    required this.courses,
    required this.loading,
  });

  final List<String> locations;
  final List<String> courses;
  final bool loading;

  bool get isEmpty => (locations.isEmpty || courses.isEmpty);

  AppState copyWith({
    List<String>? locations,
    List<String>? courses,
    bool? loading,
  }) {
    return AppState(
      courses: courses ?? this.courses,
      loading: loading ?? this.loading,
      locations: locations ?? this.locations,
    );
  }
}

class AppInitial extends AppState {
  const AppInitial()
      : super(courses: const [], loading: false, locations: const []);
}
