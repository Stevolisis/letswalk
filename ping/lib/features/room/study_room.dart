import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ping/features/room/widgets/tile.dart';
import 'package:ping/firebase_services/messages.dart';

class StudyRoomPage extends StatefulWidget {
  const StudyRoomPage({
    super.key,
    required this.course,
  });

  final String course;

  @override
  State<StudyRoomPage> createState() => _StudyRoomPageState();
}

class _StudyRoomPageState extends State<StudyRoomPage> {
  Query<dynamic> get query {
    return FirebaseFirestore.instance
        .collection('chats')
        .where('type', isEqualTo: 'study-based')
        .where('course', isEqualTo: widget.course);
  }

  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: FirestoreListView(
              query: query,
              itemBuilder: (context, snapshot) {
                final data = snapshot.data();
                return MessageTile(
                  message: data['message'],
                  regNo: data['senderRegNo'],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    decoration: const InputDecoration(
                      filled: true,
                      isCollapsed: true,
                      fillColor: Colors.grey,
                      hintText: 'Send a message',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    MessageRepository.sendStudyMessage(
                      course: widget.course,
                      message: controller.text,
                    );

                    controller.clear();
                  },
                  icon: const Icon(Icons.send),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
