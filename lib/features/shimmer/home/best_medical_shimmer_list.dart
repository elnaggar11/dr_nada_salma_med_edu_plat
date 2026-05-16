import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/features/shimmer/home/best_medical_shimmer_item.dart';
import 'package:flutter/cupertino.dart';

class BestMedicalShimmerList extends StatelessWidget {
List<int> intList= [0,1,2,];
BestMedicalShimmerList({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: context.width / 30, right: context.width / 30),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: ClampingScrollPhysics(),
        child:

        Row(
            children: intList.map((e) => BestMedicalShimmerItem()).toList()),),);
  }

}