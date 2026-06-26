import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:dr_nada_salma_med_edu_plat/gen/locale_keys.g.dart';
import 'package:flutter/material.dart';

class InPersonTrainingInfoCard extends StatelessWidget {
  const InPersonTrainingInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        left: context.width / 20,
        right: context.width / 20,
      ),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xffF7FBFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.in_person_training_info.tr(),
            style: TextStyles.textStyleBold16.copyWith(
              color: primary,
              fontWeight: FontWeight.w800,
            ),
            textScaler: const TextScaler.linear(1),
          ),
          const SizedBox(height: 12),
          _InfoRow(
            icon: Icons.business_outlined,
            title: LocaleKeys.training_place_name.tr(),
            value: LocaleKeys.dr_nada_salma_training_center.tr(),
          ),
          const SizedBox(height: 10),
          _InfoRow(
            icon: Icons.schedule_outlined,
            title: LocaleKeys.attendance_times.tr(),
            value: LocaleKeys.saturday_tuesday_times.tr(),
          ),
          const SizedBox(height: 10),
          _InfoRow(
            icon: Icons.location_on_outlined,
            title: LocaleKeys.hall_or_center_address.tr(),
            value: LocaleKeys.main_training_hall_address.tr(),
          ),
          const SizedBox(height: 10),
          _InfoRow(
            icon: Icons.groups_outlined,
            title: LocaleKeys.course_delivery_method.tr(),
            value: LocaleKeys.in_person_delivery_only.tr(),
          ),
          const SizedBox(height: 10),
          _InfoRow(
            icon: Icons.info_outline_rounded,
            title: LocaleKeys.booking_info.tr(),
            value: LocaleKeys.free_booking_via_app.tr(),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: orangeBold, size: 19),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyles.textStyleBold12.copyWith(
                  color: primary,
                  fontWeight: FontWeight.w700,
                ),
                textScaler: const TextScaler.linear(1),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyles.textStyleNormal12.copyWith(
                  color: black,
                  fontWeight: FontWeight.w500,
                ),
                textScaler: const TextScaler.linear(1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
