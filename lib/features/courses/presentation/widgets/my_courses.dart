import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/fonts.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/courses_status_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/cubit/courses_status_cubit/courses_status_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/completed_item.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/empty_course_widget.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/in_progress_item.dart';
import 'package:dr_nada_salma_med_edu_plat/features/shimmer/courses/in_progress_shimmer_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyCourses extends StatefulWidget {
  final String type;


  MyCourses({required this.type});

  @override
  State<MyCourses> createState() => _MyCoursesState();

}

class _MyCoursesState extends State<MyCourses> with SingleTickerProviderStateMixin{
  TabController? tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    if(tabController!.index == 0){
      context.read<CoursesStatusCubit>().getCoursesStatus
        (params: CoursesStatusParams(courseStatus: "in_progress",coursesType: "my-public-courses/"));
    }else if(tabController!.index == 1){
      context.read<CoursesStatusCubit>().getCoursesStatus
        (params: CoursesStatusParams(courseStatus: "coming_soon",coursesType: "my-public-courses/"));
    }else if(tabController!.index == 2){
      context.read<CoursesStatusCubit>().getCoursesStatus
        (params: CoursesStatusParams(courseStatus: "completed",coursesType: "my-public-courses/"));

    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      color: white,
      child: Column(
        children: [
       ?widget.type == "courses" ?
       customAppBar(
           appBarInd: 0,
           widget: widget,title: tr("my_courses"),context: context,status: false) : SizedBox(),
        Container(
          margin: EdgeInsets.only(left: context.width/30,right: context.width/30),
          child: TabBar(
              controller: tabController,
              dividerColor: Colors.transparent,
              labelPadding: EdgeInsets.zero,
              unselectedLabelStyle: TextStyles.textStyleNormal13.copyWith(color: grey1,
                  fontWeight: FontWeight.w600,),
              labelStyle: TextStyles.textStyleNormal13.copyWith(color: primary,
                  fontWeight: FontWeight.w600,),
              onTap: (int? ind){
                if(ind == 0){
                  context.read<CoursesStatusCubit>().getCoursesStatus
                    (params:CoursesStatusParams(courseStatus: "in_progress",coursesType: "my-public-courses/"));
                }else if(ind == 1){
                  context.read<CoursesStatusCubit>().getCoursesStatus
                    (params:CoursesStatusParams(courseStatus: "coming_soon",coursesType: "my-public-courses/"));
                }else if(ind == 2){
                  context.read<CoursesStatusCubit>().getCoursesStatus
                    (params:CoursesStatusParams(courseStatus: "completed",coursesType: "my-public-courses/"));
                }
              },
              textScaler: TextScaler.linear(1),
              indicatorColor: primary,
              tabs: [
                Tab(text: tr("in_progress"),),
                Tab(text: tr("coming_soon"),),
                Tab(text: tr("completed"),)
      
              ]),),
        Expanded(child: BlocBuilder<CoursesStatusCubit, CoursesStatusState>(
          builder: (context, state) {
            return TabBarView(
            controller: tabController,
            physics: NeverScrollableScrollPhysics(),
            children: [
            context.read<CoursesStatusCubit>().loading == true ?
            InProgressShimmerList() :
            context.read<CoursesStatusCubit>().coursesStatusResponse == null ?
            EmptyCourseWidget() :
            context.read<CoursesStatusCubit>().coursesStatusResponse!.data!.isEmpty ?
                EmptyCourseWidget():
            ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: context.height/90,bottom: 0),
                  itemCount: context.read<CoursesStatusCubit>().coursesStatusResponse!.data!.length,
                  itemBuilder: (context,index)=> InProgressItem
                    (title: context.read<CoursesStatusCubit>().coursesStatusResponse!.data![index].title!
                    , image: context.read<CoursesStatusCubit>().coursesStatusResponse!.data![index].image!
                    ,points: context.read<CoursesStatusCubit>().coursesStatusResponse!.data![index].points.toString()!
                    ,progress: context.read<CoursesStatusCubit>().coursesStatusResponse!
                        .data![index].progress.toString(), slug: context.read<CoursesStatusCubit>().coursesStatusResponse!
                        .data![index].slug.toString()
                    ,favorited:  context.read<CoursesStatusCubit>().coursesStatusResponse!
                        .data![index].favorited, id: null,status: 'completed',
                    totalHours: context.read<CoursesStatusCubit>().coursesStatusResponse!
                        .data![index].totalHours.toString()?? "", categoryName: context.read<CoursesStatusCubit>().coursesStatusResponse!
                        .data![index].categoryName,
                    lectureNum: context.read<CoursesStatusCubit>().coursesStatusResponse!
                        .data![index].lecturesCount.toString()?? "", sectionNum: context.read<CoursesStatusCubit>().coursesStatusResponse!
                        .data![index].contentsCount.toString()??"",
                  )),

              context.read<CoursesStatusCubit>().loading == true ?
              InProgressShimmerList() :
              context.read<CoursesStatusCubit>().coursesStatusResponse == null ?
              EmptyCourseWidget() :
              context.read<CoursesStatusCubit>().coursesStatusResponse!.data!.isEmpty ?
              EmptyCourseWidget():
              ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: context.height/90,bottom: 0),
                  itemCount: context.read<CoursesStatusCubit>().coursesStatusResponse!.data!.length,
                  itemBuilder: (context,index)=> InProgressItem
                    (title: context.read<CoursesStatusCubit>().coursesStatusResponse!.data![index].title!
                    , image: context.read<CoursesStatusCubit>().coursesStatusResponse!.data![index].image!
                    ,points: context.read<CoursesStatusCubit>().coursesStatusResponse!.data![index].points.toString()!
                    ,progress: context.read<CoursesStatusCubit>().coursesStatusResponse!
                        .data![index].progress.toString(), slug: context.read<CoursesStatusCubit>().coursesStatusResponse!
                        .data![index].slug.toString(),
                    favorited: context.read<CoursesStatusCubit>().coursesStatusResponse!
                        .data![index].favorited
                    , id: context.read<CoursesStatusCubit>().coursesStatusResponse!
                        .data![index].id, status: 'completed',
            totalHours: context.read<CoursesStatusCubit>().coursesStatusResponse!
                .data![index].totalHours.toString()??"", categoryName: context.read<CoursesStatusCubit>().coursesStatusResponse!
                .data![index].categoryName??"",
            lectureNum: context.read<CoursesStatusCubit>().coursesStatusResponse!
                .data![index].lecturesCount.toString()??"", sectionNum: context.read<CoursesStatusCubit>().coursesStatusResponse!
                .data![index].contentsCount.toString()??"",
            )),

              context.read<CoursesStatusCubit>().loading == true ?
              InProgressShimmerList():
              context.read<CoursesStatusCubit>().coursesStatusResponse == null ?
                  EmptyCourseWidget() :
              context.read<CoursesStatusCubit>().coursesStatusResponse!.data!.isEmpty ?
              EmptyCourseWidget():
              ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: context.height/90,bottom: 0),
                  itemCount: context.read<CoursesStatusCubit>().coursesStatusResponse!.data!.length,
                  itemBuilder: (context,index)=> InProgressItem
                    (
                    title: context.read<CoursesStatusCubit>().coursesStatusResponse!.data![index].title!
                    , image: context.read<CoursesStatusCubit>().coursesStatusResponse!.data![index].image!
                    ,points: context.read<CoursesStatusCubit>().coursesStatusResponse!.data![index].points.toString()!
                    ,progress: context.read<CoursesStatusCubit>().coursesStatusResponse!
                        .data![index].progress.toString(),
                  slug: context.read<CoursesStatusCubit>().coursesStatusResponse!
                      .data![index].slug.toString(), favorited: context.read<CoursesStatusCubit>().coursesStatusResponse!
                        .data![index].favorited, id: context.read<CoursesStatusCubit>().coursesStatusResponse!
                        .data![index].id, status: 'completed',
                    totalHours: context.read<CoursesStatusCubit>().coursesStatusResponse!
                        .data![index].totalHours.toString()??"", categoryName: context.read<CoursesStatusCubit>().coursesStatusResponse!
                      .data![index].categoryName.toString()??"",
                    lectureNum: context.read<CoursesStatusCubit>().coursesStatusResponse!
                        .data![index].lecturesCount.toString()??"", sectionNum: context.read<CoursesStatusCubit>().coursesStatusResponse!
                      .data![index].contentsCount.toString()??"",
                  )),
            ]);
  },
))
      ],),
    );
  }
}