import 'dart:math' as math;

import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/network_image_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/empty_course_widget.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/hero/heroes_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/private_lessons_cubit/private_lessons_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/public_courses/public_courses_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/success_stories/success_stories_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/widgets/best_medical_list.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/widgets/no_course_widget.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/widgets/private_lessons_list.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/widgets/success_stories_list.dart';
import 'package:dr_nada_salma_med_edu_plat/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/profile/profile_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/shimmer/home/best_medical_shimmer_list.dart';
import 'package:dr_nada_salma_med_edu_plat/features/shimmer/home/description_shimmer_item.dart';
import 'package:dr_nada_salma_med_edu_plat/features/shimmer/home/profile_shimmer_item.dart';
import 'package:dr_nada_salma_med_edu_plat/features/shimmer/success_stories/success_stories_shimmer_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    context.read<SuccessStoriesCubit>().getSuccessStories();
    context.read<HeroesCubit>().getHeroes();
    context.read<PublicCoursesCubit>().resetCourses(
      params: CoursesParams(
        type: '',
        categoryId: '',
        topRated: '',
        courseName: "",
      ),
    );
    context.read<PrivateLessonsCubit>().getPrivateLessons(
      params: CoursesParams(type: ''),
    );
    context.read<ProfileCubit>().getProfile();
    context.read<NotificationsCubit>().getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.height / 50),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return context.read<ProfileCubit>().loading == true
                      ? ProfileShimmerItem()
                      : context.read<ProfileCubit>().profileResponse == null
                      ? SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: context.width / 30),
                            ClipOval(
                              child: NetWorkImageHandler(
                                image:
                                    context
                                        .read<ProfileCubit>()
                                        .profileResponse!
                                        .data!
                                        .image ??
                                    "",
                                width: context.width / 8,
                                height: context.width / 8,
                              ),
                            ),
                            SizedBox(width: context.width / 40),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${context.read<ProfileCubit>().profileResponse!.data!.fullName}",
                                  style: TextStyles.textStyleBold14.copyWith(
                                    color: orangeBold,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  textScaler: TextScaler.linear(1),
                                ),
                                SizedBox(height: context.height / 280),
                                Text(
                                  (context
                                              .read<ProfileCubit>()
                                              .profileResponse
                                              ?.data
                                              ?.specialties
                                              ?.isNotEmpty ??
                                          false)
                                      ? "${context.read<ProfileCubit>().profileResponse!.data!.specialties![0].name}"
                                      : "",
                                  style: TextStyles.textStyleNormal12.copyWith(
                                    color: primary,
                                  ),
                                  textScaler: TextScaler.linear(1),
                                ),
                              ],
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                context.pushNamed(name: notificationsSc);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(16),

                                decoration: BoxDecoration(
                                  color: primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  clipBehavior: Clip.none,
                                  children: [
                                    customSvg(name: notifications),
                                    Positioned(
                                      bottom: 5,
                                      left: 8,
                                      child:
                                          BlocBuilder<
                                            NotificationsCubit,
                                            NotificationsState
                                          >(
                                            builder: (context, state) {
                                              return Container(
                                                padding: EdgeInsets.all(
                                                  context.width / 80,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: red,
                                                  shape: BoxShape.circle,
                                                ),
                                                child:
                                                    context
                                                            .read<
                                                              NotificationsCubit
                                                            >()
                                                            .loading ==
                                                        true
                                                    ? SpinKitPulse(
                                                        color: white,
                                                        size: 9,
                                                      )
                                                    : Text(
                                                        "${context.read<NotificationsCubit>().notificationsResponse!.data!.data!.length}",
                                                        style: TextStyles
                                                            .textStyleNormal13
                                                            .copyWith(
                                                              color: white,
                                                            ),
                                                        textScaler:
                                                            TextScaler.linear(
                                                              1,
                                                            ),
                                                      ),
                                              );
                                            },
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: context.width / 30),
                          ],
                        );
                },
              ),
              SizedBox(height: context.height / 40),
              Row(
                children: [
                  SizedBox(width: context.width / 30),
                  Expanded(
                    child: MediaQuery(
                      data: MediaQueryData(textScaler: TextScaler.linear(1)),
                      child: TextField(
                        controller: searchController,
                        onChanged: (val) {
                          context.read<PublicCoursesCubit>().resetCourses(
                            params: CoursesParams(
                              type: 'filter',
                              categoryId: '1',
                              topRated: '1',
                              courseName: searchController.text,
                            ),
                          );
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: greyLight,
                          hintText: tr("search_course"),
                          contentPadding: EdgeInsets.only(top: 13, bottom: 13),
                          hintStyle: TextStyles.textStyleNormal12.copyWith(
                            color: black,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              searchController.clear();
                              context.read<PublicCoursesCubit>().resetCourses(
                                params: CoursesParams(
                                  type: '',
                                  categoryId: '',
                                  topRated: '',
                                  courseName: '',
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.zero,

                              width: context.width / 15,
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.clear,
                                color: primary,
                                size: 20,
                              ),
                            ),
                          ),
                          prefixIcon: IntrinsicHeight(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: context.width / 8.5,
                                  alignment: Alignment.center,
                                  child: customSvg(name: search),
                                ),
                                SizedBox(width: context.width / 90),
                                VerticalDivider(
                                  thickness: 1,
                                  color: black.withValues(alpha: 0.1),
                                  indent: 15,
                                  endIndent: 15,
                                ),
                              ],
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: searchBg),
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: searchBg),
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: searchBg),
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: searchBg),
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: searchBg),
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: context.width / 50),
                  InkWell(
                    onTap: () {
                      context.pushNamed(name: filterSc, args: "");
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(17),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: orangeBold,
                      ),
                      child: customSvg(name: filter),
                    ),
                  ),
                  SizedBox(width: context.width / 30),
                ],
              ),
              SizedBox(height: context.height / 29),
              BlocBuilder<HeroesCubit, HeroesState>(
                builder: (context, state) {
                  return context.read<HeroesCubit>().loading == true
                      ? DescriptionShimmerItem()
                      : Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                            left: context.width / 20,
                            right: context.width / 20,
                          ),
                          padding: EdgeInsets.only(
                            left: context.width / 30,
                            right: context.width / 30,
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                context.read<HeroesCubit>().heroResponse == null
                                    ? ""
                                    : context
                                          .read<HeroesCubit>()
                                          .heroResponse!
                                          .data!
                                          .image!,
                              ),
                              fit: BoxFit.cover,
                              scale: 1.0,
                              alignment: Alignment.center,
                            ),
                            color: accent,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(22)),
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                bottom: 0,
                                right: -50,
                                child: customSvg(name: drawing),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: context.height / 30),
                                  context.read<HeroesCubit>().heroResponse ==
                                          null
                                      ? SizedBox()
                                      : Text(
                                          context
                                              .read<HeroesCubit>()
                                              .heroResponse!
                                              .data!
                                              .title!,
                                          style: TextStyles.textStyleBold15
                                              .copyWith(
                                                fontWeight: FontWeight.w800,
                                                color: white,
                                              ),
                                          textScaler: TextScaler.linear(1),
                                        ),
                                  SizedBox(height: context.height / 100),
                                  context.read<HeroesCubit>().heroResponse ==
                                          null
                                      ? SizedBox()
                                      : Text(
                                          context
                                              .read<HeroesCubit>()
                                              .heroResponse!
                                              .data!
                                              .description!,
                                          style: TextStyles.textStyleBold14
                                              .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: white,
                                              ),
                                          textScaler: TextScaler.linear(1),
                                        ),
                                  SizedBox(height: context.height / 28),
                                  InkWell(
                                    onTap: () {
                                      context.pushNamed(name: bestMedicalSc);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        bottom: context.height / 40,
                                        right: context.width / 3.5,
                                      ),
                                      padding: EdgeInsets.only(
                                        top: 11,
                                        bottom: 11,
                                        left: 11,
                                      ),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: primary,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(38),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          customSvg(name: frame),
                                          SizedBox(width: context.width / 38),
                                          Text(
                                            tr("start_learning_now"),
                                            style: TextStyles.textStyleBold10
                                                .copyWith(
                                                  color: white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                            textScaler: TextScaler.linear(1),
                                          ),
                                          SizedBox(width: context.width / 34),
                                          context.locale.languageCode == "ar"
                                              ? Transform.rotate(
                                                  angle: 180 * math.pi / 180,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: customSvg(
                                                      name: right,
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  alignment: Alignment.center,
                                                  child: customSvg(name: right),
                                                ),
                                          SizedBox(width: context.width / 34),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                },
              ),
              SizedBox(height: context.height / 26),
              Container(
                margin: EdgeInsets.only(
                  left: context.width / 20,
                  right: context.width / 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      tr("best_medical_courses"),
                      style: TextStyles.textStyleBold20.copyWith(
                        color: primary,
                        fontWeight: FontWeight.w800,
                        overflow: TextOverflow.ellipsis,
                      ),
                      textScaler: TextScaler.linear(1),
                      maxLines: 1,
                    ),
                    Spacer(),
                    TextButton(
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all<EdgeInsets>(
                          EdgeInsets.fromLTRB(0, 0, 0, 0),
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        context.pushNamed(name: bestMedicalSc);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tr("view_all"),
                            style: TextStyles.textStyleBold12.copyWith(
                              color: grey1,
                            ),
                            textScaler: TextScaler.linear(1),
                          ),

                          SizedBox(width: context.width / 60),
                          context.locale.languageCode == "ar"
                              ? Transform.rotate(
                                  angle: 180 * math.pi / 180,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: customSvg(
                                      name: raw,
                                      width: context.width / 25,
                                      height: context.width / 25,
                                    ),
                                  ),
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  child: customSvg(
                                    name: raw,
                                    width: context.width / 25,
                                    height: context.width / 25,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.height / 90),
              BlocBuilder<PublicCoursesCubit, PublicCoursesState>(
                builder: (context, state) {
                  return context.read<PublicCoursesCubit>().loading == true
                      ? BestMedicalShimmerList()
                      : context
                                .read<PublicCoursesCubit>()
                                .publicCoursesResponse ==
                            null
                      ? NoCourseWidget()
                      : BestMedicalList(
                          publicCoursesResponse: context
                              .read<PublicCoursesCubit>()
                              .publicCoursesResponse!,
                        );
                },
              ),
              SizedBox(height: context.height / 28),
              Container(
                margin: EdgeInsets.only(
                  left: context.width / 20,
                  right: context.width / 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      tr("top_private_lessons"),
                      style: TextStyles.textStyleBold20.copyWith(
                        color: primary,
                        fontWeight: FontWeight.w800,
                        overflow: TextOverflow.ellipsis,
                      ),
                      textScaler: TextScaler.linear(1),
                      maxLines: 1,
                    ),
                    Spacer(),
                    TextButton(
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all<EdgeInsets>(
                          EdgeInsets.fromLTRB(0, 0, 0, 0),
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        context.pushNamed(name: emptyPrivateLessons);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tr("view_all"),
                            style: TextStyles.textStyleBold12.copyWith(
                              color: grey1,
                            ),
                            textScaler: TextScaler.linear(1),
                          ),

                          SizedBox(width: context.width / 60),
                          context.locale.languageCode == "ar"
                              ? Transform.rotate(
                                  angle: 180 * math.pi / 180,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: customSvg(
                                      name: raw,
                                      width: context.width / 25,
                                      height: context.width / 25,
                                    ),
                                  ),
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  child: customSvg(
                                    name: raw,
                                    width: context.width / 25,
                                    height: context.width / 25,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.height / 40),
              BlocBuilder<PrivateLessonsCubit, PrivateLessonsState>(
                builder: (context, state) {
                  return context.read<PrivateLessonsCubit>().loading == true
                      ? BestMedicalShimmerList()
                      : context
                                .read<PrivateLessonsCubit>()
                                .publicCoursesResponse ==
                            null
                      ? EmptyCourseWidget()
                      : context
                            .read<PrivateLessonsCubit>()
                            .publicCoursesResponse!
                            .data!
                            .isEmpty
                      ? NoCourseWidget()
                      : PrivateLessonsList(
                          lessonsList: context
                              .read<PrivateLessonsCubit>()
                              .publicCoursesResponse!
                              .data!,
                        );
                },
              ),
              SizedBox(height: context.height / 30),
              Container(
                margin: EdgeInsets.only(
                  left: context.width / 20,
                  right: context.width / 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      tr("success_stories"),
                      style: TextStyles.textStyleBold20.copyWith(
                        color: primary,
                        fontWeight: FontWeight.w800,
                        overflow: TextOverflow.ellipsis,
                      ),
                      textScaler: TextScaler.linear(1),
                      maxLines: 1,
                    ),
                    Spacer(),
                    TextButton(
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all<EdgeInsets>(
                          EdgeInsets.fromLTRB(0, 0, 0, 0),
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        context.pushNamed(
                          name: successStoriesSc,
                          args: "stories",
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tr("view_all"),
                            style: TextStyles.textStyleBold12.copyWith(
                              color: grey1,
                            ),
                            textScaler: TextScaler.linear(1),
                          ),

                          SizedBox(width: context.width / 60),
                          context.locale.languageCode == "ar"
                              ? Transform.rotate(
                                  angle: 180 * math.pi / 180,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: customSvg(
                                      name: raw,
                                      width: context.width / 25,
                                      height: context.width / 25,
                                    ),
                                  ),
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  child: customSvg(
                                    name: raw,
                                    width: context.width / 25,
                                    height: context.width / 25,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.height / 150),
              BlocBuilder<SuccessStoriesCubit, SuccessStoriesState>(
                builder: (context, state) {
                  return context.read<SuccessStoriesCubit>().loading == true
                      ? SuccessStoriesShimmerList()
                      : SuccessStoriesList(
                          successStoriesResponse: context
                              .read<SuccessStoriesCubit>()
                              .successStoriesResponse!,
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
