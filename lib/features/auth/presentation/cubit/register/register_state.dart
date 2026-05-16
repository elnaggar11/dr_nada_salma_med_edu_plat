part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}


class UpdateRegisterState extends RegisterState {}


class UpdateCheckBoxState extends RegisterState {}

class UpdateExpandableState extends RegisterState {}

class UpdateSecondExpandableState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final String msg;

  RegisterErrorState({required this.msg});
}
class RegisterSuccessState extends RegisterState {
  final RegisterResponse response;

  RegisterSuccessState({required this.response});
}

class UpdateVisibilityState extends RegisterState {}

class UpdateConfirmationPasswordVisibilityState extends RegisterState {}

class TermsCheckedState extends RegisterState {}