import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ping/app/router/paths.dart';
import 'package:ping/features/home/widgets/status.dart';

class StatusTab extends ConsumerWidget {
  const StatusTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser?.displayName ?? '';
    final query = FirebaseFirestore.instance
        .collection('statuses')
        .where('user', isEqualTo: user);

    return FirestoreListView(
      query: query,
      padding: const EdgeInsets.only(top: 10),
      itemBuilder: (context, snapshot) {
        final data = (snapshot.data());
        if (data['type'] == 'location-based') {
          return LocationStatusTile(
            from: data['from'],
            to: data['to'],
            onTap: () {
              context.pushNamed(AppPaths.commuteRoom,
                  params: {'from': data['from'], 'to': data['to']});
            },
          );
        }
        if (data['type'] == 'study-based') {
          return StudyStatusTile(
            course: data['course'],
            onTap: () {
              context.pushNamed(AppPaths.studyRoom,
                  params: {'course': data['course']});
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
