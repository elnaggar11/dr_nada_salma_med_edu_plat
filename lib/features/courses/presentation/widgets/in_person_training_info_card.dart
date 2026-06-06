import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:flutter/material.dart';

class InPersonTrainingInfoCard extends StatelessWidget {
  const InPersonTrainingInfoCard({super.key});

  static const String trainingPlace = "Dr Nada Salma Medical Training Center";
  static const String attendanceTimes =
      "السبت والثلاثاء من 5:00 مساءً إلى 8:00 مساءً";
  static const String hallAddress =
      "قاعة التدريب الرئيسية، 12 شارع التحرير، الدقي، الجيزة";
  static const String deliveryMode =
      "هذا الكورس يقدم حضورياً داخل القاعة وليس عبر الإنترنت فقط.";

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
            "بيانات التدريب الحضوري",
            style: TextStyles.textStyleBold16.copyWith(
              color: primary,
              fontWeight: FontWeight.w800,
            ),
            textScaler: const TextScaler.linear(1),
          ),
          const SizedBox(height: 12),
          _InfoRow(
            icon: Icons.business_outlined,
            title: "اسم مكان التدريب",
            value: trainingPlace,
          ),
          const SizedBox(height: 10),
          _InfoRow(
            icon: Icons.schedule_outlined,
            title: "مواعيد الحضور",
            value: attendanceTimes,
          ),
          const SizedBox(height: 10),
          _InfoRow(
            icon: Icons.location_on_outlined,
            title: "عنوان القاعة أو المركز",
            value: hallAddress,
          ),
          const SizedBox(height: 10),
          _InfoRow(
            icon: Icons.groups_outlined,
            title: "طريقة تقديم الكورس",
            value: deliveryMode,
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
