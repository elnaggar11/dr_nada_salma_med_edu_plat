import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/screens/teachers_list_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/academic_info/academic_info_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/check/check_otp_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/verify/verify_otp_params.dart';
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
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/screens/forgot_pass/forgot_password_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/screens/login/login_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/screens/register/register_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/screens/register/second_register_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/screens/register/terms_conditions_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/screens/reset/reset_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/screens/verify/verification_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/entities/blog_details/blog_details_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/presentation/cubit/blog_details_cubit/blog_details_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/presentation/cubit/category_with_blog/category_with_blog_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/presentation/screens/blog_details.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/presentation/screens/blog_screens.dart';
import 'package:dr_nada_salma_med_edu_plat/features/bottom_bar/presentation/cubit/bottom_bar_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/bottom_bar/presentation/screens/bottom_bar_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/certificates/presentation/screen/certificate_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/cubit/categories/categories_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/cubit/course_reviews/course_reviews_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/cubit/courses_status_cubit/courses_status_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/cubit/teacher_detail/teacher_detail_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/screens/teacher_detail_view.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/my_courses.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/screens/private_lessons_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/presentation/cubit/favourite_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/presentation/screens/favourite_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_details_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/hero/heroes_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/private_lessons_cubit/private_lessons_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/public_courses/public_courses_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/courses_details_cubit/courses_details_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/success_stories/success_stories_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/screens/best_mdeical_search_result_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/screens/course_details_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/screens/best_medical_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/screens/filter_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/screens/private_lessons_search_result_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/screens/top_private_lessons%20_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/widgets/empty_courses_widget.dart';
import 'package:dr_nada_salma_med_edu_plat/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/notifications/presentation/screen/notification_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/about_us_cubit/about_us_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/certificates/certificates_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/frequently_cubit/frequently_asked_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/lang/language_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/points/points_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/profile/profile_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/terms_cubit/terms_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/screens/about_us_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/screens/edit_profile_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/screens/frequently_asked_question_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/screens/language_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/screens/my_profile_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/screens/points_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/screens/reviews_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/screens/terms_conditions_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/reviews/presentation/screens/success_stories_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/splash/presentation/screens/second_splash_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/splash/presentation/screens/splash_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/injection_container/injection_container.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/teacher_registration/teacher_registration_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/screens/teacher_registration/teacher_registration_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/presentation/cubit/appointments_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/presentation/screens/appointments_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case teacherRegistrationSc:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) =>
                    sl<TeacherRegistrationCubit>()..loadInitialData(),
              ),
              BlocProvider(create: (_) => sl<BottomBarCubit>()),
            ],
            child: const TeacherRegistrationScreen(),
          ),
        );
      case splash:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider(create: (_) => SplashCubit(), child: SplashScreen()),
        );
      case secondSplash:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider(create: (_) => SplashCubit(), child: SecondSplash()),
        );
      case registerSc:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => sl<RegisterCubit>()),
              BlocProvider(create: (_) => sl<BottomBarCubit>()),
            ],
            child: RegisterScreen(),
          ),
        );
      case secondRegisterSc:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => sl<BottomBarCubit>()),
              BlocProvider(create: (_) => sl<SpecialistsCubit>()),
              BlocProvider(create: (_) => sl<AcademicInfoCubit>()),
              BlocProvider(create: (_) => sl<AcademicDegreeCubit>()),
            ],
            child: SecondRegisterScreen(email: settings.arguments as String),
          ),
          settings: settings,
        );
      case termsSc:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => sl<BottomBarCubit>()),
              BlocProvider(create: (_) => sl<RegisterCubit>()),
            ],
            child: TermsConditionsScreen(
              params: settings.arguments as AcademicInfoParams,
            ),
          ),
          settings: settings,
        );
      case verificationSc:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => sl<BottomBarCubit>()),
              BlocProvider(create: (_) => sl<VerifyCubit>()),
              BlocProvider(create: (_) => sl<ResendOtpCubit>()),
              BlocProvider(create: (_) => sl<CheckOtpCubit>()),
            ],
            child: VerificationScreen(
              params: settings.arguments as VerifyOtpParams,
            ),
          ),
          settings: settings,
        );
      case loginSc:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<LoginCubit>(),
            child: LoginScreen(),
          ),
        );
      case forgotPassSc:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => sl<BottomBarCubit>()),
              BlocProvider(create: (_) => sl<ForgotPasswordCubit>()),
            ],
            child: ForgotPasswordScreen(),
          ),
        );
      case resetPassSc:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => sl<ResetPassCubit>()),
              BlocProvider(create: (_) => sl<BottomBarCubit>()),
            ],
            child: ResetPasswordScreen(
              params: settings.arguments as CheckOtpParams,
            ),
          ),
          settings: settings,
        );
      case bottomBarSc:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => BottomBarCubit()),
              BlocProvider(create: (_) => sl<HeroesCubit>()),
              BlocProvider(create: (_) => sl<PublicCoursesCubit>()),
              BlocProvider(create: (_) => sl<CategoriesCubit>()),
              BlocProvider(create: (_) => sl<PrivateLessonsCubit>()),
              BlocProvider(create: (_) => sl<CategoryWithBlogCubit>()),
              BlocProvider(create: (_) => sl<CoursesStatusCubit>()),
              BlocProvider(create: (_) => sl<SuccessStoriesCubit>()),
            ],
            child: BottomBarScreen(),
          ),
        );
      case bestMedicalSc:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<PublicCoursesCubit>(),
            child: BestMedicalScreen(),
          ),
        );
      case filterSc:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<CategoriesCubit>()),
              BlocProvider(create: (context) => BottomBarCubit()),
            ],
            child: FilterScreen(title: settings.arguments as String),
          ),
          settings: settings,
        );
      case bestMedicalSearchResultSc:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<PublicCoursesCubit>(),
            child: BestMedicalSearchResultScreen(
              coursesParams: settings.arguments as CoursesParams,
            ),
          ),
          settings: settings,
        );
      case privateLessonsSc:
        return MaterialPageRoute(builder: (_) => TopPrivateLessonsScreen());

      case privateLessonsSearchResultSc:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<PrivateLessonsCubit>(),
            child: PrivateLessonsSearchResultScreen(
              params: settings.arguments as CoursesParams,
            ),
          ),
          settings: settings,
        );
      case blogSc:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<BottomBarCubit>()),
              BlocProvider(create: (context) => sl<CategoryWithBlogCubit>()),
            ],
            child: BlogScreens(appBarInd: settings.arguments as int),
          ),
          settings: settings,
        );
      case blogDetails:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<BlogDetailsCubit>()),
              BlocProvider(create: (context) => BottomBarCubit()),
            ],
            child: BlogDetailsScreen(
              blogDetailsParams: settings.arguments as BlogDetailsParams,
            ),
          ),
          settings: settings,
        );

      case myProfileSc:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => BottomBarCubit(),
            child: MyProfilesScreen(
              profileCubit: settings.arguments as ProfileCubit,
            ),
          ),
          settings: settings,
        );

      case editProfileSc:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => BottomBarCubit()),
              BlocProvider.value(value: settings.arguments as ProfileCubit),
            ],
            child: EditProfileScreen(
              profileCubit: settings.arguments as ProfileCubit,
            ),
          ),
          settings: settings,
        );

      case languageSc:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => sl<LanguageCubit>()),
              BlocProvider(create: (_) => sl<BottomBarCubit>()),
            ],
            child: LanguageScreen(),
          ),
          settings: settings,
        );
      case reviewsSc:
        final arg = settings.arguments as Map<String, dynamic>?;
        final courseId = arg?['course_id'] as int? ?? 0;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<CourseReviewsCubit>(),
            child: ReviewsScreen(courseId: courseId),
          ),
          settings: settings,
        );

      case pointsSc:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<PointsCubit>()),
              BlocProvider(create: (context) => sl<BottomBarCubit>()),
            ],
            child: PointsScreen(),
          ),
          settings: settings,
        );

      case frequentlyAsked:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<FrequentlyAskedCubit>()),
              BlocProvider(create: (context) => sl<BottomBarCubit>()),
            ],
            child: FrequentlyAskedQuestionScreen(),
          ),
          settings: settings,
        );

      case favouriteSc:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<FavouriteCubit>()),
              BlocProvider(create: (context) => sl<BottomBarCubit>()),
            ],
            child: FavouriteScreen(),
          ),
        );

      case coursesSc:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<CoursesStatusCubit>()),
              BlocProvider(create: (context) => sl<BottomBarCubit>()),
            ],
            child: MyCourses(type: settings.arguments as String),
          ),
          settings: settings,
        );

      case privateLessons:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<BottomBarCubit>()),
              BlocProvider(create: (context) => sl<CoursesStatusCubit>()),
            ],
            child: PrivateLessonsScreen(type: settings.arguments as String),
          ),
          settings: settings,
        );

      case certificateSc:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<CertificatesCubit>()),
              BlocProvider(create: (context) => sl<BottomBarCubit>()),
            ],
            child: CertificateScreen(),
          ),
          settings: settings,
        );
      case successStoriesSc:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<SuccessStoriesCubit>()),
              BlocProvider(create: (context) => BottomBarCubit()),
            ],
            child: SuccessStoriesScreen(type: settings.arguments as String),
          ),
          settings: settings,
        );
      case notificationsSc:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<NotificationsCubit>(),
            child: NotificationsScreen(),
          ),
          settings: settings,
        );

      case aboutUsSc:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<AboutUsCubit>()),
              BlocProvider(create: (context) => sl<BottomBarCubit>()),
            ],
            child: AboutUsScreen(),
          ),
          settings: settings,
        );

      case termsAndConditions:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<TermsCubit>()),
              BlocProvider(create: (context) => sl<BottomBarCubit>()),
            ],
            child: TermsAndConditionsScreen(),
          ),
          settings: settings,
        );
      case appointmentsSc:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<AppointmentsCubit>()),
              BlocProvider(create: (context) => sl<BottomBarCubit>()),
            ],
            child: const AppointmentsView(),
          ),
          settings: settings,
        );
      case emptyPrivateLessons:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<BottomBarCubit>(),
            child: EmptyPrivateLessonsWidget(),
          ),
          settings: settings,
        );
      case teachersListSc:
        final args = settings.arguments;
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (_) => TeachersListScreen(
              categoryName: args["category_name"] as String,
              subjectId: args["subject_id"] as int,
            ),
            settings: settings,
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => TeachersListScreen(categoryName: args as String),
            settings: settings,
          );
        }
      case teacherDetailSc:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<TeacherDetailCubit>(),
            child: TeacherDetailView(
              teacherId: args['teacher_id'] as int,
              subjectId: args['subject_id'] as int,
            ),
          ),
          settings: settings,
        );
      case courseDetailsSc:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => sl<BottomBarCubit>()),
              BlocProvider(create: (_) => sl<CoursesDetailsCubit>()),
            ],
            child: CourseDetailsScreen(
              params: settings.arguments as CoursesDetailsParams,
            ),
          ),
          settings: settings,
        );
    }
    return null;
  }
}
