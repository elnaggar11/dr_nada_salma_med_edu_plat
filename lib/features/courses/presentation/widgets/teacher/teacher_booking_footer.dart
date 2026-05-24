import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/extensions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/app_btn.dart';
import 'package:dr_nada_salma_med_edu_plat/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TeacherBookingFooter extends StatelessWidget {
  final double price;
  final VoidCallback onBookNow;

  const TeacherBookingFooter({
    super.key,
    required this.price,
    required this.onBookNow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.width / 20,
        vertical: context.height / 50,
      ),
      decoration: BoxDecoration(
        color: context.scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(context.width / 15),
          topRight: Radius.circular(context.width / 15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.cost.tr(),
                        style: context.regularText.copyWith(
                          fontSize: context.width / 25,
                          color: context.hintColor,
                        ),
                      ),
                      SizedBox(height: context.height / 200),
                      Text(
                        "\$$price",
                        style: context.boldText.copyWith(
                          fontSize: context.width / 18,
                          color: context.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width / 30,
                    vertical: context.height / 100,
                  ),
                  decoration: BoxDecoration(
                    color: context.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(context.width / 30),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time_filled,
                        size: context.width / 22,
                        color: context.primaryColor,
                      ),
                      SizedBox(width: context.width / 90),
                      Text(
                        LocaleKeys.normal_session.tr(),
                        style: context.mediumText.copyWith(
                          fontSize: context.width / 28,
                          color: context.primaryColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.width / 45,
                        ),
                        child: Container(
                          width: 1,
                          height: context.height / 60,
                          color: context.primaryColor.withOpacity(0.3),
                        ),
                      ),
                      Text(
                        LocaleKeys.session_duration.tr(args: ["60"]),
                        style: context.mediumText.copyWith(
                          fontSize: context.width / 28,
                          color: context.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: context.height / 40),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(context.width / 45),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.verified,
                    color: Colors.green,
                    size: context.width / 18,
                  ),
                ),
                SizedBox(width: context.width / 30),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.verified_teacher.tr(),
                        style: context.boldText.copyWith(
                          fontSize: context.width / 25,
                        ),
                      ),
                      Text(
                        LocaleKeys.verification_details.tr(),
                        style: context.regularText.copyWith(
                          fontSize: context.width / 32,
                          color: context.hintColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: context.height / 40),
            AppBtn(title: LocaleKeys.book_now.tr(), onPressed: onBookNow),
          ],
        ),
      ),
    );
  }
}
