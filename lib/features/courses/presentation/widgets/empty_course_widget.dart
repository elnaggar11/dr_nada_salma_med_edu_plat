import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class EmptyCourseWidget extends StatelessWidget {
  final String? title;

  const EmptyCourseWidget({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: context.height / 10),
          Container(
            alignment: Alignment.center,
            child: customSvg(
              name: emptyCourse,
              width: context.width / 7,
              height: context.width / 7,
            ),
          ),
          SizedBox(height: context.height / 70),
          Container(
            margin: EdgeInsets.only(
              left: context.width / 20,
              right: context.width / 20,
            ),
            child: Text(
              title ?? tr("havent_registered_any_course"),
              style: TextStyles.textStyleBold19.copyWith(
                color: primary,
                fontWeight: FontWeight.w800,
              ),
              textScaler: TextScaler.linear(1),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
