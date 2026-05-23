import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:flutter/material.dart';

class RegisterSectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const RegisterSectionHeader({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.width / 20,
        vertical: context.height / 80,
      ),
      child: Row(
        children: [
          Icon(icon, color: orangeBold, size: 24),
          SizedBox(width: context.width / 40),
          Text(
            title,
            style: TextStyles.textStyleBold16.copyWith(
              color: orangeBold,
              fontWeight: FontWeight.w700,
            ),
            textScaler: const TextScaler.linear(1.0),
          ),
        ],
      ),
    );
  }
}
