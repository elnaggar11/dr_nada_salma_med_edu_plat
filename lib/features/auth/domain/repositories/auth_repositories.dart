import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
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

abstract class AuthRepositories {
  Future<Either<Failure,RegisterResponse>>register({RegisterParams params});
  Future<Either<Failure,SpecialistResponse>>getSpecialists();
  Future<Either<Failure,AcademicDegreeResponse>>getAcademicDegrees();
  Future<Either<Failure,AcademicInfoResponse>>setAcademicInfo({AcademicInfoParams params});
  Future<Either<Failure,VerifyOtpResponse>>verifyOtp({VerifyOtpParams params});
  Future<Either<Failure,LoginResponse>>login({LoginParams params});
  Future<Either<Failure,ResetPasswordResponse>>reset({ResetPasswordParams params});
  Future<Either<Failure,ResendOtpResponse>>resendOtp({ResendOtpParams params});
  Future<Either<Failure,ForgotPasswordResponse>>forgotPassword({ForgotPasswordParams params});
  Future<Either<Failure,CheckOtpResponse>>checkOtp({CheckOtpParams params});
  Future<Either<Failure,SpecialistResponse>>getSpecialties();
  Future<Either<Failure,SubjectResponse>>getSubjects();
  Future<Either<Failure,TeacherApplicationResponse>>submitTeacherApplication({TeacherApplicationParams params});
}