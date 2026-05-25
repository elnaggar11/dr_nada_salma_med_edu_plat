import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/teacher_registration/teacher_registration_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/widgets/register_section_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherAvailabilitySection extends StatelessWidget {
  const TeacherAvailabilitySection({super.key});

  static const List<String> _daysOfWeek = [
    'saturday',
    'sunday',
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
  ];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TeacherRegistrationCubit>();
    return Column(
      children: [
        RegisterSectionHeader(
          title: tr("initial_availability"),
          icon: Icons.access_time_outlined,
        ),
        _buildDaysLabel(context),
        const SizedBox(height: 8),
        _buildDaysChips(context, cubit),
        SizedBox(height: context.height / 45),
        _buildTimeRangePickers(context, cubit),
        _buildAvailabilityNotice(context),
      ],
    );
  }

  Widget _buildDaysLabel(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width / 20),
      child: Align(
        alignment: Alignment.centerRight,
        child: RichText(
          textScaler: const TextScaler.linear(1.0),
          text: TextSpan(
            children: [
              TextSpan(
                text: tr("choose_available_days"),
                style: TextStyles.textStyleBold13.copyWith(
                  color: black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: " *",
                style: TextStyles.textStyleBold13.copyWith(color: red),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDaysChips(BuildContext context, TeacherRegistrationCubit cubit) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.width / 30),
      width: double.infinity,
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        alignment: WrapAlignment.center,
        children: _daysOfWeek.map((dayKey) {
          final isSelected = cubit.selectedDays.contains(dayKey);
          return InkWell(
            onTap: () => cubit.toggleDay(dayKey),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? orangeBold : white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? orangeBold : black.withOpacity(0.1),
                ),
              ),
              child: Text(
                tr(dayKey),
                style: TextStyles.textStyleNormal12.copyWith(
                  color: isSelected ? white : black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTimeRangePickers(
    BuildContext context,
    TeacherRegistrationCubit cubit,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width / 30),
      child: Row(
        children: [
          Expanded(
            child: _TimePicker(
              label: tr("from_hour"),
              value: cubit.fromTime,
              onTap: () => _pickTime(context, true, cubit),
            ),
          ),
          SizedBox(width: context.width / 30),
          Expanded(
            child: _TimePicker(
              label: tr("to_hour"),
              value: cubit.toTime,
              onTap: () => _pickTime(context, false, cubit),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailabilityNotice(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.width / 20,
        vertical: context.height / 80,
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: orangeBold, size: 16),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              tr("availability_notice"),
              style: TextStyles.textStyleNormal11.copyWith(color: orangeBold),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickTime(
    BuildContext context,
    bool isFromTime,
    TeacherRegistrationCubit cubit,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && context.mounted) {
      final hour = picked.hour.toString().padLeft(2, '0');
      final minute = picked.minute.toString().padLeft(2, '0');
      final formattedTime = "$hour:$minute";
      if (isFromTime) {
        cubit.selectFromTime(formattedTime);
      } else {
        cubit.selectToTime(formattedTime);
      }
    }
  }
}

class _TimePicker extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _TimePicker({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(38.0),
          border: Border.all(color: black.withOpacity(.1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textScaler: const TextScaler.linear(1.0),
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: label,
                        style: TextStyles.textStyleBold12.copyWith(
                          color: black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: " *",
                        style: TextStyles.textStyleBold12.copyWith(color: red),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value.isNotEmpty ? value : "--:--",
                  style: TextStyles.textStyleNormal12.copyWith(
                    color: value.isNotEmpty ? black : grey2,
                  ),
                ),
              ],
            ),
            const Icon(Icons.access_time, color: orangeBold, size: 20),
          ],
        ),
      ),
    );
  }
}
