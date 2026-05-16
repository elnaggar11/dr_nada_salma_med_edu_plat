import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BlogShimmerItem extends StatelessWidget {
  const BlogShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: context.width / 4.2,
            height: context.width / 4.2,
            child: Shimmer.fromColors(
              baseColor: black.withOpacity(.09),
              highlightColor: Colors.white54,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  shape: BoxShape.rectangle,
                  color: white,
                ),
              ),
            ),
          ),
          SizedBox(width: context.width / 40),
          Flexible(
            fit: FlexFit.loose,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: context.width / 3.5,
                  height: context.width / 30,
                  child: Shimmer.fromColors(
                    baseColor: black.withOpacity(.09),
                    highlightColor: Colors.white54,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        shape: BoxShape.rectangle,
                        color: white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: context.height / 80),
                SizedBox(
                  width: context.width / 4,
                  height: context.width / 80,
                  child: Shimmer.fromColors(
                    baseColor: black.withOpacity(.09),
                    highlightColor: Colors.white54,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        shape: BoxShape.rectangle,
                        color: white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: context.height / 60),
                SizedBox(
                  width: context.width / 3.9,
                  height: context.width / 70,
                  child: Shimmer.fromColors(
                    baseColor: black.withOpacity(.09),
                    highlightColor: Colors.white54,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        shape: BoxShape.rectangle,
                        color: white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
