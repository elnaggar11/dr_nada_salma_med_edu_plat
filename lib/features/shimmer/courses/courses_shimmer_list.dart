import 'package:dr_nada_salma_med_edu_plat/features/shimmer/courses/courses_shimmer_item.dart';
import 'package:flutter/cupertino.dart';

class CoursesShimmerList extends StatelessWidget {
  const CoursesShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) => CoursesShimmerItem(),
    );
  }
}
