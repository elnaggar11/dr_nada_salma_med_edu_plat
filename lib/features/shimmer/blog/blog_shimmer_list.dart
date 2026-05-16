import 'package:dr_nada_salma_med_edu_plat/features/shimmer/blog/blog_shimmer_item.dart';
import 'package:flutter/cupertino.dart';

class BlogShimmerList extends StatelessWidget {
  const BlogShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context,index)=> BlogShimmerItem()),
    );
  }

}