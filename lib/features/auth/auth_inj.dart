import 'package:dr_nada_salma_med_edu_plat/core/local/auth_local_data_source.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/data/auth_remote_data_source_impl.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/data/auth_repository_impl.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/repositories/auth_repositories.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/usecases/academic_degree_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/usecases/academic_info_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/usecases/check_otp_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/usecases/forgot_password_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/usecases/login_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/usecases/register_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/usecases/resend_otp_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/usecases/reset_password_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/usecases/specialist_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/usecases/verify_otp_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/academic_degree/academic_degree_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/academic_info/academic_info_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/check_otp/check_otp_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/forgot/forgot_password_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/register/register_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/resend_otp/resend_otp_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/reset/reset_pass_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/specialists/specialists_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/verify/verify_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/usecases/get_specialties_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/usecases/get_subjects_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/usecases/submit_teacher_application_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/teacher_registration/teacher_registration_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void> authInj(GetIt s) async {
  s.registerFactory(() => RegisterCubit(s()));
  s.registerFactory(() => SpecialistsCubit(s()));
  s.registerFactory(() => AcademicDegreeCubit(s()));
  s.registerFactory(() => AcademicInfoCubit(s()));
  s.registerFactory(() => VerifyCubit(s()));
  s.registerFactory(() => LoginCubit(s()));
  s.registerFactory(() => ResetPassCubit(s()));
  s.registerFactory(() => ForgotPasswordCubit(s()));
  s.registerFactory(() => ResendOtpCubit(s()));
  s.registerFactory(() => CheckOtpCubit(s()));
  s.registerFactory(
    () => TeacherRegistrationCubit(
      getSpecialtiesUseCase: s(),
      getSubjectsUseCase: s(),
      submitTeacherApplicationUseCase: s(),
    ),
  );

  s.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(s()),
  );
  s.registerLazySingleton<AuthRepositories>(() => AuthRepositoryImpl(s(), s()));
  s.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(s()),
  );
  s.registerLazySingleton(() => RegisterUseCase(s()));
  s.registerLazySingleton(() => SpecialistUseCase(s()));
  s.registerLazySingleton(() => AcademicDegreeUseCase(s()));
  s.registerLazySingleton(() => AcademicInfoUseCase(s()));
  s.registerLazySingleton(() => VerifyOtpUseCase(s()));
  s.registerLazySingleton(() => LoginUseCase(s()));
  s.registerLazySingleton(() => ResetPasswordUseCase(s()));
  s.registerLazySingleton(() => ResendOtpUseCase(s()));
  s.registerLazySingleton(() => ForgotPasswordUseCase(s()));
  s.registerLazySingleton(() => CheckOtpUseCase(s()));
  s.registerLazySingleton(() => GetSpecialtiesUseCase(s()));
  s.registerLazySingleton(() => GetSubjectsUseCase(s()));
  s.registerLazySingleton(() => SubmitTeacherApplicationUseCase(s()));
}
