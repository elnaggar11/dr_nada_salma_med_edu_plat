import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/notifications/domain/entities/notifications_response.dart';
import 'package:flutter/cupertino.dart';

class NotificationItem extends StatelessWidget {
  Datum data;

  NotificationItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final givenTime = DateTime.parse(data.createdAt!);

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
                  "${data.data!.title} 🎉",
                  style: TextStyles.textStyleBold16.copyWith(
                    color: black,
                    fontWeight: FontWeight.w600,
                  ),
                  textScaler: TextScaler.linear(1),
                ),
                SizedBox(height: context.height / 70),
                Text(
                  "${data.data!.description} “",
                  style: TextStyles.textStyleNormal12.copyWith(
                    color: primary,
                    fontWeight: FontWeight.w500,
                  ),
                  textScaler: TextScaler.linear(1),
                ),
                SizedBox(height: context.height / 90),
                Text(
                  "${now.difference(givenTime).inMinutes} minutes ago",
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
