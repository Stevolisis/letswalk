import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:ping/app/app.dart';
import 'package:ping/features/home/widgets/tile.dart';
import 'package:ping/firebase_services/templates.dart';

class StudyPage extends StatefulWidget {
  const StudyPage({super.key});

  @override
  State<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  final courseKey = GlobalKey<_DropdownState>();
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
                  'What do you want to study?',
                  style: TextStyle(fontSize: 24, color: Color(0xFF1D2028)),
                ),
              ),
              const Gap(16),
              Dropdown(
                key: courseKey,
                hintText: 'Course?',
                onChanged: (_) => setState(() {}),
              ),
              const Gap(16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: courseKey.currentState?.value == null
                      ? null
                      : () {
                          TemplateRepository.uploadStudyStatus(
                            course: courseKey.currentState!.value!,
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
          key: key,
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
          items: state.courses
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
