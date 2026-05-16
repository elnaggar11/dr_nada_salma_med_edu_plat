import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:flutter/cupertino.dart';

class NoCourseWidget extends StatelessWidget {
  const NoCourseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              alignment : Alignment.center,
              child: customSvg(name: course,width:
              context.width/8,height: context.width/8)),
          SizedBox(height: context.height/80,),
          Text("No courses found",
            style: TextStyles.textStyleBold15
                .copyWith(color: primary)
            ,textScaler: TextScaler.linear(1),)
        ],
      ),
    );
  }

}