part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class UpdateLoginState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState({required this.message});
}

class LoginSuccessState extends LoginState {
  final LoginResponse loginResponse;

  LoginSuccessState({required this.loginResponse});
}

class UpdateLoginVisibility extends LoginState {}

class UpdateCheckedState extends LoginState {}
