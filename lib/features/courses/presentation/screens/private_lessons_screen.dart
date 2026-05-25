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
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 1, vsync: this);
    _fetchData();
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void _fetchData() {
    context.read<CoursesStatusCubit>().getCoursesStatus(
      params: CoursesStatusParams(coursesType: "/tutoring/subjects"),
    );
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
              tabs: [Tab(text: tr("lessons"))],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
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
                              final description =
                                  (data.semiDescription != null &&
                                      data.semiDescription!
                                          .toString()
                                          .isNotEmpty)
                                  ? data.semiDescription!.toString()
                                  : tr("working_launching");
                              final image =
                                  (data.image != null &&
                                      data.image!.toString().isNotEmpty)
                                  ? data.image!.toString()
                                  : "https://images.unsplash.com/photo-1559839734-2b71ea197ec2?q=80&w=300&auto=format&fit=crop";
                              return PrivateLessonItem(
                                title: data.title ?? "",
                                description: description,
                                image: image,
                                tags: [data.categoryName ?? tr("medicine")],
                                discount:
                                    data.hasDiscount == true &&
                                        data.discountPercentage != null
                                    ? "${data.discountPercentage}%"
                                    : null,
                                onDetailsPressed: () {
                                  context.pushNamed(
                                    name: teachersListSc,
                                    args: {
                                      "subject_id": data.id ?? 1,
                                      "category_name":
                                          data.categoryName ?? tr("medicine"),
                                    },
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
