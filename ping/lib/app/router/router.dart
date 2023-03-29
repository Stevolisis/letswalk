import 'package:go_router/go_router.dart';
import 'package:ping/app/router/paths.dart';
import 'package:ping/features/auth/login.dart';
import 'package:ping/features/availabilty/availability.dart';
import 'package:ping/features/categories/commute.dart';
import 'package:ping/features/home/home.dart';
import 'package:ping/features/categories/study.dart';
import 'package:ping/features/room/commute_room.dart';
import 'package:ping/features/room/study_room.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: AppPaths.home,
        builder: (context, state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: AppPaths.login,
        builder: (context, state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: AppPaths.availability,
        builder: (context, state) {
          return const AvailabilityPage();
        },
      ),
      GoRoute(
        path: '${AppPaths.commuteRoom}/:from/:to',
        name: AppPaths.commuteRoom,
        builder: (context, state) {
          final from = state.params['from'] as String;
          final to = state.params['to'] as String;
          return CommuteRoomPage(from: from, to: to);
        },
      ),
      GoRoute(
        path: '${AppPaths.studyRoom}/:course',
        name: AppPaths.studyRoom,
        builder: (context, state) {
          final course = state.params['course'] as String;
          return StudyRoomPage(course: course);
        },
      ),
      GoRoute(
        path: AppPaths.commute,
        builder: (context, state) {
          return const CommutePage();
        },
      ),
      GoRoute(
        path: AppPaths.study,
        builder: (context, state) {
          return const StudyPage();
        },
      ),
    ],
  );
}
