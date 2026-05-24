import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class TeacherStatCards extends StatelessWidget {
  final int studentsCount;
  final int coursesCount;
  final int experienceYears;

  const TeacherStatCards({
    super.key,
    required this.studentsCount,
    required this.coursesCount,
    required this.experienceYears,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatCard(context, "$studentsCount+", "Students"),
        _buildStatCard(context, "$coursesCount", "Courses"),
        _buildStatCard(context, "$experienceYears", "Exp. Years"),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String value, String label) {
    return Container(
      width: context.width / 3.4,
      padding: EdgeInsets.symmetric(vertical: context.height / 60),
      decoration: BoxDecoration(
        color: context.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(context.width / 25),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: context.boldText.copyWith(
              fontSize: context.width / 22,
              color: context.primaryColor,
            ),
          ),
          SizedBox(height: context.height / 200),
          Text(
            label,
            style: context.regularText.copyWith(
              fontSize: context.width / 35,
              color: context.hintColor,
            ),
          ),
        ],
      ),
    );
  }
}
