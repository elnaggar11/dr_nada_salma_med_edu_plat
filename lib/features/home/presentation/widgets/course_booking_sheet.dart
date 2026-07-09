import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_details_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CourseBookingSheet extends StatefulWidget {
  final Data course;
  final void Function(String? couponCode) onConfirmBooking;

  const CourseBookingSheet({
    super.key,
    required this.course,
    required this.onConfirmBooking,
  });

  @override
  State<CourseBookingSheet> createState() => _CourseBookingSheetState();
}

class _CourseBookingSheetState extends State<CourseBookingSheet> {
  final TextEditingController _couponController = TextEditingController();

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

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
          padding: EdgeInsets.only(
            left: context.width / 20,
            right: context.width / 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
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
                widget.course.title ?? "",
                style: TextStyles.textStyleBold16.copyWith(color: primary),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "${widget.course.price} ${tr('sar')}",
                    style: TextStyles.textStyleBold20.copyWith(
                      color: orangeBold,
                    ),
                  ),
                  if (widget.course.priceAfterDiscount != null) ...[
                    const SizedBox(width: 10),
                    Text(
                      "${widget.course.priceAfterDiscount} ${tr('sar')}",
                      style: TextStyles.textStyleNormal12.copyWith(
                        color: grey1,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 20),

              // Coupon Code Field
              Container(
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: grey1.withOpacity(0.3)),
                ),
                child: TextField(
                  controller: _couponController,
                  decoration: InputDecoration(
                    hintText: tr("coupon_code"),
                    hintStyle: TextStyles.textStyleNormal12.copyWith(
                      color: grey1,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 12,
                    ),
                    prefixIcon: const Icon(
                      Icons.local_offer_outlined,
                      color: primary,
                      size: 20,
                    ),
                  ),
                  style: TextStyles.textStyleBold14.copyWith(color: black),
                ),
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
                  onPressed: () {
                    final coupon = _couponController.text.trim();
                    widget.onConfirmBooking(coupon.isEmpty ? null : coupon);
                  },
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
      ),
    );
  }
}
