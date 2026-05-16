import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class InProgressShimmerItem extends StatelessWidget {
  const InProgressShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.all(9),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: context.width / 3.5,
                height: context.width / 3.5,
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
              SizedBox(width: context.width / 50),
              Flexible(
                fit: FlexFit.loose,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: context.width / 7,
                          height: context.width / 30,
                          child: Shimmer.fromColors(
                            baseColor: black.withOpacity(.09),
                            highlightColor: Colors.white54,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                shape: BoxShape.rectangle,
                                color: white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: context.width / 20),
                        SizedBox(
                          width: context.width / 7,
                          height: context.width / 30,
                          child: Shimmer.fromColors(
                            baseColor: black.withOpacity(.09),
                            highlightColor: Colors.white54,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                shape: BoxShape.rectangle,
                                color: white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: context.height / 110),

                    SizedBox(
                      width: context.width / 3.5,
                      height: context.width / 40,
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

                    SizedBox(height: context.height / 120),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: context.width / 8,
                          height: context.width / 40,
                          child: Shimmer.fromColors(
                            baseColor: black.withOpacity(.09),
                            highlightColor: Colors.white54,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                shape: BoxShape.rectangle,
                                color: white,
                              ),
                            ),
                          ),
                        ),
                        customSvg(name: elipse),
                        SizedBox(
                          width: context.width / 8,
                          height: context.width / 40,
                          child: Shimmer.fromColors(
                            baseColor: black.withOpacity(.09),
                            highlightColor: Colors.white54,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                shape: BoxShape.rectangle,
                                color: white,
                              ),
                            ),
                          ),
                        ),
                        customSvg(name: elipse),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: context.height / 50),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: context.width / 12,
                      height: context.width / 50,
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
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
