import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmerItem extends StatelessWidget {
  const ProfileShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: context.width / 50),
        ClipOval(
          child: Container(
            width: context.width / 7,
            height: context.width / 7,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(22)),
            ),
            child: Shimmer.fromColors(
              baseColor: black.withOpacity(.05),
              highlightColor: Colors.white54,
              child: Container(
                decoration: const BoxDecoration(
                  color: white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: context.width / 3,
              height: context.height / 70,
              margin: EdgeInsets.only(
                left: context.width / 20,
                right: context.width / 20,
              ),
              padding: EdgeInsets.only(
                left: context.width / 30,
                right: context.width / 30,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(22)),
              ),
              child: Shimmer.fromColors(
                baseColor: black.withOpacity(.05),
                highlightColor: Colors.white54,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(22)),
                    color: white,
                    shape: BoxShape.rectangle,
                  ),
                ),
              ),
            ),
            SizedBox(height: context.height / 290),
            Container(
              width: context.width / 3,
              height: context.height / 70,
              margin: EdgeInsets.only(
                left: context.width / 20,
                right: context.width / 20,
              ),
              padding: EdgeInsets.only(
                left: context.width / 30,
                right: context.width / 30,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(22)),
              ),
              child: Shimmer.fromColors(
                baseColor: black.withOpacity(.05),
                highlightColor: Colors.white54,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(22)),
                    color: white,
                    shape: BoxShape.rectangle,
                  ),
                ),
              ),
            ),
          ],
        ),

        Spacer(flex: 4),
      ],
    );
  }
}
