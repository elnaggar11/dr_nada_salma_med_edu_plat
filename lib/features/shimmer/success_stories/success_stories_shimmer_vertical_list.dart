import 'package:dr_nada_salma_med_edu_plat/features/shimmer/success_stories/success_stories_shimmer_item.dart';
import 'package:flutter/cupertino.dart';

class SuccessStoriesShimmerVerticalList extends StatelessWidget {
  const SuccessStoriesShimmerVerticalList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 7,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) => SuccessStoriesShimmerItem(),
    );
  }
}
