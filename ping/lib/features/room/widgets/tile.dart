import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({
    super.key,
    required this.message,
    required this.regNo,
  });

  final String message;
  final String regNo;

  @override
  Widget build(BuildContext context) {
    final userRegNo = FirebaseAuth.instance.currentUser!.displayName;
    return Container(
      alignment:
          userRegNo == regNo ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: 200,
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        decoration: BoxDecoration(
          color: const Color(0xFFEDE9E9),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(regNo),
                  Text(message),
                  const Text(
                    '07:90',
                    textAlign: TextAlign.end,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
