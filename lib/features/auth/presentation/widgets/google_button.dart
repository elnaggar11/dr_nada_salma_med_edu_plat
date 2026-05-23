import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/fonts.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class GoogleButtonWidget extends StatelessWidget {
  const GoogleButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: context.width / 20,
        right: context.width / 20,
      ),
      width: double.infinity,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        elevation: 0,
        color: greyLight,
        splashColor: Colors.transparent,
        padding: EdgeInsets.only(top: 14, bottom: 14),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customSvg(name: google),
            SizedBox(width: context.width / 30),
            Text(
              tr("continue_google"),
              style: TextStyles.textStyleBold12.copyWith(
                fontFamily: lamaSans,
                fontWeight: FontWeight.w800,
                color: black,
              ),
            ),
          ],
        ),
        onPressed: () {},
      ),
    );
  }
}
