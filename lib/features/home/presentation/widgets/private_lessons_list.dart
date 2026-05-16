import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/widgets/private_lesson_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/public_courses_response.dart';

class PrivateLessonsList extends StatelessWidget {

  final List<Data> lessonsList;

  PrivateLessonsList({required this.lessonsList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: context.width/30,right: context.width/30),
      child:SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 0,right: 0),
        primary: true,
        physics: ClampingScrollPhysics(),
        child: Row(
            children:lessonsList.map((e)=>PrivateLessonsItem( data: e,)).toList()),
      ),
    );
  }

}