import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'dart:math' as math;

import 'package:ping/features/home/widgets/tile.dart';

class CategoriesTab extends ConsumerWidget {
  const CategoriesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final e = ref.watch(p);

    return e.when(
      data: (data) {
        return CustomScrollView(
          slivers: [
            const SliverGap(40),
            const SliverToBoxAdapter(
              child: Text(
                'What do you want to do?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, color: Color(0xFF1D2028)),
              ),
            ),
            const SliverGap(16),
            SliverToBoxAdapter(
              child: CategoryTile(
                title: 'commute',
                onTap: () {
                  GoRouter.of(context).push('/commute', extra: 'course-based');
                },
              ),
            ),
            const SliverGap(16),
            SliverToBoxAdapter(
              child: CategoryTile(
                title: 'study',
                onTap: () {
                  GoRouter.of(context).push('/study', extra: 'location-based');
                },
              ),
            ),
          ],
        );
      },
      error: (_, __) {
        return const Placeholder();
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      },
    );
  }

  static int _computeActualChildCount(int itemCount) {
    return math.max(0, itemCount * 2 - 1);
  }
}

class Category {
  const Category(this.name, this.type);
  final String name;
  final String type;
}

final p = FutureProvider<List<Category>?>((ref) async {
  final categories = <Category>[];
  try {
    final instance = FirebaseFirestore.instance;
    final snapshot = await instance.collection('template').get();
    for (final doc in snapshot.docs) {
      final name = doc.get('name');
      final type = doc.get('type');
      categories.add(Category(name, type));
    }
    return categories;
  } catch (e) {
    log(e.toString());
    rethrow;
  }
});

Future loadCategories() async {}
