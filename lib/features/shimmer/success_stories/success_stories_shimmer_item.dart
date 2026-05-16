import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SuccessStoriesShimmerItem extends StatelessWidget {
  const SuccessStoriesShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width / .9,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(
        left: context.width / 35,
        right: context.width / 35,
        top: context.width / 60,
        bottom: context.width / 60,
      ),
      decoration: BoxDecoration(
        color: greyLight,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        shape: BoxShape.rectangle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: context.width / 7,
                height: context.width / 7,
                child: Shimmer.fromColors(
                  baseColor: black.withOpacity(.09),
                  highlightColor: Colors.white54,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: white,
                    ),
                  ),
                ),
              ),

              SizedBox(width: context.width / 50),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: context.width / 5,
                      height: context.width / 40,
                      child: Shimmer.fromColors(
                        baseColor: black.withOpacity(.09),
                        highlightColor: Colors.white54,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(22)),
                            shape: BoxShape.rectangle,
                            color: white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: context.height / 180),
                    SizedBox(
                      width: context.width / 7,
                      height: context.width / 50,
                      child: Shimmer.fromColors(
                        baseColor: black.withOpacity(.09),
                        highlightColor: Colors.white54,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(22)),
                            shape: BoxShape.rectangle,
                            color: white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: context.width / 50),
            ],
          ),

          SizedBox(height: context.height / 60),
          SizedBox(
            width: context.width / 3.5,
            height: context.width / 50,
            child: Shimmer.fromColors(
              baseColor: black.withOpacity(.09),
              highlightColor: Colors.white54,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                  shape: BoxShape.rectangle,
                  color: white,
                ),
              ),
            ),
          ),

          SizedBox(height: context.height / 80),
          SizedBox(
            width: context.width / 1.5,
            height: context.width / 50,
            child: Shimmer.fromColors(
              baseColor: black.withOpacity(.09),
              highlightColor: Colors.white54,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                  shape: BoxShape.rectangle,
                  color: white,
                ),
              ),
            ),
          ),
          SizedBox(height: context.height / 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: context.width / 3.5,
                height: context.width / 70,
                child: Shimmer.fromColors(
                  baseColor: black.withOpacity(.09),
                  highlightColor: Colors.white54,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(22)),
                      shape: BoxShape.rectangle,
                      color: white,
                    ),
                  ),
                ),
              ),
              Spacer(),
              customSvg(
                name: xsocial,
                width: context.width / 20,
                height: context.width / 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
