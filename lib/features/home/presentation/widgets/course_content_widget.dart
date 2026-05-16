import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/courses_details_cubit/courses_details_cubit.dart';
import 'package:flutter/cupertino.dart';

class CourseContentWidget extends StatelessWidget {
  final String lectureNum;
  final String totalTime;


  const CourseContentWidget({required this.lectureNum,required this.totalTime});

  @override
  Widget build(BuildContext context) {
    return  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
          Text("sections",style: TextStyles.textStyleBold14
              .copyWith(fontWeight: FontWeight.w600,color: primary)
            ,textScaler: TextScaler.linear(1),),
          SizedBox(width: context.width/30,),
          customSvg(name: elipse),
            SizedBox(width: context.width/30,),
          Text("$lectureNum lectures",style: TextStyles.textStyleBold14
              .copyWith(fontWeight: FontWeight.w600,color: primary)
            ,textScaler: TextScaler.linear(1),),
            SizedBox(width: context.width/30,),
          customSvg(name: elipse),
            SizedBox(width: context.width/30,),
          Text(totalTime,style: TextStyles.textStyleBold14
              .copyWith(fontWeight: FontWeight.w600,color: primary)
            ,textScaler: TextScaler.linear(1),),
        ],

    );
  }

}