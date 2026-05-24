import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/courses_status_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/cubit/courses_status_cubit/courses_status_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/empty_private_lessons_widget.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/private_lesson_item.dart';
import 'package:dr_nada_salma_med_edu_plat/features/shimmer/courses/in_progress_shimmer_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrivateLessonsScreen extends StatefulWidget {
  final String type;

  const PrivateLessonsScreen({super.key, required this.type});

  @override
  State<PrivateLessonsScreen> createState() => _PrivateLessonsScreenState();
}

class _PrivateLessonsScreenState extends State<PrivateLessonsScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    _fetchData();
    super.initState();
  }

  void _fetchData() {
    if (tabController!.index == 0) {
      context.read<CoursesStatusCubit>().getCoursesStatus(
        params: CoursesStatusParams(
          courseStatus: "coming_soon",
          coursesType: "my-private-courses/",
        ),
      );
    } else if (tabController!.index == 1) {
      context.read<CoursesStatusCubit>().getCoursesStatus(
        params: CoursesStatusParams(
          courseStatus: "completed",
          coursesType: "my-private-courses/",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: white,
      child: Column(
        children: [
          (widget.type == "lessons")
              ? customAppBar(
                      appBarInd: 0,
                      widget: widget,
                      title: tr("my_private_lessons"),
                      context: context,
                      status: false,
                    ) ??
                    const SizedBox()
              : const SizedBox(),
          Container(
            margin: EdgeInsets.only(
              left: context.width / 30,
              right: context.width / 30,
            ),
            child: TabBar(
              controller: tabController,
              labelPadding: EdgeInsets.zero,
              dividerColor: Colors.transparent,
              unselectedLabelStyle: TextStyles.textStyleNormal12.copyWith(
                color: grey1,
                fontWeight: FontWeight.w600,
              ),
              labelStyle: TextStyles.textStyleNormal12.copyWith(
                color: primary,
                fontWeight: FontWeight.w600,
              ),
              onTap: (int? ind) {
                _fetchData();
              },
              textScaler: const TextScaler.linear(1),
              indicatorColor: primary,
              tabs: [
                Tab(text: tr("lessons")),
                Tab(text: tr("completed")),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // Coming Soon Tab
                BlocBuilder<CoursesStatusCubit, CoursesStatusState>(
                  builder: (context, state) {
                    final cubit = context.read<CoursesStatusCubit>();
                    final hasRealData =
                        cubit.coursesStatusResponse?.data?.isNotEmpty ?? false;

                    return cubit.loading == true
                        ? const InProgressShimmerList()
                        : ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                              top: context.height / 90,
                              bottom: 0,
                            ),
                            // Show 1 mock item if no real data is found (for design verification)
                            itemCount: hasRealData
                                ? cubit.coursesStatusResponse!.data!.length
                                : 1,
                            itemBuilder: (context, index) {
                              if (!hasRealData) {
                                return PrivateLessonItem(
                                  title: "كورس المهارات الجراحية المتقدمة",
                                  description:
                                      "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.",
                                  image: "https://via.placeholder.com/400x200",
                                  tags: ["جراحة", "طوارئ", "عناية مركزة"],
                                  onDetailsPressed: () {
                                    context.pushNamed(
                                      name: teachersListSc,
                                      args: "جراحة",
                                    );
                                  },
                                );
                              }
                              final data =
                                  cubit.coursesStatusResponse!.data![index];
                              return PrivateLessonItem(
                                title: data.title ?? "",
                                description: data.semiDescription ?? "",
                                image: data.image ?? "",
                                tags: [data.categoryName ?? tr("medicine")],
                                onDetailsPressed: () {
                                  context.pushNamed(
                                    name: teachersListSc,
                                    args: data.categoryName ?? tr("medicine"),
                                  );
                                },
                              );
                            },
                          );
                  },
                ),

                // Completed Tab
                BlocBuilder<CoursesStatusCubit, CoursesStatusState>(
                  builder: (context, state) {
                    final cubit = context.read<CoursesStatusCubit>();
                    return cubit.loading == true
                        ? const InProgressShimmerList()
                        : (cubit.coursesStatusResponse?.data == null ||
                              cubit.coursesStatusResponse!.data!.isEmpty)
                        ? const EmptyPrivateLessonsWidget()
                        : ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                              top: context.height / 90,
                              bottom: 0,
                            ),
                            itemCount:
                                cubit.coursesStatusResponse!.data!.length,
                            itemBuilder: (context, index) {
                              final data =
                                  cubit.coursesStatusResponse!.data![index];
                              return PrivateLessonItem(
                                title: data.title ?? "",
                                description: data.semiDescription ?? "",
                                image: data.image ?? "",
                                tags: [data.categoryName ?? tr("medicine")],
                                onDetailsPressed: () {
                                  context.pushNamed(
                                    name: teachersListSc,
                                    args: data.categoryName ?? tr("medicine"),
                                  );
                                },
                              );
                            },
                          );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
