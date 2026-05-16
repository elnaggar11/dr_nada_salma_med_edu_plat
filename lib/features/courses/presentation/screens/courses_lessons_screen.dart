import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/courses_status_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/cubit/courses_status_cubit/courses_status_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/my_courses.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/private_lessons_screen.dart';
import 'package:dr_nada_salma_med_edu_plat/injection_container/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursesLessonsScreen extends StatefulWidget {
  final int index;
  final int appBarInd;

  CoursesLessonsScreen({required this.index, required this.appBarInd});

  @override
  State<CoursesLessonsScreen> createState() => _CoursesLessonsScreenState();

}

class _CoursesLessonsScreenState extends State<CoursesLessonsScreen> with TickerProviderStateMixin {


  @override
  void initState() {
  context.read<CoursesStatusCubit>().tabController = TabController(length: 2, vsync: this);
  if(context.read<CoursesStatusCubit>().tabController!.index == 0){
    context.read<CoursesStatusCubit>().getCoursesStatus
      (params: CoursesStatusParams(courseStatus: 'in_progress',coursesType: "my-public-courses/"));
  }else {
    context.read<CoursesStatusCubit>().getCoursesStatus
      (params: CoursesStatusParams(courseStatus: 'in_progress',coursesType: "my-private-courses/"));
  }


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: customAppBar(widget: SizedBox(),title: tr("my_learning")
          ,status: false,context: context,index: 1,appBarInd: widget.appBarInd),
      body: Column(children: [
        SizedBox(height: context.height/90,),
       BlocBuilder<CoursesStatusCubit,CoursesStatusState>(
  builder: (context, state) {
    return Container(
         margin: EdgeInsets.only(left: context.width/30,right: context.width/30),
          child: TabBar(
              controller: context.read<CoursesStatusCubit>().tabController,
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              labelPadding: EdgeInsets.only(left: context.width/90,right: context.width/90),
              onTap: (int? ind){
               if(ind == 0){
                 context.read<CoursesStatusCubit>().getCoursesStatus
                   (params: CoursesStatusParams(courseStatus: 'in_progress',coursesType: "my-public-courses/"));
               }else if(ind == 1){
                 context.read<CoursesStatusCubit>().getCoursesStatus
                   (params: CoursesStatusParams(courseStatus: 'in_progress'
                     ,coursesType: "my-private-courses/"));
               }
              },
              textScaler: TextScaler.linear(1),
              indicatorColor: Colors.transparent,
              tabs: [
          Container(
         alignment: Alignment.center,
         padding: EdgeInsets.only(top: 16,bottom: 16),
         decoration: BoxDecoration(
           color: context.read<CoursesStatusCubit>().tabController!.index == 0 ? orangeBold : greyLight, // background color
           borderRadius: BorderRadius.circular(38),
         ),
         child: Text(tr("my_courses"),
           style: TextStyles.textStyleNormal12
               .copyWith(color: context.read<CoursesStatusCubit>().tabController!.index == 0  ? white : grey1
               ,fontWeight: FontWeight.w600),
           textScaler: TextScaler.linear(1),
         ),
       ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 16,bottom:16),
          decoration: BoxDecoration(
            color: context.read<CoursesStatusCubit>().tabController!.index == 1 ? orangeBold : greyLight, // background color
            borderRadius: BorderRadius.circular(38),
          ),
          child: Text(tr("my_private_lessons"),
            style: TextStyles.textStyleNormal12
                .copyWith(color: context.read<CoursesStatusCubit>().tabController!.index == 1  ? white : grey1
                ,fontWeight: FontWeight.w600),
            textScaler: TextScaler.linear(1),
          ),),

              ]),);
  },
),
        SizedBox(height: context.height/60,),
        Expanded(
          child: BlocBuilder<CoursesStatusCubit,CoursesStatusState>(
            builder: (context, state) {
              return TabBarView(
                physics: NeverScrollableScrollPhysics(),
              controller: context.read<CoursesStatusCubit>().tabController,
              children: [
             MyCourses(type: 'in_progress',),
            PrivateLessonsScreen(type: '',)
          ]);
  },
),
        ),



      ],),
    );
  }
}