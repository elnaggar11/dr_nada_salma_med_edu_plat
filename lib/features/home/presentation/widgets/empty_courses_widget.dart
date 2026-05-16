import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EmptyPrivateLessonsWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          appBarInd: 0,
          title: tr("my_private_lessons"),
          widget: SizedBox()),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: orangeBold,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                alignment: Alignment.center,
                child: customSvg(name: course,color: white,width: context.width/5
                    ,height: context.width/5)),
            SizedBox(height: context.height/50,),
            Text(tr("no_private_lessons"),style: TextStyles.textStyleBold15
                .copyWith(color: white),textScaler: TextScaler.linear(1),)
          ],
        ),
      ),
    );
  }

}