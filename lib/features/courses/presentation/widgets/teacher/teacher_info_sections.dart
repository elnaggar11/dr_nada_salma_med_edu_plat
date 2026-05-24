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
          height: 25,
          decoration: BoxDecoration(
            color: context.primaryColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 10),
        Text(title, style: context.boldText.copyWith(fontSize: 18)),
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
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const InfoSectionTitle(title: "عن المدرس"),
          SizedBox(height: 15),
          Text(
            bio,
            style: context.regularText.copyWith(
              fontSize: 14,
              height: 1.6,
              color: const Color(0xFF4A4A4A),
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const InfoSectionTitle(title: "من هم الطلاب الذين يرغب في تدريسهم؟"),
          SizedBox(height: 15),
          _buildAudienceCard(
            context,
            "جنس الطلاب",
            audience.gender ?? "جميع الفئات",
            Icons.people_outline,
          ),
          SizedBox(height: 10),
          _buildAudienceCard(
            context,
            "مستوى الطلاب",
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
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFFFF6B35), size: 22),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: context.regularText.copyWith(
                    fontSize: 12,
                    color: context.hintColor,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  value,
                  style: context.boldText.copyWith(
                    fontSize: 14,
                    color: context.primaryColor,
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const InfoSectionTitle(title: "خبرات التدريس"),
          SizedBox(height: 15),
          ...experiences
              .map((exp) => _buildExperienceCard(context, exp))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildExperienceCard(BuildContext context, TeachingExperience exp) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    exp.country ?? "",
                    style: context.boldText.copyWith(fontSize: 16),
                  ),
                  if (exp.countryFlag != null)
                    Text(exp.countryFlag!, style: TextStyle(fontSize: 24)),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: const Color(0xFFFF6B35),
                  ),
                  SizedBox(width: 5),
                  Text(
                    exp.duration ?? "",
                    style: context.mediumText.copyWith(
                      fontSize: 13,
                      color: const Color(0xFFFF6B35),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                exp.description ?? "",
                style: context.regularText.copyWith(
                  fontSize: 13,
                  color: context.hintColor,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 20,
            right: 20,
            child: Container(
              height: 3,
              decoration: BoxDecoration(
                color: const Color(0xFFFF6B35).withOpacity(0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const InfoSectionTitle(title: "الأوقات المتاحة"),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFF0F0F0)),
            ),
            child: Column(
              children: availability.entries.map((entry) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        entry.key,
                        style: context.boldText.copyWith(fontSize: 14),
                      ),
                      Text(
                        entry.value.join(" - "),
                        style: context.mediumText.copyWith(
                          fontSize: 14,
                          color: context.primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
