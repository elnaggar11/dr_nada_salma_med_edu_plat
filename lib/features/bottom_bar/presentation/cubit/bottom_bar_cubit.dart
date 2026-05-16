import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/presentation/cubit/category_with_blog/category_with_blog_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/presentation/screens/blog_screens.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/cubit/categories/categories_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/cubit/courses_status_cubit/courses_status_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/screens/courses_lessons_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_details_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/courses_details_cubit/courses_details_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/hero/heroes_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/private_lessons_cubit/private_lessons_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/public_courses/public_courses_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/success_stories/success_stories_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/screens/best_mdeical_search_result_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/screens/best_medical_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/screens/course_details_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/screens/filter_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/screens/home_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/screens/private_lessons_search_result_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/screens/top_private_lessons%20_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/widgets/empty_courses_widget.dart';
import 'package:dr_nada_salma_med_edu_plat/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/notifications/presentation/screen/notification_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/profile/profile_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/screens/profile_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/features/reviews/presentation/screens/success_stories_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/injection_container/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'bottom_bar_state.dart';

class BottomBarCubit extends Cubit<BottomBarState> {
  BottomBarCubit() : super(BottomBarInitial());

  bool? renderNavBar = true;
  int pageIndex = 0;

  bool? visibility = true;


  Future<void> changeNavBarStatus({int? ind,}) async {
    pageIndex = ind!;

    emit(BottomBarUpdateState());
  }

  Future<void> changeNavBarStatus2({int? ind}) async {
    pageIndex = ind!;

    emit(BottomBarUpdateState2());
  }


  List<Widget> pageList({BuildContext? context}) {
    return [
      Navigator(
        onGenerateRoute: (settings) {
          Widget page = MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<SuccessStoriesCubit>(),),
              BlocProvider(create: (context) => sl<HeroesCubit>(),),
              BlocProvider(create: (context) => sl<PublicCoursesCubit>(),),
              BlocProvider(create: (context) => sl<PrivateLessonsCubit>(),),
              BlocProvider(create: (context) => sl<ProfileCubit>(),),
              BlocProvider(create: (context) => sl<NotificationsCubit>(),)
            ],
            child: HomeScreen(),);

          /*   Widget page = (settings.name == courseDetailsSc && ind == 0)
              ? BlocProvider(
            create: (context) => sl<PublicCoursesCubit>(),
            child: BestMedicalScreen(),) :
          (settings.name == courseDetailsSc && ind == 1) ?
          BlocProvider(create: (context) => sl<PublicCoursesCubit>(),
            child: BestMedicalSearchResultScreen(
              coursesParams: settings.arguments as CoursesParams,),)
              : (settings.name == courseDetailsSc && ind == 2)
              ? BlocProvider(create: (context) => sl<PrivateLessonsCubit>(),
            child: TopPrivateLessonsScreen(),) : (settings.name ==
              courseDetailsSc &&
              ind == 3) ?
          BlocProvider(
            create: (context) => sl<PrivateLessonsCubit>(),
            child: PrivateLessonsSearchResultScreen(
              params: settings.arguments as CoursesParams,),
          ) :
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<SuccessStoriesCubit>(),),
              BlocProvider(create: (context) => sl<HeroesCubit>(),),
              BlocProvider(create: (context) => sl<PublicCoursesCubit>(),),
              BlocProvider(create: (context) => sl<PrivateLessonsCubit>(),),
              BlocProvider(create: (context) => sl<ProfileCubit>(),)
            ],
            child: HomeScreen(),);*/
          if (settings.name == bestMedicalSc) {
            page = MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => sl<PublicCoursesCubit>(),
                ),
                BlocProvider.value(value : context!.read<BottomBarCubit>()),
              ],
              child: BestMedicalScreen(),
            );
          } else if (settings.name == privateLessonsSc) {
            page = BlocProvider(
              create: (context) => sl<PrivateLessonsCubit>(),
              child: TopPrivateLessonsScreen(),);
          } else if (settings.name == filterSc) {
            updateBottomBarVisibility(visible: false);
            page = MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => sl<CategoriesCubit>(),
                ),
                BlocProvider.value(value: context!.read<BottomBarCubit>()),
              ],
              child: FilterScreen(title: settings.arguments as String,),
            );
          } else if (settings.name == bestMedicalSearchResultSc) {
            updateBottomBarVisibility(visible: true);
            page = MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => sl<PublicCoursesCubit>(),
                ),
                BlocProvider.value(value: context!.read<BottomBarCubit>()),
              ],
              child: BestMedicalSearchResultScreen(
                coursesParams: settings.arguments as CoursesParams,),
            );
          } else if (settings.name == privateLessonsSearchResultSc) {
            page = BlocProvider(
              create: (context) => sl<PrivateLessonsCubit>(),
              child: PrivateLessonsSearchResultScreen(
                params: settings.arguments as CoursesParams,),
            );
          } else if (settings.name == courseDetailsSc) {
            updateBottomBarVisibility(visible: false);
            page = MultiBlocProvider(providers: [
              BlocProvider.value(value: context!.read<BottomBarCubit>()),
              BlocProvider(create: (_) => sl<CoursesDetailsCubit>(),),
            ],
                child: CourseDetailsScreen(
                  params: settings.arguments as CoursesDetailsParams,));
          } else if (settings.name == privateLessonsDetailsSc) {
            updateBottomBarVisibility(visible: false);
            page = BlocProvider.value(value: context!.read<BottomBarCubit>(),
              child: EmptyPrivateLessonsWidget(),
            );
            //   navKey.currentContext!.pushNamed(name: privateLessonsDetailsSc);
          } /*else if (settings.name == paymentSc) {
            updateBottomBarVisibility(visible: false);
            page = MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => sl<CreateCourseRequestCubit>()),
                  BlocProvider(create: (_) => sl<ResultCouponCubit>()),
                  BlocProvider.value(value: context!.read<BottomBarCubit>()),
                ],
                child: PaymentScreen(
                  params: settings.arguments as OrderParams,));
          }*/ else if (settings.name == successStoriesSc) {
            page = BlocProvider(
              create: (context) => sl<SuccessStoriesCubit>(),
              child: SuccessStoriesScreen(type: "stories"),);
          } else if (settings.name == notificationsSc) {
            updateBottomBarVisibility(visible: false);
            page = BlocProvider(
              create: (context) => sl<NotificationsCubit>(),
              child: NotificationsScreen(),
            );
          } else if (settings.name == emptyPrivateLessons) {
            updateBottomBarVisibility(visible: false);
            page = BlocProvider.value(
              value: context!.read<BottomBarCubit>(),
              child: EmptyPrivateLessonsWidget(),
            );
          }
          return MaterialPageRoute(builder: (_) => page);
        },),
      BlocProvider(
        create: (context) => sl<CategoryWithBlogCubit>(),
        child: BlogScreens(appBarInd: 1,),),
      BlocProvider(create: (context) => sl<CoursesStatusCubit>(),
        child: CoursesLessonsScreen(index: 1, appBarInd: 2),),
    /*  MultiBlocProvider(providers: [
        BlocProvider(create: (context) => sl<CartCubit>()),
        BlocProvider(create: (context) => sl<CreateOrderFromCartCubit>()),
      ], child: CartScreen()),*/
      BlocProvider(create: (context) => sl<ProfileCubit>(),
        child: ProfileScreen(appBarInd: 4,),)

    ];;
  }

  Future<void> updateBottomBarVisibility({bool? visible}) async {
    visibility = visible;
    emit(UpdateBottomBarVisibility());
  }

}
