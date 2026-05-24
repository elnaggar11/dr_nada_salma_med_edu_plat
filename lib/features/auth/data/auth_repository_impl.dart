import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/exceptions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/local/auth_local_data_source.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/data/auth_remote_data_source_impl.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/academic_degree/academic_degree_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/academic_info/academic_info_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/academic_info/academic_info_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/check/check_otp_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/check/check_otp_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/forgot/forgot_password_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/forgot/forgot_password_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/login/login_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/login/login_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/register/register_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/register/register_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/resend_otp/resend_otp_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/resend_otp/resend_otp_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/reset_password/reset_password_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/reset_password/reset_password_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/specialists/specialist_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/verify/verify_otp_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/verify/verify_otp_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/teacher_registration/subject_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/teacher_registration/teacher_application_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/teacher_registration/teacher_application_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/repositories/auth_repositories.dart';

class AuthRepositoryImpl implements AuthRepositories {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource, this.authLocalDataSource);

  @override
  Future<Either<Failure, RegisterResponse>> register({
    RegisterParams? params,
  }) async {
    try {
      final response = await authRemoteDataSource.register(params: params);
      return Right(response);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnAuthorizedException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnprocessableContentException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, AcademicDegreeResponse>> getAcademicDegrees() async {
    try {
      final response = await authRemoteDataSource.getAcademicDegrees();
      return Right(response);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnAuthorizedException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnprocessableContentException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, SpecialistResponse>> getSpecialists() async {
    try {
      final response = await authRemoteDataSource.getSpecialists();
      return Right(response);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnAuthorizedException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnprocessableContentException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, AcademicInfoResponse>> setAcademicInfo({
    AcademicInfoParams? params,
  }) async {
    try {
      final response = await authRemoteDataSource.setAcademicInfo(
        academicInfoParams: params,
      );
      return Right(response);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnAuthorizedException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnprocessableContentException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, VerifyOtpResponse>> verifyOtp({
    VerifyOtpParams? params,
  }) async {
    try {
      final response = await authRemoteDataSource.verifyOtp(params: params!);
      await authLocalDataSource.cacheUserAccessToken(
        token: response.data!.accessToken,
      );
      return Right(response);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnAuthorizedException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnprocessableContentException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, LoginResponse>> login({LoginParams? params}) async {
    try {
      final response = await authRemoteDataSource.login(params: params!);
      await authLocalDataSource.cacheUserAccessToken(
        token: response.data!.accessToken,
      );
      return Right(response);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnAuthorizedException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnprocessableContentException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, ResetPasswordResponse>> reset({
    ResetPasswordParams? params,
  }) async {
    try {
      final response = await authRemoteDataSource.resetPass(params: params!);
      return Right(response);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnAuthorizedException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnprocessableContentException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, ResendOtpResponse>> resendOtp({
    ResendOtpParams? params,
  }) async {
    try {
      final response = await authRemoteDataSource.resendOtp(params: params!);
      return Right(response);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnAuthorizedException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnprocessableContentException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, ForgotPasswordResponse>> forgotPassword({
    ForgotPasswordParams? params,
  }) async {
    try {
      final response = await authRemoteDataSource.forgotPass(params: params!);
      return Right(response);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnAuthorizedException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnprocessableContentException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, CheckOtpResponse>> checkOtp({
    CheckOtpParams? params,
  }) async {
    try {
      final response = await authRemoteDataSource.checkOtp(params: params!);
      return Right(response);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnAuthorizedException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnprocessableContentException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, SpecialistResponse>> getSpecialties() async {
    try {
      final response = await authRemoteDataSource.getSpecialties();
      return Right(response);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnAuthorizedException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnprocessableContentException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, SubjectResponse>> getSubjects() async {
    try {
      final response = await authRemoteDataSource.getSubjects();
      return Right(response);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnAuthorizedException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnprocessableContentException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, TeacherApplicationResponse>> submitTeacherApplication({
    TeacherApplicationParams? params,
  }) async {
    try {
      final response = await authRemoteDataSource.submitTeacherApplication(
        params: params,
      );
      return Right(response);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnAuthorizedException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnprocessableContentException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }
}
