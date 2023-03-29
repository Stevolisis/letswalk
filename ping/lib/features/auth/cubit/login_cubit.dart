import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ping/firebase_services/auth.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  LoginCubit() : super(LoginCubitInitial());

  Future login({required String regNo, required String password}) async {
    emit(LoginLoading());
    await AuthenticationRepository.login(regNo, password);
    emit(LoginSuccessful());
  }

  Future logout() async {
    AuthenticationRepository.logOut();
  }
}
