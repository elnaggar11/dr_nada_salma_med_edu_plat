import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/points_response.dart';
import 'package:flutter/cupertino.dart';

class HistoryPointsItem extends StatelessWidget {
  Courses courses;

  HistoryPointsItem({required this.courses});

  @override
  Widget build(BuildContext context) {
   return Container(
     margin: EdgeInsets.all(7),
     child: Row(
       children: [
         Container(
           alignment: Alignment.center,
           padding: EdgeInsets.all(context.width/15),
           decoration: BoxDecoration(
             borderRadius: BorderRadius.all(Radius.circular(24)),
             color: primary,),
           child: customSvg(name: point),),
         SizedBox(width: context.width/30,),
         Expanded(
           child: Column(
             mainAxisSize: MainAxisSize.min,
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text("${courses.course![0].title}",style: TextStyles.textStyleNormal14
                   .copyWith(color: primary,fontWeight: FontWeight.w400)
                 ,textScaler: TextScaler.linear(1),),
               SizedBox(height: context.height/60,),
               Text("${courses.createdAt}",style: TextStyles.textStyleNormal10
                   .copyWith(color: grey6,fontWeight: FontWeight.w400)
                 ,textScaler: TextScaler.linear(1),),],),
         ),
         Text("+${courses.points} points",style: TextStyles.textStyleBold12
             .copyWith(fontWeight: FontWeight.w600,color: primary),
           textScaler: TextScaler.linear(1),),
         SizedBox(width: context.width/90,)
       ],
     ),
   );
  }

}