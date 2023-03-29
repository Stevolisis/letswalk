import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ping/firebase_services/templates.dart';
// import 'package:ping_repos/ping_repos.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppInitial()) {
    loadTemplateData();
  }

  Future<void> loadTemplateData() async {
    emit(state.copyWith(loading: true));

    log('here first');
    final locations = await TemplateRepository.loadLocations();
    final courses = await TemplateRepository.loadCourses();

    print(locations);

    emit(state.copyWith(
      loading: false,
      locations: locations,
      courses: courses,
    ));
    log('here');
  }
}
