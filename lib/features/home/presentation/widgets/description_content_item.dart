import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:flutter/cupertino.dart';

class DescriptionContentItem extends StatelessWidget {
  final String content;

  const DescriptionContentItem({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: context.width / 20,
        right: context.width / 20,
      ),
      child: Text(
        content,
        style: TextStyles.textStyleNormal12.copyWith(
          color: primary,
          fontWeight: FontWeight.w500,
        ),
        textScaler: TextScaler.linear(1),
      ),
    );
  }
}
