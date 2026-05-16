import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:flutter/cupertino.dart';

class DescriptionHeadTitle extends StatelessWidget{
  final String title;

  DescriptionHeadTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: context.width/20,right: context.width/20),
      child: Text(title
        ,style: TextStyles.textStyleBold18
            .copyWith(color: primary,fontWeight: FontWeight.bold),textScaler: TextScaler.linear(1),),
    );
  }

}