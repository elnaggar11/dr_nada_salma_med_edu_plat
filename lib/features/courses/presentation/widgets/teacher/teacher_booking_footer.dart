import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import '../../../../../gen/locale_keys.g.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class TeacherBookingFooter extends StatelessWidget {
  final double price;
  final VoidCallback onBookNow;
  final String? bookingPolicyHint;

  const TeacherBookingFooter({
    super.key,
    required this.price,
    required this.onBookNow,
    this.bookingPolicyHint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Cost Title
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  LocaleKeys.cost.tr(),
                  style: context.boldText.copyWith(
                    fontSize: 18,
                    color: const Color(0xFF355C7D),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF06523),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Cost Card
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFF9D0BA), width: 1.5),
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$$price",
                    style: context.boldText.copyWith(
                      fontSize: 20,
                      color: const Color(0xFF355C7D),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        LocaleKeys.normal_session.tr(),
                        style: context.boldText.copyWith(
                          fontSize: 16,
                          color: const Color(0xFF355C7D),
                        ),
                      ),
                      Text(
                        LocaleKeys.session_duration.tr(args: ['60']),
                        style: context.mediumText.copyWith(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Verified Badge
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF355C7D),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF355C7D).withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.workspace_premium_outlined, // Ribbon-like icon
                    color: Color(0xFFF06523),
                    size: 40,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    LocaleKeys.verified_teacher.tr(),
                    style: context.boldText.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    LocaleKeys.verification_details.tr(),
                    textAlign: TextAlign.center,
                    style: context.regularText.copyWith(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Book Now Button
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onBookNow,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF06523),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFF06523).withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: ui
                        .TextDirection
                        .ltr, // Ensures the arrow is on the left
                    children: [
                      const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        LocaleKeys.book_now.tr(),
                        style: context.boldText.copyWith(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (bookingPolicyHint != null && bookingPolicyHint!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    color: Colors.grey,
                    size: 14,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      bookingPolicyHint!,
                      style: context.regularText.copyWith(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
