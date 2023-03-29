part of 'login_cubit.dart';

@immutable
abstract class LoginCubitState {}

class LoginCubitInitial extends LoginCubitState {}

class LoginLoading extends LoginCubitState {}

class LoginSuccessful extends LoginCubitState {}

enum Errors { invalid }

class RegNo extends FormzInput<String, Error> {
  const RegNo.pure() : super.pure('');

  const RegNo.dirty([super.value = '']) : super.dirty();

  static final RegExp regNoRegEx = RegExp(r'');

  @override
  validator(value) {
    throw UnimplementedError();
  }
}

class Password extends FormzInput<String, Error> {
  const Password.pure() : super.pure('');

  const Password.dirty([super.value = '']) : super.dirty();

  static final RegExp regNoRegEx = RegExp(r'');

  @override
  validator(value) {
    throw UnimplementedError();
  }
}
