import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/features/notifications/domain/entities/notifications_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';

class NotificationItem extends StatelessWidget {
  Datum data;

  NotificationItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final givenTime = data.createdAt != null ? DateTime.tryParse(data.createdAt!) ?? DateTime.now() : DateTime.now();
    final isAr = context.locale.languageCode == "ar";
    final String displayTitle = isAr 
        ? (data.data?.titleAr ?? data.data?.title ?? 'Notification') 
        : (data.data?.titleEn ?? data.data?.title ?? 'Notification');
    final String displayDesc = isAr 
        ? (data.data?.descriptionAr ?? data.data?.description ?? '') 
        : (data.data?.descriptionEn ?? data.data?.description ?? '');

    final duration = now.difference(givenTime);
    String timeAgo = '';
    if (duration.inDays > 0) {
      if (duration.inDays == 1) {
        timeAgo = isAr ? 'منذ يوم' : '1 day ago';
      } else if (duration.inDays == 2) {
        timeAgo = isAr ? 'منذ يومين' : '2 days ago';
      } else if (duration.inDays <= 10) {
        timeAgo = isAr ? 'منذ ${duration.inDays} أيام' : '${duration.inDays} days ago';
      } else {
        timeAgo = isAr ? 'منذ ${duration.inDays} يوم' : '${duration.inDays} days ago';
      }
    } else if (duration.inHours > 0) {
      if (duration.inHours == 1) {
        timeAgo = isAr ? 'منذ ساعة' : '1 hour ago';
      } else if (duration.inHours == 2) {
        timeAgo = isAr ? 'منذ ساعتين' : '2 hours ago';
      } else if (duration.inHours <= 10) {
        timeAgo = isAr ? 'منذ ${duration.inHours} ساعات' : '${duration.inHours} hours ago';
      } else {
        timeAgo = isAr ? 'منذ ${duration.inHours} ساعة' : '${duration.inHours} hours ago';
      }
    } else if (duration.inMinutes > 0) {
      if (duration.inMinutes == 1) {
        timeAgo = isAr ? 'منذ دقيقة' : '1 minute ago';
      } else if (duration.inMinutes == 2) {
        timeAgo = isAr ? 'منذ دقيقتين' : '2 minutes ago';
      } else if (duration.inMinutes <= 10) {
        timeAgo = isAr ? 'منذ ${duration.inMinutes} دقائق' : '${duration.inMinutes} minutes ago';
      } else {
        timeAgo = isAr ? 'منذ ${duration.inMinutes} دقيقة' : '${duration.inMinutes} minutes ago';
      }
    } else {
      timeAgo = isAr ? 'الآن' : 'Just now';
    }

    return Container(
      margin: EdgeInsets.all(9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(context.width / 19),
            decoration: BoxDecoration(color: primary, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: customSvg(name: notifications),
          ),
          SizedBox(width: context.width / 30),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$displayTitle 🎉",
                  style: TextStyles.textStyleBold16.copyWith(
                    color: black,
                    fontWeight: FontWeight.w600,
                  ),
                  textScaler: TextScaler.linear(1),
                ),
                SizedBox(height: context.height / 70),
                Text(
                  "$displayDesc",
                  style: TextStyles.textStyleNormal12.copyWith(
                    color: primary,
                    fontWeight: FontWeight.w500,
                  ),
                  textScaler: TextScaler.linear(1),
                ),
                SizedBox(height: context.height / 90),
                Text(
                  timeAgo,
                  style: TextStyles.textStyleNormal12.copyWith(
                    fontWeight: FontWeight.w400,
                    color: greey1,
                  ),
                  textScaler: TextScaler.linear(1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
