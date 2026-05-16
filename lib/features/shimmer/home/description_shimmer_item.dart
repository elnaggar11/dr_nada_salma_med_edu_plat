import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DescriptionShimmerItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Container(
     width: double.infinity,
     height: context.height/4,
     margin: EdgeInsets.only(left: context.width/20,right: context.width/20),
     padding: EdgeInsets.only(left: context.width/30,right: context.width/30),
     decoration: BoxDecoration(
         shape: BoxShape.rectangle,
         borderRadius: BorderRadius.all(Radius.circular(22))),
     child: Shimmer.fromColors(baseColor:black.withOpacity(.05)
       , highlightColor: Colors.white54
       ,child: Container(decoration:
       const BoxDecoration(color: white,borderRadius: BorderRadius.all(Radius.circular(22))),),),);
  }

}