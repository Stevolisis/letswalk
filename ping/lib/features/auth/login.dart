import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ping/features/auth/cubit/login_cubit.dart';
import 'package:ping/features/auth/pod.dart';
import 'package:ping/firebase_services/auth.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Align(
          alignment: const Alignment(0, -1 / 2),
          child: BlocProvider(
            create: (context) => LoginCubit(),
            child: const LoginForm(),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final regNo = ref.watch(regNoProvider);
    final password = ref.watch(passwordProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/svg/logo.svg',
          semanticsLabel: 'Acme Logo',
        ),
        const SizedBox(height: 10),
        const RegsitrationNumberInput(),
        const SizedBox(height: 10),
        const PasswordInput(),
        const SizedBox(height: 10),
        const Align(
          alignment: Alignment.centerRight,
          child: Text('Forgot password?'),
        ),
        const SizedBox(height: 26),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              AuthenticationRepository.login(regNo, password);
            },
            child: const Text('Log in'),
          ),
        ),
      ],
    );
  }
}

class RegsitrationNumberInput extends ConsumerWidget {
  const RegsitrationNumberInput({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(regNoProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Registration No.', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        TextFormField(
          initialValue: data,
          onChanged: ref.read(regNoProvider.notifier).onChanged,
        ),
      ],
    );
  }
}

class PasswordInput extends ConsumerWidget {
  const PasswordInput({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(passwordProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Password', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        TextFormField(
          initialValue: data,
          onChanged: ref.read(passwordProvider.notifier).onChanged,
        ),
      ],
    );
  }
}
