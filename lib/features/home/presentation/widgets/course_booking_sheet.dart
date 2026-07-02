import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_details_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CourseBookingSheet extends StatelessWidget {
  final Data course;
  final VoidCallback onConfirmBooking;

  const CourseBookingSheet({
    super.key,
    required this.course,
    required this.onConfirmBooking,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.width / 20,
            vertical: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tr("booking_info"),
                    style: TextStyles.textStyleBold20.copyWith(
                      color: orangeBold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: grey1),
                    onPressed: () => context.pop(),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // Course Name & Price
              Text(
                course.title ?? "",
                style: TextStyles.textStyleBold16.copyWith(color: primary),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "\$${course.price}",
                    style: TextStyles.textStyleBold20.copyWith(
                      color: orangeBold,
                    ),
                  ),
                  if (course.priceAfterDiscount != null) ...[
                    const SizedBox(width: 10),
                    Text(
                      "\$${course.priceAfterDiscount}",
                      style: TextStyles.textStyleNormal12.copyWith(
                        color: grey1,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 25),

              // Payment Instructions
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: primary.withOpacity(0.1)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "طرق الدفع المتاحة:", // Can be localized later
                      style: TextStyles.textStyleBold14.copyWith(
                        color: primary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.account_balance_wallet,
                          color: primary,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "التحويل عبر المحافظ الإلكترونية أو التحويل البنكي.",
                            style: TextStyles.textStyleBold13.copyWith(
                              color: black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "يرجى التواصل عبر واتساب لمعرفة تفاصيل وأرقام التحويل وإرسال إيصال الدفع لتأكيد حجزك في الكورس.",
                      style: TextStyles.textStyleNormal12.copyWith(
                        color: grey1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Confirm Button
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  color: primary,
                  onPressed: onConfirmBooking,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.chat, color: white, size: 20),
                      const SizedBox(width: 10),
                      Text(
                        tr("confirm_booking") + " عبر واتساب",
                        style: TextStyles.textStyleBold14.copyWith(
                          color: white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
