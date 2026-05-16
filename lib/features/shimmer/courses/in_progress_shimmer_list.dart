import 'package:dr_nada_salma_med_edu_plat/features/shimmer/courses/in_progress_shimmer_item.dart';
import 'package:flutter/cupertino.dart';

class InProgressShimmerList extends StatelessWidget {
  const InProgressShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (context,index)=>InProgressShimmerItem());
  }

}