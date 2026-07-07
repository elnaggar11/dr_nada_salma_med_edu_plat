import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/target_user.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/courses_status_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/cubit/courses_status_cubit/courses_status_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/empty_course_widget.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/in_progress_item.dart';
import 'package:dr_nada_salma_med_edu_plat/features/shimmer/courses/in_progress_shimmer_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:dr_nada_salma_med_edu_plat/gen/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCourses extends StatefulWidget {
  final String type;

  const MyCourses({super.key, required this.type});

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    if (tabController!.index == 0) {
      context.read<CoursesStatusCubit>().getCoursesStatus(
        params: CoursesStatusParams(
          courseStatus: "in_progress",
          coursesType: "my-public-courses/",
        ),
      );
    } else if (tabController!.index == 1) {
      context.read<CoursesStatusCubit>().getCoursesStatus(
        params: CoursesStatusParams(
          courseStatus: "coming_soon",
          coursesType: "my-public-courses/",
        ),
      );
    } else if (tabController!.index == 2) {
      context.read<CoursesStatusCubit>().getCoursesStatus(
        params: CoursesStatusParams(
          courseStatus: "completed",
          coursesType: "my-public-courses/",
        ),
      );
    } else if (tabController!.index == 3) {
      context.read<CoursesStatusCubit>().getCoursesStatus(
        params: CoursesStatusParams(
          courseStatus: "ended",
          coursesType: "my-public-courses/",
        ),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: white,
      child: Column(
        children: [
          ?widget.type == "courses"
              ? customAppBar(
                  appBarInd: 0,
                  widget: widget,
                  title: tr("my_courses"),
                  context: context,
                  status: false,
                )
              : SizedBox(),
          Container(
            margin: EdgeInsets.only(
              left: context.width / 30,
              right: context.width / 30,
            ),
            child: TabBar(
              controller: tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              dividerColor: Colors.transparent,
              labelPadding: EdgeInsets.symmetric(
                horizontal: context.width / 30,
              ),
              unselectedLabelStyle: TextStyles.textStyleNormal13.copyWith(
                color: grey1,
                fontWeight: FontWeight.w600,
              ),
              labelStyle: TextStyles.textStyleNormal13.copyWith(
                color: primary,
                fontWeight: FontWeight.w600,
              ),
              onTap: (int? ind) {
                if (ind == 0) {
                  context.read<CoursesStatusCubit>().getCoursesStatus(
                    params: CoursesStatusParams(
                      courseStatus: "in_progress",
                      coursesType: "my-public-courses/",
                    ),
                  );
                } else if (ind == 1) {
                  context.read<CoursesStatusCubit>().getCoursesStatus(
                    params: CoursesStatusParams(
                      courseStatus: "coming_soon",
                      coursesType: "my-public-courses/",
                    ),
                  );
                } else if (ind == 2) {
                  context.read<CoursesStatusCubit>().getCoursesStatus(
                    params: CoursesStatusParams(
                      courseStatus: "completed",
                      coursesType: "my-public-courses/",
                    ),
                  );
                } else if (ind == 3) {
                  context.read<CoursesStatusCubit>().getCoursesStatus(
                    params: CoursesStatusParams(
                      courseStatus: "ended",
                      coursesType: "my-public-courses/",
                    ),
                  );
                }
              },
              textScaler: TextScaler.linear(1),
              indicatorColor: primary,
              tabs: [
                Tab(text: tr("in_progress")),
                Tab(text: tr("coming_soon")),
                Tab(text: tr("completed")),
                Tab(text: tr("ended")),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<CoursesStatusCubit, CoursesStatusState>(
              builder: (context, state) {
                final targetUser = isTargetUser(context);

                return TabBarView(
                  controller: tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    context.read<CoursesStatusCubit>().loading == true
                        ? InProgressShimmerList()
                        : context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse ==
                              null
                        ? EmptyCourseWidget(title: LocaleKeys.empty_in_progress.tr())
                        : context
                              .read<CoursesStatusCubit>()
                              .coursesStatusResponse!
                              .data!
                              .isEmpty
                        ? EmptyCourseWidget(title: LocaleKeys.empty_in_progress.tr())
                        : ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                              top: context.height / 90,
                              bottom: 0,
                            ),
                            itemCount: context
                                .read<CoursesStatusCubit>()
                                .coursesStatusResponse!
                                .data!
                                .length,
                            itemBuilder: (context, index) => InProgressItem(
                              title: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .title!,
                              image: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .image!,
                              points: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .points
                                  .toString(),
                              progress: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .progress
                                  .toString(),
                              slug: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .slug
                                  .toString(),
                              favorited: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .favorited,
                              id: null,
                              status: 'in_progress',
                              totalHours: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .totalHours
                                  .toString(),
                              categoryName: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .categoryName,
                              lectureNum: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .lecturesCount
                                  .toString(),
                              sectionNum: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .contentsCount
                                  .toString(),
                              lecturesAreOpen: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .lecturesAreOpen,
                            ),
                          ),

                    context.read<CoursesStatusCubit>().loading == true
                        ? InProgressShimmerList()
                        : context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse ==
                              null
                        ? EmptyCourseWidget(title: LocaleKeys.empty_coming_soon.tr())
                        : context
                              .read<CoursesStatusCubit>()
                              .coursesStatusResponse!
                              .data!
                              .isEmpty
                        ? EmptyCourseWidget(title: LocaleKeys.empty_coming_soon.tr())
                        : ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                              top: context.height / 90,
                              bottom: 0,
                            ),
                            itemCount: context
                                .read<CoursesStatusCubit>()
                                .coursesStatusResponse!
                                .data!
                                .length,
                            itemBuilder: (context, index) => InProgressItem(
                              title: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .title!,
                              image: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .image!,
                              points: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .points
                                  .toString(),
                              progress: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .progress
                                  .toString(),
                              slug: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .slug
                                  .toString(),
                              favorited: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .favorited,
                              id: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .id,
                              status: 'coming_soon',
                              totalHours: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .totalHours
                                  .toString(),
                              categoryName:
                                  context
                                      .read<CoursesStatusCubit>()
                                      .coursesStatusResponse!
                                      .data![index]
                                      .categoryName ??
                                  "",
                              lectureNum: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .lecturesCount
                                  .toString(),
                              sectionNum: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .contentsCount
                                  .toString(),
                              lecturesAreOpen: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .lecturesAreOpen,
                            ),
                          ),
                    targetUser
                        ? ListView(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                              top: context.height / 90,
                              bottom: 0,
                            ),
                            children: const [
                              InProgressItem(
                                title:
                                    "كورس الطب الباطني الشامل - المهارات السريرية",
                                image:
                                    "https://api1.drnadasalma.com/images/user2.png",
                                points: "150",
                                progress: "100",
                                slug: "internal-medicine-clinical-skills",
                                favorited: true,
                                id: 9991,
                                status: "completed",
                                totalHours: "24",
                                categoryName: "الطب الباطني",
                                lectureNum: "18",
                                sectionNum: "4",
                                lecturesAreOpen: true,
                                showTrainingInfo: true,
                              ),
                              InProgressItem(
                                title: "أساسيات علم الجراحة العامة وتطبيقاتها",
                                image:
                                    "https://api1.drnadasalma.com/images/user2.png",
                                points: "200",
                                progress: "100",
                                slug: "fundamentals-general-surgery",
                                favorited: false,
                                id: 9992,
                                status: "completed",
                                totalHours: "35",
                                categoryName: "الجراحة العامة",
                                lectureNum: "25",
                                sectionNum: "5",
                                lecturesAreOpen: true,
                                showTrainingInfo: true,
                              ),
                            ],
                          )
                        : (context.read<CoursesStatusCubit>().loading == true
                              ? InProgressShimmerList()
                              : context
                                        .read<CoursesStatusCubit>()
                                        .coursesStatusResponse ==
                                    null
                              ? EmptyCourseWidget(title: LocaleKeys.empty_completed.tr())
                              : context
                                    .read<CoursesStatusCubit>()
                                    .coursesStatusResponse!
                                    .data!
                                    .isEmpty
                              ? EmptyCourseWidget(title: LocaleKeys.empty_completed.tr())
                              : ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(
                                    top: context.height / 90,
                                    bottom: 0,
                                  ),
                                  itemCount: context
                                      .read<CoursesStatusCubit>()
                                      .coursesStatusResponse!
                                      .data!
                                      .length,
                                  itemBuilder: (context, index) =>
                                      InProgressItem(
                                        title: context
                                            .read<CoursesStatusCubit>()
                                            .coursesStatusResponse!
                                            .data![index]
                                            .title!,
                                        image: context
                                            .read<CoursesStatusCubit>()
                                            .coursesStatusResponse!
                                            .data![index]
                                            .image!,
                                        points: context
                                            .read<CoursesStatusCubit>()
                                            .coursesStatusResponse!
                                            .data![index]
                                            .points
                                            .toString(),
                                        progress: context
                                            .read<CoursesStatusCubit>()
                                            .coursesStatusResponse!
                                            .data![index]
                                            .progress
                                            .toString(),
                                        slug: context
                                            .read<CoursesStatusCubit>()
                                            .coursesStatusResponse!
                                            .data![index]
                                            .slug
                                            .toString(),
                                        favorited: context
                                            .read<CoursesStatusCubit>()
                                            .coursesStatusResponse!
                                            .data![index]
                                            .favorited,
                                        id: context
                                            .read<CoursesStatusCubit>()
                                            .coursesStatusResponse!
                                            .data![index]
                                            .id,
                                        status: 'completed',
                                        totalHours: context
                                            .read<CoursesStatusCubit>()
                                            .coursesStatusResponse!
                                            .data![index]
                                            .totalHours
                                            .toString(),
                                        categoryName: context
                                            .read<CoursesStatusCubit>()
                                            .coursesStatusResponse!
                                            .data![index]
                                            .categoryName
                                            .toString(),
                                        lectureNum: context
                                            .read<CoursesStatusCubit>()
                                            .coursesStatusResponse!
                                            .data![index]
                                            .lecturesCount
                                            .toString(),
                                        sectionNum: context
                                            .read<CoursesStatusCubit>()
                                            .coursesStatusResponse!
                                            .data![index]
                                            .contentsCount
                                            .toString(),
                                        lecturesAreOpen: context
                                            .read<CoursesStatusCubit>()
                                            .coursesStatusResponse!
                                            .data![index]
                                            .lecturesAreOpen,
                                      ),
                                )),
                    (context.read<CoursesStatusCubit>().loading == true
                        ? InProgressShimmerList()
                        : context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse ==
                              null
                        ? EmptyCourseWidget(title: LocaleKeys.empty_ended.tr())
                        : context
                              .read<CoursesStatusCubit>()
                              .coursesStatusResponse!
                              .data!
                              .isEmpty
                        ? EmptyCourseWidget(title: LocaleKeys.empty_ended.tr())
                        : ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                              top: context.height / 90,
                              bottom: 0,
                            ),
                            itemCount: context
                                .read<CoursesStatusCubit>()
                                .coursesStatusResponse!
                                .data!
                                .length,
                            itemBuilder: (context, index) => InProgressItem(
                              title: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .title!,
                              image: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .image!,
                              points: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .points
                                  .toString(),
                              progress: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .progress
                                  .toString(),
                              slug: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .slug
                                  .toString(),
                              favorited: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .favorited,
                              id: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .id,
                              status: 'ended',
                              totalHours: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .totalHours
                                  .toString(),
                              categoryName: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .categoryName
                                  .toString(),
                              lectureNum: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .lecturesCount
                                  .toString(),
                              sectionNum: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .contentsCount
                                  .toString(),
                              lecturesAreOpen: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .lecturesAreOpen,
                            ),
                          )),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
