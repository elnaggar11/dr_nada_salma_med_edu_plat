import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/courses_status_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/cubit/courses_status_cubit/courses_status_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/comin_soon_item.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/empty_private_lessons_widget.dart';
import 'package:dr_nada_salma_med_edu_plat/features/shimmer/courses/in_progress_shimmer_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/profile/profile_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/settings_response.dart' as settings;
import 'package:dr_nada_salma_med_edu_plat/core/widgets/network_image_handler.dart';

class PrivateLessonsScreen extends StatefulWidget {
  final String type;

  const PrivateLessonsScreen({super.key, required this.type});

  @override
  State<PrivateLessonsScreen> createState() => _PrivateLessonsScreenState();
}

class _PrivateLessonsScreenState extends State<PrivateLessonsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 1, vsync: this);
    context.read<CoursesStatusCubit>().getCoursesStatus(
      params: CoursesStatusParams(coursesType: "/tutoring/subjects"),
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: white,
      child: Column(
        children: [
          widget.type == "lessons"
              ? customAppBar(
                      appBarInd: 0,
                      widget: widget,
                      title: tr("my_private_lessons"),
                      context: context,
                      status: false,
                    ) ??
                    const SizedBox()
              : const SizedBox(),
          Builder(
            builder: (context) {
              final profileCubit = context.read<ProfileCubit>();
              final banner = profileCubit.settingsResponse?.data?.firstWhere(
                  (element) => element.tutoringPageBanner != null,
                  orElse: () => settings.Data()).tutoringPageBanner;
              if (banner != null && banner.toString().isNotEmpty) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width / 30,
                    vertical: 8.0,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: NetWorkImageHandler(
                      image: banner.toString(),
                      width: double.infinity,
                      height: context.height / 6,
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
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
                context.read<CoursesStatusCubit>().getCoursesStatus(
                  params: CoursesStatusParams(
                    coursesType: "/tutoring/subjects",
                  ),
                );
              },
              textScaler: TextScaler.linear(1),
              indicatorColor: primary,
              tabs: [Tab(text: tr("lessons"))],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                BlocBuilder<CoursesStatusCubit, CoursesStatusState>(
                  builder: (context, state) {
                    return context.read<CoursesStatusCubit>().loading == true
                        ? InProgressShimmerList()
                        : (context
                                      .read<CoursesStatusCubit>()
                                      .coursesStatusResponse ==
                                  null ||
                              context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data!
                                  .isEmpty)
                        ? EmptyPrivateLessonsWidget()
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
                            itemBuilder: (context, index) => ComingSoonItem(
                              title: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .title!,
                              img: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .image!,
                              progress: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .progress
                                  .toString(),
                              points: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .points
                                  .toString(),
                              slug: context
                                  .read<CoursesStatusCubit>()
                                  .coursesStatusResponse!
                                  .data![index]
                                  .slug,
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
                            ),
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
