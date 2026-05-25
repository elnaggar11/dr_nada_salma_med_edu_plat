import 'package:dio/dio.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/exceptions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/api_base_helper.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/about_us_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/certificate_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/delete_account_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/faqs_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/log_out_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/points_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/profile_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/settings_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/terms_conditions_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/update_profile_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/update_profile_response.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/const.dart';
import 'dart:convert';

const getProfileApi = "/profile";
const getTeacherProfileApi = "/teacher/profile";
const pointsApi = "/profile/points";
const faqsApi = "/faqs";
const certificatesApi = "/profile/my-certificates";
const aboutUsApi = "/pages/about-us";
const termsConditionsApi = "/pages/terms-and-conditions";
const updateProfileApi = "/profile/update";
const updateTeacherProfileApi = "/teacher/update-profile";
const settingsApi = "/settings";
const logOutApi = "/logout";
const teacherLogOutApi = "/teacher/logout";
const deleteAccountApi = "/delete-account";
const teacherDeleteAccountApi = "/teacher/delete-account";

abstract class ProfileRemoteDataSource {
  Future<ProfileResponse> getProfile();
  Future<PointsResponse> getPoints();
  Future<FaqsResponse> getFaqs();
  Future<CertificateResponse> getCertificates();
  Future<AboutUsResponse> getAboutUs();
  Future<TermsConditionsResponse> getTermsConditions();
  Future<UpdateProfileResponse> updateProfile({UpdateProfileParams? params});
  Future<SettingsResponse> getSiteSettings();
  Future<LogOutResponse> logOut();
  Future<DeleteAccountResponse> deleteAccount();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiBaseHelper helper;

  ProfileRemoteDataSourceImpl(this.helper);

  @override
  Future<ProfileResponse> getProfile() async {
    try {
      final url = Const.isTeacher ? getTeacherProfileApi : getProfileApi;
      final response = await helper.get(url: url);
      print(response.toString());
      return ProfileResponse.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<PointsResponse> getPoints() async {
    try {
      final response = await helper.get(url: pointsApi);
      print(response.toString());
      return PointsResponse.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<FaqsResponse> getFaqs() async {
    try {
      final response = await helper.get(url: faqsApi);
      print(response.toString());
      return FaqsResponse.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<CertificateResponse> getCertificates() async {
    try {
      final response = await helper.get(url: certificatesApi);
      print(response.toString());
      return CertificateResponse.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<AboutUsResponse> getAboutUs() async {
    try {
      final response = await helper.get(url: aboutUsApi);

      return AboutUsResponse.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<TermsConditionsResponse> getTermsConditions() async {
    try {
      final response = await helper.get(url: termsConditionsApi);

      return TermsConditionsResponse.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<UpdateProfileResponse> updateProfile({
    UpdateProfileParams? params,
  }) async {
    try {
      print("password :${params!.password}");
      Map<String, dynamic> body = params.password == null
          ? {
              "full_name": params.fullName,
              "phone_number": params.phoneNumber,
              "country_code": "+966",
              "email": params.email,
              "image": params.img == null
                  ? ""
                  : await MultipartFile.fromFile(params.img!.path),
            }
          : {
              "full_name": params.fullName,
              "phone_number": params.phoneNumber,
              "country_code": "+966",
              "email": params.email,
              "password": params.password,
              "image": params.img == null
                  ? ""
                  : await MultipartFile.fromFile(params.img!.path),
            };

      if (Const.isTeacher) {
        body.addAll({
          if (params.specializationTitle != null)
            "specialization_title": params.specializationTitle,
          if (params.country != null) "country": params.country,
          if (params.city != null) "city": params.city,
          if (params.languages != null) "languages": params.languages,
          if (params.studentsCount != null)
            "students_count": params.studentsCount,
          if (params.yearsExperience != null)
            "years_experience": params.yearsExperience,
          if (params.shortBio != null) "short_bio": params.shortBio,
          if (params.about != null) "about": params.about,
          if (params.targetStudents != null)
            "target_students": params.targetStudents,
          if (params.teachingExperience != null)
            "teaching_experience": params.teachingExperience,
          if (params.introVideoUrl != null)
            "intro_video_url": params.introVideoUrl,
          if (params.subjects != null) "subjects": jsonEncode(params.subjects),
          if (params.timeSlots != null)
            "time_slots": jsonEncode(params.timeSlots),
          if (params.removeTimeSlotIds != null)
            "remove_time_slot_ids": jsonEncode(params.removeTimeSlotIds),
        });
      }

      final url = Const.isTeacher ? updateTeacherProfileApi : updateProfileApi;
      final response = await helper.post(url: url, body: body);

      return UpdateProfileResponse.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    } on ForbiddenException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<SettingsResponse> getSiteSettings() async {
    try {
      final response = await helper.get(url: settingsApi);

      return SettingsResponse.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<LogOutResponse> logOut() async {
    try {
      final url = Const.isTeacher ? teacherLogOutApi : logOutApi;
      final response = await helper.postJson(url: url, body: {});

      return LogOutResponse.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<DeleteAccountResponse> deleteAccount() async {
    try {
      final url = Const.isTeacher ? teacherDeleteAccountApi : deleteAccountApi;
      final response = await helper.delete(url: url);

      return DeleteAccountResponse.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }
}
