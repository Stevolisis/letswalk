import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ping/touchables.dart';

class LocationStatusTile extends StatelessWidget {
  const LocationStatusTile({
    super.key,
    this.onTap,
    required this.from,
    required this.to,
  });

  final String from;
  final String to;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'From: $from',
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(),
                const Text(
                  'Time 00:20',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'To: $to',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                // Text(
                //   '10 people already in this room',
                //   style: TextStyle(
                //     color: const Color(0xFF7B7E7E).withOpacity(0.57),
                //     fontSize: 16,
                //   ),
                // ),
                const Spacer(),
                ElevatedButton(
                  onPressed: onTap,
                  child: const Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class StudyStatusTile extends StatelessWidget {
  const StudyStatusTile({
    super.key,
    this.onTap,
    required this.course,
  });

  final String course;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Course: $course',
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(),
                const Text(
                  'Time 00:20',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const Gap(30),
            Row(
              children: [
                Text(
                  '10 people already in this room',
                  style: TextStyle(
                    color: const Color(0xFF7B7E7E).withOpacity(0.57),
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: onTap,
                  child: const Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
