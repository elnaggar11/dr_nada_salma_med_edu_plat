part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  final String message;

  ProfileErrorState({required this.message});
}
class ProfileSuccessState extends ProfileState {
  final ProfileResponse profileResponse;

  ProfileSuccessState({required this.profileResponse});
}

class UpdateProfileLoadingState extends ProfileState {}

class UpdateProfileErrorState extends ProfileState {
  final String message;

  UpdateProfileErrorState({required this.message});
}
class UpdateProfileSuccessState extends ProfileState {
  final UpdateProfileResponse updateProfileResponse;

  UpdateProfileSuccessState({required this.updateProfileResponse});
}
class UpdateProfileImage extends ProfileState {}


class UpdatePasswordVisibility extends ProfileState {}


class SettingsLoadingState extends ProfileState {}

class SettingsErrorState extends ProfileState {
  final String message;

  SettingsErrorState({required this.message});
}
class SettingsSuccess extends ProfileState {
  final SettingsResponse settingsResponse;

  SettingsSuccess({required this.settingsResponse});
}
class LogOutLoading extends ProfileState {}

class LogOutErrorState extends ProfileState {
  final String message;

  LogOutErrorState({required this.message});
}
class LogOutSuccess extends ProfileState {
  final LogOutResponse logOutResponse;

  LogOutSuccess({required this.logOutResponse});
}
class DeleteAccountSuccess extends ProfileState{
  final DeleteAccountResponse deleteAccountResponse;

  DeleteAccountSuccess({required this.deleteAccountResponse});
}