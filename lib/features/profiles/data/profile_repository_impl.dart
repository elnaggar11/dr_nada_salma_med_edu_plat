import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/exceptions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/data/profile_remote_data_source_impl.dart';
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
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/repositories/profile_repositories.dart';

class ProfileRepositoryImpl implements ProfileRepositories {
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepositoryImpl(this.profileRemoteDataSource);

  @override
  Future<Either<Failure, ProfileResponse>> getProfile() async{
    try{
      final response = await profileRemoteDataSource.getProfile();
      return Right(response);
    }on ServerException catch(e){
      return left(ServerFailure(message: e.message));
    }on UnAuthorizedException catch(e){
      return left(ServerFailure(message: e.message));
    }on UnprocessableContentException catch(e){
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, PointsResponse>> getPoints() async{
    try{
      final response = await profileRemoteDataSource.getPoints();
      return Right(response);
    }on ServerException catch(e){
      return left(ServerFailure(message: e.message));
    }on UnAuthorizedException catch(e){
      return left(ServerFailure(message: e.message));
    }on UnprocessableContentException catch(e){
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, FaqsResponse>> getFaqs()async {
    try{
      final response = await profileRemoteDataSource.getFaqs();
      return Right(response);
    }on ServerException catch(e){
      return left(ServerFailure(message: e.message));
    }on UnAuthorizedException catch(e){
      return left(ServerFailure(message: e.message));
    }on UnprocessableContentException catch(e){
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, CertificateResponse>> getCertificates() async{
    try{
      final response = await profileRemoteDataSource.getCertificates();
      return Right(response);
    }on ServerException catch(e){
      return left(ServerFailure(message: e.message));
    }on UnAuthorizedException catch(e){
      return left(ServerFailure(message: e.message));
    }on UnprocessableContentException catch(e){
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, AboutUsResponse>> getAboutUs() async{
    try{
      final response = await profileRemoteDataSource.getAboutUs();
      return Right(response);
    }on ServerException catch(e){
      return left(ServerFailure(message: e.message));
    }on UnAuthorizedException catch(e){
      return left(ServerFailure(message: e.message));
    }on UnprocessableContentException catch(e){
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, TermsConditionsResponse>> getTermsConditions()async {
    try{
      final response = await profileRemoteDataSource.getTermsConditions();
      return Right(response);
    }on ServerException catch(e){
      return left(ServerFailure(message: e.message));
    }on UnAuthorizedException catch(e){
      return left(ServerFailure(message: e.message));
    }on UnprocessableContentException catch(e){
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UpdateProfileResponse>> updateProfile({UpdateProfileParams? params}) async{
    try{
      final response = await profileRemoteDataSource.updateProfile(params: params);
      return Right(response);
    }on ServerException catch(e){
      return left(ServerFailure(message: e.message));
    }on UnAuthorizedException catch(e){
      return left(ServerFailure(message: e.message));
    }on UnprocessableContentException catch(e){
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, SettingsResponse>> getSettings() async{
    try{
      final response = await profileRemoteDataSource.getSiteSettings();
      return Right(response);
    }on ServerException catch(e){
      return left(ServerFailure(message: e.message));
    }on UnAuthorizedException catch(e){
      return left(ServerFailure(message: e.message));
    }on UnprocessableContentException catch(e){
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, LogOutResponse>> logOut() async{
    try{
      final response = await profileRemoteDataSource.logOut();
      return Right(response);
    }on ServerException catch(e){
      return left(ServerFailure(message: e.message));
    }on UnAuthorizedException catch(e){
      return left(ServerFailure(message: e.message));
    }on UnprocessableContentException catch(e){
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, DeleteAccountResponse>> deleteAccount() async{
    try{
      final response = await profileRemoteDataSource.deleteAccount();
      return Right(response);
    }on ServerException catch(e){
      return left(ServerFailure(message: e.message));
    }on UnAuthorizedException catch(e){
      return left(ServerFailure(message: e.message));
    }on UnprocessableContentException catch(e){
      return left(ServerFailure(message: e.message));
    }
  }

}