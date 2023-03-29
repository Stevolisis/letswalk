import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:ping/app/app.dart';
import 'package:ping/features/home/widgets/tile.dart';
import 'package:ping/firebase_services/templates.dart';

class CommutePage extends ConsumerStatefulWidget {
  const CommutePage({super.key});

  @override
  ConsumerState<CommutePage> createState() => _CommutePageState();
}

class _CommutePageState extends ConsumerState<CommutePage> {
  String from = '';
  String to = '';

  onFromChange(String? value) {
    if (value != null) {
      setState(() {
        from = value;
      });
    }
  }

  onToChange(String? value) {
    if (value != null) {
      setState(() {
        to = value;
      });
    }
  }

  final fromKey = GlobalKey<_DropdownState>();
  final toKey = GlobalKey<_DropdownState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(36),
              SvgPicture.asset(
                'assets/svg/logo.svg',
                semanticsLabel: 'Acme Logo',
              ),
              const Gap(28),
              const CategoryTile(title: 'Set a course'),
              const Gap(48),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'What do you want to do?',
                  style: TextStyle(fontSize: 24, color: Color(0xFF1D2028)),
                ),
              ),
              const Gap(16),
              Dropdown(
                key: fromKey,
                hintText: 'From?',
                onChanged: (_) => setState(() {}),
              ),
              const Gap(16),
              Dropdown(
                key: toKey,
                hintText: 'To?',
                onChanged: (_) => setState(() {}),
              ),
              const Gap(24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: fromKey.currentState?.value == null ||
                          toKey.currentState?.value == null
                      ? null
                      : () {
                          final from = fromKey.currentState!.value;
                          final to = toKey.currentState!.value;
                          TemplateRepository.uploadLocationStatus(
                            from: from!,
                            to: to!,
                          );
                        },
                  child: const Text('Upload'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Dropdown extends StatefulWidget {
  const Dropdown({
    Key? key,
    this.onChanged,
    required this.hintText,
  }) : super(key: key);
  final String hintText;
  final void Function(String?)? onChanged;

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  final key = GlobalKey<FormFieldState>();
  String? get value => key.currentState?.value;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return DropdownButtonFormField(
          decoration: InputDecoration(
            hintText: widget.hintText,
            filled: true,
            suffixIconConstraints:
                const BoxConstraints(maxHeight: 36, minHeight: 36),
            constraints: const BoxConstraints(maxHeight: 36, minHeight: 36),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          items: state.locations
              .map((loc) => DropdownMenuItem(
                    value: loc,
                    child: Text(loc),
                  ))
              .toList(),
          onChanged: widget.onChanged,
        );
      },
    );
  }
}

final locationProvider = FutureProvider<List<String>?>((_) async {
  final locations = <String>[];
  try {
    final instance = FirebaseFirestore.instance;

    final snapshot = await instance
        .collection('template')
        .where('type', isEqualTo: 'location-based')
        .get();

    // for (final doc in snapshot.docs) {
    //   final data = doc.data() as String;
    //   locations.add(data);
    // }
  } on FirebaseException catch (e) {
    log(e.toString());
    rethrow;
  }
  return null;
});
