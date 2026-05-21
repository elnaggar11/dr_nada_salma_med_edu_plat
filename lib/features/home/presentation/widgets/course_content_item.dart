import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_details_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/watch_course_cubit/watch_course_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/widgets/video_player_widget.dart';
import 'package:dr_nada_salma_med_edu_plat/injection_container/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseContentItem extends StatelessWidget {
  const CourseContentItem({
    super.key,
    required this.title,
    required this.lecture,
    required this.time,
    required this.courseId,
    required this.canWatch,
  });

  final String title;
  final List<Lectures> lecture;
  final String time;
  final String courseId;
  final bool canWatch;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: context.width / 30,
        right: context.width / 30,
      ),
      child: ExpansionTile(
        showTrailingIcon: false,
        childrenPadding: EdgeInsets.only(bottom: context.height / 40),
        leading: customSvg(name: dropdown),
        initiallyExpanded: true,

        onExpansionChanged: (bool? val) {},
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0, color: primary.withOpacity(.1)),
        ),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        collapsedBackgroundColor: primary.withOpacity(.1),
        backgroundColor: primary.withOpacity(.1),
        title: Container(
          margin: EdgeInsets.only(bottom: context.width / 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                textScaler: TextScaler.linear(1),
                style: TextStyles.textStyleNormal14.copyWith(color: primary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: context.height / 120),
              Row(
                children: [
                  Text(
                    "${lecture.length} Lectures",
                    textScaler: TextScaler.linear(1),
                    style: TextStyles.textStyleNormal14.copyWith(
                      color: primary,
                    ),
                  ),
                  SizedBox(width: context.width / 11),
                  Text(
                    "$time Min",
                    textScaler: TextScaler.linear(1),
                    style: TextStyles.textStyleNormal14.copyWith(
                      color: primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        children: lecture
            .map(
              (e) => InkWell(
                onTap: () {
                  //   if(canWatch == true){
                  showDialog(
                    context: context,
                    builder: (context) => BlocProvider(
                      create: (context) => sl<WatchCourseCubit>(),
                      child: VideoPlayerWidget(
                        lectureVideo: e.video!,
                        courseId: courseId,
                        lectureId: e.id.toString(),
                      ),
                    ),
                  );
                  /*  }else {
                      msgKey.currentState!.showSnackBar(SnackBar(
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
                          content: Text(tr("not_subscribed")
                            ,textScaler: TextScaler.linear(1),style: TextStyles
                                .textStyleNormal13.copyWith(color: white),)));
                    }*/
                },
                child: Container(
                  width: double.infinity,
                  color: primary.withOpacity(.05),
                  margin: EdgeInsets.all(context.width / 50),
                  padding: EdgeInsets.only(
                    left: context.width / 50,
                    right: context.width / 50,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${e.title}",
                        textScaler: TextScaler.linear(1),
                        style: TextStyles.textStyleNormal14.copyWith(
                          color: primary,
                        ),
                      ),
                      SizedBox(width: context.width / 40),
                      Text(
                        "$time Min",
                        textScaler: TextScaler.linear(1),
                        style: TextStyles.textStyleNormal14.copyWith(
                          color: primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
