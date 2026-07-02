import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CourseBookingFooter extends StatelessWidget {
  final String price;
  final String? priceAfterDiscount;
  final VoidCallback onBookPressed;

  const CourseBookingFooter({
    super.key,
    required this.price,
    this.priceAfterDiscount,
    required this.onBookPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.width / 20,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "\$$price",
                style: TextStyles.textStyleBold22.copyWith(
                  color: orangeBold,
                  fontWeight: FontWeight.w800,
                ),
                textScaler: const TextScaler.linear(1),
              ),
              if (priceAfterDiscount != null)
                Text(
                  "\$$priceAfterDiscount",
                  style: TextStyles.textStyleNormal12.copyWith(
                    color: grey1,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.lineThrough,
                  ),
                  textScaler: const TextScaler.linear(1),
                ),
            ],
          ),
          MaterialButton(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            color: primary,
            onPressed: onBookPressed,
            child: Text(
              tr("book_now"),
              style: TextStyles.textStyleBold14.copyWith(color: white),
              textScaler: const TextScaler.linear(1),
            ),
          ),
        ],
      ),
    );
  }
}
