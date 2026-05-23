import 'package:dr_nada_salma_med_edu_plat/features/profiles/data/profile_remote_data_source_impl.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/data/profile_repository_impl.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/repositories/profile_repositories.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/usecases/about_us_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/usecases/certificate_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/usecases/delete_account_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/usecases/faqs_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/usecases/log_out_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/usecases/points_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/usecases/profile_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/usecases/settings_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/usecases/terms_conditions_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/usecases/update_profile_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/about_us_cubit/about_us_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/certificates/certificates_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/frequently_cubit/frequently_asked_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/lang/language_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/points/points_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/profile/profile_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/terms_cubit/terms_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void> initProfileInj(GetIt s) async {
  s.registerFactory(() => ProfileCubit(s(), s(), s(), s(), s()));
  s.registerFactory(() => PointsCubit(s()));
  s.registerFactory(() => AboutUsCubit(s()));
  s.registerFactory(() => LanguageCubit());
  s.registerFactory(() => TermsCubit(s()));
  s.registerFactory(() => CertificatesCubit(s()));
  s.registerFactory(() => FrequentlyAskedCubit(s()));

  s.registerLazySingleton(() => UpdateProfileUseCase(s()));
  s.registerLazySingleton(() => LogOutUseCase(s()));
  s.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(s()),
  );
  s.registerLazySingleton<ProfileRepositories>(
    () => ProfileRepositoryImpl(s()),
  );
  s.registerLazySingleton(() => SettingsUseCase(s()));
  s.registerLazySingleton(() => ProfileUseCase(s()));
  s.registerLazySingleton(() => PointsUseCase(s()));
  s.registerLazySingleton(() => FaqsUseCase(s()));
  s.registerLazySingleton(() => CertificateUseCase(s()));
  s.registerLazySingleton(() => AboutUsUseCase(s()));
  s.registerLazySingleton(() => TermsConditionsUseCase(s()));
  s.registerLazySingleton(() => DeleteAccountUseCase(s()));
}
