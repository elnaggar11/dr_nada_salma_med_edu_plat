import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/delete_account_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/log_out_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/profile_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/settings_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/update_profile_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/update_profile_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/usecases/delete_account_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/usecases/log_out_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/usecases/profile_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/usecases/settings_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/usecases/update_profile_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/injection_container/injection_container.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart' as UL;

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
    this.profileUseCase,
    this.updateProfileUseCase,
    this.settingsUseCase,
    this.logOutUseCase,
    this.deleteAccountUseCase,
  ) : super(ProfileInitial());
  final ProfileUseCase profileUseCase;
  bool? loading = false;
  bool? error = false;
  bool? success = false;
  ProfileResponse? profileResponse;

  final UpdateProfileUseCase updateProfileUseCase;
  final SettingsUseCase settingsUseCase;
  final LogOutUseCase logOutUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;
  bool? deleteLoading = false;
  bool? deleteError = false;
  bool? deleteSuccess = false;

  bool? profileLoading = false;
  bool? profileError = false;
  bool? profileSuccess = false;
  File? img;
  bool visibility = false;

  bool? settingsLoading = false;
  bool? settingsError = false;
  bool? settingsSuccess = false;
  SettingsResponse? settingsResponse;

  bool? logLoading = false;
  bool? logError = false;
  bool? logSuccess = false;

  @override
  Future<void> close() {
    return super.close();
  }

  Future<void> getProfile() async {
    loading = true;
    error = false;
    success = false;
    emit(ProfileLoadingState());
    try {
      final failOrUser = await profileUseCase(NoParams());
      failOrUser.fold(
        (fail) {
          if (fail is ServerFailure) {
            loading = false;
            error = true;
            success = false;
            /*  msgKey.currentState!.showSnackBar(SnackBar(content: Text(fail.message
            ,style: TextStyles.textStyleNormal13.copyWith(color: white)
            ,textScaler: TextScaler.linear(1),)));*/
            emit(ProfileErrorState(message: fail.message));
          }
        },
        (response) {
          loading = false;
          error = false;
          success = true;
          profileResponse = response;
          print('fullName :${response.data!.fullName}');
          emit(ProfileSuccessState(profileResponse: response));
        },
      );
    } catch (e) {
      loading = false;
      error = true;
      success = false;
    }
  }

  Future<void> updateProfile({UpdateProfileParams? params}) async {
    loading = true;
    error = false;
    success = false;
    emit(UpdateProfileLoadingState());
    try {
      final failOrUser = await updateProfileUseCase(params!);
      failOrUser.fold(
        (fail) {
          if (fail is ServerFailure) {
            loading = false;
            error = true;
            success = false;
            msgKey.currentState!.showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(
                  fail.message,
                  style: TextStyles.textStyleNormal13.copyWith(color: white),
                  textScaler: TextScaler.linear(1),
                ),
              ),
            );
            emit(UpdateProfileErrorState(message: fail.message));
          }
        },
        (response) {
          getProfile();
          loading = false;
          error = false;
          success = true;
          msgKey.currentState!.showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(
                response.message!,
                style: TextStyles.textStyleNormal13.copyWith(color: white),
                textScaler: TextScaler.linear(1),
              ),
            ),
          );
          emit(UpdateProfileSuccessState(updateProfileResponse: response));
        },
      );
    } catch (e) {
      loading = false;
      error = true;
      success = false;
      msgKey.currentState!.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            e.toString(),
            style: TextStyles.textStyleNormal13.copyWith(color: white),
            textScaler: TextScaler.linear(1),
          ),
        ),
      );
      emit(UpdateProfileErrorState(message: e.toString()));
    }
  }

  Future<void> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      img = imageTemporary;
      emit(UpdateProfileImage());
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  Future<void> updateVisibility({bool? visible}) async {
    visibility = !visible!;
    emit(UpdatePasswordVisibility());
  }

  Future<void> getSettings() async {
    settingsLoading = true;
    settingsError = false;
    settingsSuccess = false;

    emit(SettingsLoadingState());
    try {
      final failOrUser = await settingsUseCase(NoParams());
      failOrUser.fold(
        (fail) {
          if (fail is ServerFailure) {
            settingsLoading = false;
            settingsError = true;
            settingsSuccess = false;
            emit(SettingsErrorState(message: fail.message));
          }
        },
        (response) {
          settingsLoading = false;
          settingsError = false;
          settingsSuccess = true;
          settingsResponse = response;
          emit(SettingsSuccess(settingsResponse: response));
        },
      );
    } catch (e) {
      settingsLoading = false;
      settingsError = true;
      settingsSuccess = false;
      emit(SettingsErrorState(message: e.toString()));
    }
  }

  Future<void> logOut() async {
    logLoading = true;
    logError = false;
    logSuccess = false;
    emit(LogOutLoading());
    try {
      final failOrUser = await logOutUseCase(NoParams());
      failOrUser.fold(
        (fail) {
          if (fail is ServerFailure) {
            logLoading = false;
            logError = true;
            logSuccess = false;
            msgKey.currentState!.showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(
                  fail.message,
                  style: TextStyles.textStyleNormal13.copyWith(color: white),
                  textScaler: TextScaler.linear(1),
                ),
              ),
            );
            emit(LogOutErrorState(message: fail.message));
          }
        },
        (response) {
          logLoading = false;
          logError = false;
          logSuccess = true;
          msgKey.currentState!.showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(
                response.message!,
                style: TextStyles.textStyleNormal13.copyWith(color: white),
                textScaler: TextScaler.linear(1),
              ),
            ),
          );
          sharedPreferences.remove("saveUser");
          sharedPreferences.remove("cache_token");
          sharedPreferences.remove("isTeacher");
          Const.isTeacher = false;
          navKey.currentContext!.pushNamedAndRemoveUntil(name: splash);
          emit(LogOutSuccess(logOutResponse: response));
        },
      );
    } catch (e) {
      logLoading = false;
      logError = true;
      logSuccess = false;
      emit(LogOutErrorState(message: e.toString()));
    }
  }

  Future<void> deleteAccount() async {
    deleteLoading = true;
    deleteError = false;
    deleteSuccess = false;
    emit(LogOutLoading());
    try {
      final failOrUser = await deleteAccountUseCase(NoParams());
      failOrUser.fold(
        (fail) {
          if (fail is ServerFailure) {
            deleteLoading = false;
            deleteError = true;
            deleteSuccess = false;
            msgKey.currentState!.showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(
                  fail.message,
                  style: TextStyles.textStyleNormal13.copyWith(color: white),
                  textScaler: TextScaler.linear(1),
                ),
              ),
            );
            emit(LogOutErrorState(message: fail.message));
          }
        },
        (response) {
          deleteLoading = false;
          deleteError = false;
          deleteSuccess = true;
          msgKey.currentState!.showSnackBar(
            SnackBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              behavior: SnackBarBehavior.floating,
              content: Text(
                response.message!,
                style: TextStyles.textStyleNormal13.copyWith(color: white),
                textScaler: TextScaler.linear(1),
              ),
            ),
          );
          sharedPreferences.remove("saveUser");
          sharedPreferences.remove("cache_token");
          sharedPreferences.remove("isTeacher");
          Const.isTeacher = false;
          navKey.currentContext!.pushNamedAndRemoveUntil(name: splash);
          emit(DeleteAccountSuccess(deleteAccountResponse: response));
        },
      );
    } catch (e) {
      logLoading = false;
      logError = true;
      logSuccess = false;
      emit(LogOutErrorState(message: e.toString()));
    }
  }

  Future<void> openWhatsapp({
    required BuildContext context,
    required String text,
    required String number,
  }) async {
    var whatsapp = number; //+92xx enter like this
    var whatsappURlAndroid = "whatsapp://send?phone=$whatsapp&text=$text";
    var whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.tryParse(text)}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
        await launchUrl(Uri.parse(whatsappURLIos));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Whatsapp not installed")));
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
        await launchUrl(Uri.parse(whatsappURlAndroid));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Whatsapp not installed")));
      }
    }
  }

  Future<void> sendEmail({
    String? email,
    String subject = "",
    String body = "",
  }) async {
    String mail = "mailto:$email?subject=$subject&body=${Uri.encodeFull(body)}";
    if (await UL.canLaunch(mail)) {
      await UL.launch(mail);
    } else {
      throw Exception("Unable to open the email");
    }
  }
}
