import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/public_courses/public_courses_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/widgets/best_medical_vertical_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/public_courses_response.dart';

class BestMedicalScreen extends StatefulWidget {
  const BestMedicalScreen({super.key});

  @override
  State<BestMedicalScreen> createState() => _BestMedicalScreenState();
}

class _BestMedicalScreenState extends State<BestMedicalScreen>
    with SingleTickerProviderStateMixin {
  static const int _pageSize = 8;

  final scrollController = ScrollController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Initial fetch for the first tab
    context.read<PublicCoursesCubit>().getPublicCourses(
      type: '',
      name: '',
      categoryId: '1',
      topRated: '1',
    );

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;

      String? courseStatus;
      String? isEnded;

      switch (_tabController.index) {
        case 0:
          // All courses
          break;
        case 1:
          courseStatus = 'active';
          break;
        case 2:
          courseStatus = 'coming_soon';
          break;
        case 3:
          courseStatus = 'ended';
          isEnded = '1';
          break;
      }

      context.read<PublicCoursesCubit>().currentPage = 1;
      context.read<PublicCoursesCubit>().getPublicCourses(
        type: '',
        name: '',
        categoryId: '1',
        topRated: '1',
        courseStatus: courseStatus,
        isEnded: isEnded,
      );
    });

    scrollController.addListener(() {
      final cubit = context.read<PublicCoursesCubit>();
      final state = cubit.state;

      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          state is PublicCoursesLoaded &&
          !state.hasReachedMax) {
        String? courseStatus;
        String? isEnded;

        switch (_tabController.index) {
          case 0:
            break;
          case 1:
            courseStatus = 'active';
            break;
          case 2:
            courseStatus = 'coming_soon';
            break;
          case 3:
            courseStatus = 'ended';
            isEnded = '1';
            break;
        }

        cubit.getPublicCourses(
          type: '',
          name: '',
          categoryId: '',
          topRated: '',
          courseStatus: courseStatus,
          isEnded: isEnded,
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: customAppBar(
        appBarInd: 0,
        title: tr("filter_medical_screen"),
        status: true,
        context: context,
        widget: InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            child: customSvg(name: share),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Row
          Row(
            children: [
              SizedBox(width: context.width / 30),
              Expanded(
                child: MediaQuery(
                  data: MediaQueryData(textScaler: TextScaler.linear(1)),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: greyLight,
                      hintText: tr("search_course_here"),
                      contentPadding: EdgeInsets.symmetric(vertical: 13),
                      hintStyle: TextStyles.textStyleNormal12.copyWith(
                        color: black,
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
                              color: black.withValues(alpha: .1),
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
                    ),
                  ),
                ),
              ),
              SizedBox(width: context.width / 50),
              InkWell(
                onTap: () {
                  context.pushNamed(
                    name: filterSc,
                    args: "Filter Medical Courses",
                  );
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

          SizedBox(height: context.height / 60),

          // Tab Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width / 30),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: primary,
              unselectedLabelColor: Colors.grey,
              indicatorColor: primary,
              tabs: [
                Tab(text: tr("view_all")), // Reusing "view_all"
                Tab(text: tr("enroll_now")),
                Tab(text: tr("coming_soon")),
                Tab(text: tr("ended")),
              ],
            ),
          ),

          SizedBox(height: context.height / 60),

          // Paged ListView
          Expanded(child: _coursesList()),
        ],
      ),
    );
  }

  Widget _coursesList() {
    return BlocBuilder<PublicCoursesCubit, PublicCoursesState>(
      builder: (context, state) {
        if (state is PublicCoursesInitialState ||
            (state is PublicCoursesLoading && state.isFirstFetch)) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: SpinKitPulse(color: primary, size: 80)),
          );
        }

        List<Data> courses = [];
        bool isLoading = false;
        bool hasReachedMax = false;

        if (state is PublicCoursesLoading) {
          courses = state.previousCourses;
          isLoading = true;
        } else if (state is PublicCoursesLoaded) {
          courses = state.courses;
          hasReachedMax = state.hasReachedMax;
        } else if (state is PublicCoursesError) {
          return Center(child: Text(state.message));
        }

        return ListView.builder(
          controller: scrollController,
          itemCount: courses.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < courses.length) {
              return BestMedicalVerticalItem(
                typeIndex: 0,
                data: courses[index],
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: SpinKitPulse(color: primary, size: 40)),
              );
            }
          },
        );
      },
    );
  }
}
