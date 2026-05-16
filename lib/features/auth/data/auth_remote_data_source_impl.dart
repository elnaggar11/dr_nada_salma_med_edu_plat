import 'package:dr_nada_salma_med_edu_plat/core/errors/exceptions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/api_base_helper.dart';
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

const registerApi = "/auth/register";
const specialistsApi = "/auth/specialties";
const academicDegreeApi = "/auth/academic-degrees";
const academicInfoApi = "/auth/academic-info";
const verifyApi = "/auth/verify-otp";
const loginApi = "/auth/login";
const resetPasswordApi = "/auth/reset-password";
const resendOtpApi = "/auth/resend-otp";
const forgotPasswordApi = "/auth/forget-password";
const checkOtpApi = "/auth/check-code";

abstract class AuthRemoteDataSource {
  Future<RegisterResponse>register({RegisterParams? params});
  Future<SpecialistResponse>getSpecialists();
  Future<AcademicDegreeResponse>getAcademicDegrees();
  Future<AcademicInfoResponse>setAcademicInfo({AcademicInfoParams? academicInfoParams});
  Future<VerifyOtpResponse>verifyOtp({VerifyOtpParams params});
  Future<LoginResponse>login({LoginParams params});
  Future<ResetPasswordResponse>resetPass({ResetPasswordParams params});
  Future<ResendOtpResponse>resendOtp({ResendOtpParams params});
  Future<ForgotPasswordResponse>forgotPass({ForgotPasswordParams params});
  Future<CheckOtpResponse>checkOtp({CheckOtpParams params});

}
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiBaseHelper helper;

  AuthRemoteDataSourceImpl(this.helper);

  @override
  Future<RegisterResponse> register({RegisterParams? params}) async{
    try{
      final response = await helper.post(url: registerApi, body: params!.toMap());
      return RegisterResponse.fromJson(response);
    }on ServerException catch(e){
      throw ServerException(message: e.message);
    }on UnAuthorizedException catch(e){
      throw UnAuthorizedException(message: e.message);
    }on UnprocessableContentException catch(e){
      throw UnprocessableContentException(message: e.message);
    }on ForbiddenException catch(e){
      throw ForbiddenException(message: e.message);
    }
  }

  @override
  Future<AcademicDegreeResponse> getAcademicDegrees() async{
    try{
      final response = await helper.get(url: academicDegreeApi,);
      return AcademicDegreeResponse.fromJson(response);
    }on ServerException catch(e){
      throw ServerException(message: e.message);
    }on UnAuthorizedException catch(e){
      throw UnAuthorizedException(message: e.message);
    }on UnprocessableContentException catch(e){
      throw UnprocessableContentException(message: e.message);
    }on ForbiddenException catch(e){
      throw ForbiddenException(message: e.message);
    }
  }

  @override
  Future<SpecialistResponse> getSpecialists() async{
    try{
      final response = await helper.get(url: specialistsApi,);
      return SpecialistResponse.fromJson(response);
    }on ServerException catch(e){
      throw ServerException(message: e.message);
    }on UnAuthorizedException catch(e){
      throw UnAuthorizedException(message: e.message);
    }on UnprocessableContentException catch(e){
      throw UnprocessableContentException(message: e.message);
    }on ForbiddenException catch(e){
      throw ForbiddenException(message: e.message);
    }
  }

  @override
  Future<AcademicInfoResponse> setAcademicInfo({AcademicInfoParams? academicInfoParams}) async{
    try{
      final response = await helper.post(url: academicInfoApi,body: academicInfoParams!.toMap());
      return AcademicInfoResponse.fromJson(response);
    }on ServerException catch(e){
      throw ServerException(message: e.message);
    }on UnAuthorizedException catch(e){
      throw UnAuthorizedException(message: e.message);
    }on UnprocessableContentException catch(e){
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<VerifyOtpResponse> verifyOtp({VerifyOtpParams? params}) async{
    try{
      final response = await helper.post(url: verifyApi,body: params!.toMap());
      return VerifyOtpResponse.fromJson(response);
    }on ServerException catch(e){
      throw ServerException(message: e.message);
    }on UnAuthorizedException catch(e){
      throw UnAuthorizedException(message: e.message);
    }on UnprocessableContentException catch(e){
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<LoginResponse> login({LoginParams? params}) async{
    try{
      final response = await helper.post(url: loginApi,body: params!.toMap());
      return LoginResponse.fromJson(response);
    }on ServerException catch(e){
      throw ServerException(message: e.message);
    }on UnAuthorizedException catch(e){
      throw UnAuthorizedException(message: e.message);
    }on UnprocessableContentException catch(e){
      throw UnprocessableContentException(message: e.message);
    }on ForbiddenException catch(e){
      throw ForbiddenException(message: e.message);
    }
  }

  @override
  Future<ResetPasswordResponse> resetPass({ResetPasswordParams? params}) async{
    try{
      final response = await helper.post(url: resetPasswordApi,body: params!.toMap());
      return ResetPasswordResponse.fromJson(response);
    }on ServerException catch(e){
      throw ServerException(message: e.message);
    }on UnAuthorizedException catch(e){
      throw UnAuthorizedException(message: e.message);
    }on UnprocessableContentException catch(e){
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<ResendOtpResponse> resendOtp({ResendOtpParams? params}) async{
    try{
      final response = await helper.post(url: resendOtpApi,body: params!.toMap());
      return ResendOtpResponse.fromJson(response);
    }on ServerException catch(e){
      throw ServerException(message: e.message);
    }on UnAuthorizedException catch(e){
      throw UnAuthorizedException(message: e.message);
    }on UnprocessableContentException catch(e){
      throw UnprocessableContentException(message: e.message);
    }on ForbiddenException catch(e){
      throw ForbiddenException(message: e.message);
    }
  }

  @override
  Future<ForgotPasswordResponse> forgotPass({ForgotPasswordParams? params}) async{
    try{
      final response = await helper.post(url: forgotPasswordApi,body: params!.toMap());
      return ForgotPasswordResponse.fromJson(response);
    }on ServerException catch(e){
      throw ServerException(message: e.message);
    }on UnAuthorizedException catch(e){
      throw UnAuthorizedException(message: e.message);
    }on UnprocessableContentException catch(e){
      throw UnprocessableContentException(message: e.message);
    }on ForbiddenException catch(e){
      throw ForbiddenException(message: e.message);
    }
  }

  @override
  Future<CheckOtpResponse> checkOtp({CheckOtpParams? params}) async{
    try{
      final response = await helper.post(url: checkOtpApi,body: params!.toMap());
      return CheckOtpResponse.fromJson(response);
    }on ServerException catch(e){
      throw ServerException(message: e.message);
    }on UnAuthorizedException catch(e){
      throw UnAuthorizedException(message: e.message);
    }on UnprocessableContentException catch(e){
      throw UnprocessableContentException(message: e.message);
    }on ForbiddenException catch(e){
      throw ForbiddenException(message: e.message);
    }
  }
}