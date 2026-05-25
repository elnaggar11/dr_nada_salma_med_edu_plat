import 'package:easy_localization/easy_localization.dart';
import '../../../../../gen/locale_keys.g.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/extensions.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/teacher/teacher_detail_response.dart';
import 'package:flutter/material.dart';


class InfoSectionTitle extends StatelessWidget {
  final String title;
  const InfoSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: const Color(0xFFF06523), // Orange bar
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: context.boldText.copyWith(
            fontSize: 18,
            color: const Color(0xFF355C7D),
          ),
        ),
      ],
    );
  }
}

class TeacherAboutSection extends StatelessWidget {
  final String bio;
  const TeacherAboutSection({super.key, required this.bio});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoSectionTitle(title: LocaleKeys.about_teacher.tr()),
          const SizedBox(height: 16),
          Text(
            bio,
            style: context.mediumText.copyWith(
              fontSize: 15,
              height: 1.8,
              color: const Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }
}

class TargetAudienceSection extends StatelessWidget {
  final TargetAudience audience;
  const TargetAudienceSection({super.key, required this.audience});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoSectionTitle(title: LocaleKeys.target_students.tr()),
          const SizedBox(height: 20),
          _buildAudienceCard(
            context,
            LocaleKeys.students_gender.tr(),
            audience.gender ?? LocaleKeys.all_genders.tr(),
            Icons.people_outline,
          ),
          const SizedBox(height: 12),
          _buildAudienceCard(
            context,
            LocaleKeys.students_level.tr(),
            (audience.levels ?? []).join("، "),
            Icons.school_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildAudienceCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: const Color(0xFFF06523), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: context.mediumText.copyWith(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: context.boldText.copyWith(
                    fontSize: 16,
                    color: const Color(0xFF355C7D),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TeachingExperienceSection extends StatelessWidget {
  final List<TeachingExperience> experiences;
  const TeachingExperienceSection({super.key, required this.experiences});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoSectionTitle(title: LocaleKeys.teaching_experience.tr()),
          const SizedBox(height: 16),
          ...experiences
              .map((exp) => _buildExperienceCard(context, exp))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildExperienceCard(BuildContext context, TeachingExperience exp) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(20),
        border: const Border(
          bottom: BorderSide(
            color: Color(0xFFF06523), // Vibrant Orange bottom border
            width: 3,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: The details (Aligned to the start in RTL)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exp.country ?? "",
                  style: context.boldText.copyWith(
                    fontSize: 16,
                    color: const Color(0xFF355C7D),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 16,
                      color: Color(0xFFF06523),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      exp.duration ?? "",
                      style: context.boldText.copyWith(
                        fontSize: 13,
                        color: const Color(0xFFF06523),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  exp.description ?? "",
                  style: context.mediumText.copyWith(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Right: Flag Emoji / Flag Icon
          if (exp.countryFlag != null)
            Text(
              exp.countryFlag!,
              style: const TextStyle(fontSize: 32),
            ),
        ],
      ),
    );
  }
}

class AvailabilitySection extends StatelessWidget {
  final Map<String, List<String>> availability;
  const AvailabilitySection({super.key, required this.availability});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoSectionTitle(title: LocaleKeys.available_times.tr()),
          const SizedBox(height: 16),
          Column(
            children: availability.entries.map((entry) {
              final isLast = entry.key == availability.entries.last.key;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          entry.key,
                          style: context.boldText.copyWith(
                            fontSize: 15,
                            color: const Color(0xFF355C7D),
                          ),
                        ),
                        Text(
                          entry.value.join(" - "),
                          style: context.boldText.copyWith(
                            fontSize: 15,
                            color: const Color(0xFF666666),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isLast) const Divider(color: Color(0xFFF0F0F0), height: 1),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class TeacherTimeSlotsSection extends StatelessWidget {
  final List<TeacherTimeSlot> timeSlots;
  final TeacherTimeSlot? selectedSlot;
  final ValueChanged<TeacherTimeSlot>? onSlotSelected;

  const TeacherTimeSlotsSection({
    super.key,
    required this.timeSlots,
    this.selectedSlot,
    this.onSlotSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoSectionTitle(title: LocaleKeys.available_times.tr()),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: timeSlots.map((slot) {
              final isSelected = selectedSlot?.id == slot.id;
              final dateText = slot.date == null
                  ? ""
                  : DateFormat('yyyy/MM/dd').format(slot.date!);
              final timeText = "${slot.startTime ?? ""} - ${slot.endTime ?? ""}";

              return GestureDetector(
                onTap: () => onSlotSelected?.call(slot),
                child: Container(
                  width: (MediaQuery.of(context).size.width - 60) / 2,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFF06523).withOpacity(0.08)
                        : const Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFFF06523)
                          : const Color(0xFFF9D0BA),
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            color: Color(0xFFF06523),
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              dateText,
                              style: context.boldText.copyWith(
                                fontSize: 13,
                                color: const Color(0xFF355C7D),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time_rounded,
                            color: Color(0xFFF06523),
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              timeText,
                              style: context.mediumText.copyWith(
                                fontSize: 13,
                                color: const Color(0xFF666666),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

