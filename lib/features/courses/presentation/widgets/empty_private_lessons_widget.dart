import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class EmptyPrivateLessonsWidget extends StatelessWidget {
  const EmptyPrivateLessonsWidget({super.key});

  @override
  Widget build(BuildContext context) {

      return Container(
        alignment: Alignment.center,
        color: white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: context.height/10,),
            Container(
                alignment: Alignment.center,
                child: customSvg(name: privateMenu)),
            SizedBox(height: context.height/70,),
            Text(tr("lessons_available")
              ,style: TextStyles.textStyleBold22.copyWith(color: primary
                  ,fontWeight: FontWeight.w800)
              ,textScaler: TextScaler.linear(1),textAlign: TextAlign.center,),
            SizedBox(height: context.height/50,),
            Container(
              margin: EdgeInsets.only(left: context.width/30,right: context.width/30),
              child: Text(tr("working_launching")
                ,style: TextStyles.textStyleNormal14.copyWith(color: primary
                  ,fontWeight: FontWeight.w500)
                ,textScaler: TextScaler.linear(1),textAlign: TextAlign.center,),
            )
          ],
        ),
      );
    }


}