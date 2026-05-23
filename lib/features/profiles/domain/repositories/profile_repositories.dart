import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
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

abstract class ProfileRepositories {
  Future<Either<Failure, ProfileResponse>> getProfile();
  Future<Either<Failure, PointsResponse>> getPoints();
  Future<Either<Failure, FaqsResponse>> getFaqs();
  Future<Either<Failure, CertificateResponse>> getCertificates();
  Future<Either<Failure, AboutUsResponse>> getAboutUs();
  Future<Either<Failure, TermsConditionsResponse>> getTermsConditions();
  Future<Either<Failure, UpdateProfileResponse>> updateProfile({
    UpdateProfileParams params,
  });
  Future<Either<Failure, SettingsResponse>> getSettings();
  Future<Either<Failure, LogOutResponse>> logOut();
  Future<Either<Failure, DeleteAccountResponse>> deleteAccount();
}
