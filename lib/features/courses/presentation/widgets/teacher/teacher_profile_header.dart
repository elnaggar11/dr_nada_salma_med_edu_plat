import 'package:easy_localization/easy_localization.dart';
import '../../../../../gen/locale_keys.g.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/extensions.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/teacher/teacher_detail_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../injection_container/injection_container.dart';
import '../../../../profiles/presentation/cubit/profile/profile_cubit.dart';

class TeacherProfileHeader extends StatelessWidget {
  final TeacherDetail teacher;

  const TeacherProfileHeader({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    bool isTargetUser = false;
    try {
      final userId = sharedPreferences.getInt("user_id");
      final userEmail = sharedPreferences.getString("user_email");
      final userFullName = sharedPreferences.getString(
        "user_fullName",
      );
      if (userId == 311 || 
          userId == 7 ||
          userEmail == "abdoshams2005@gmail.com" ||
          userEmail == "tamerahmed00009@gmail.com" ||
          userFullName == "Abdo Shamss" ||
          userFullName == "ebrahim reda") {
        isTargetUser = true;
      }
    } catch (_) {}

    if (!isTargetUser) {
      try {
        final profileCubit = BlocProvider.of<ProfileCubit>(
          context,
          listen: false,
        );
        final profile = profileCubit.profileResponse;
        if (profile != null && profile.data != null) {
          if (profile.data!.id == 311 ||
              profile.data!.id == 7 ||
              profile.data!.email == "abdoshams2005@gmail.com" ||
              profile.data!.email == "tamerahmed00009@gmail.com" ||
              profile.data!.fullName == "Abdo Shamss" ||
              profile.data!.fullName == "ebrahim reda") {
            isTargetUser = true;
          }
        }
      } catch (_) {}
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
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
          // Row for Avatar and Info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Teacher Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          teacher.name ?? "",
                          style: context.boldText.copyWith(
                            fontSize: 15,
                            color: const Color(0xFF355C7D),
                          ),
                        ),
                        if (teacher.isVerified ?? false) ...[
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.verified,
                            color: Colors.blue,
                            size: 20,
                          ),
                        ],
                      ],
                    ),
                    if (teacher.specializationTitle != null &&
                        teacher.specializationTitle!.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        teacher.specializationTitle!,
                        style: context.mediumText.copyWith(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                    if (teacher.subjects != null &&
                        teacher.subjects!.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: teacher.subjects!.map((subj) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8EEF3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              subj.name ?? "",
                              style: context.boldText.copyWith(
                                fontSize: 11,
                                color: const Color(0xFF355C7D),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          "${teacher.rating ?? 0.0}",
                          style: context.boldText.copyWith(
                            fontSize: 14,
                            color: const Color(0xFF355C7D),
                          ),
                        ),
                        Text(
                          " (${teacher.reviewsCount ?? 0})",
                          style: context.regularText.copyWith(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.location_on,
                          color: Colors.grey,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${teacher.country ?? ""}${teacher.city != null ? "، ${teacher.city}" : ""}",
                          style: context.regularText.copyWith(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Avatar
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: teacher.image ?? "",
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(color: Colors.grey[200]),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.person),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (!isTargetUser) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8FA),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      LocaleKeys.hourly_rate.tr(),
                      style: context.regularText.copyWith(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 16),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: " ${tr("sar")} ${teacher.hourlyPrice ?? 0.0}",
                            style: context.boldText.copyWith(
                              fontSize: 18,
                              color: const Color(0xFF355C7D),
                            ),
                          ),
                          TextSpan(
                            text: LocaleKeys.per_hour.tr(),
                            style: context.mediumText.copyWith(
                              fontSize: 13,
                              color: const Color(0xFFF06523),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
          const Divider(color: Color(0xFFF0F0F0)),
          const SizedBox(height: 16),
          // Statistics Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatColumn(
                context,
                LocaleKeys.languages.tr(),
                teacher.languages != null && teacher.languages!.isNotEmpty
                    ? teacher.languages!.join("، ")
                    : LocaleKeys.arabic.tr(),
              ),
              _buildStatColumn(
                context,
                LocaleKeys.students.tr(),
                "+${teacher.studentsCount ?? 0}",
              ),
              _buildStatColumn(
                context,
                LocaleKeys.experience.tr(),
                "+${teacher.experienceYears ?? 0}",
              ),
            ],
          ),
          if (teacher.shortBio != null || teacher.bio != null) ...[
            const SizedBox(height: 20),
            Text(
              teacher.shortBio ?? teacher.bio ?? "",
              style: context.regularText.copyWith(
                fontSize: 14,
                color: const Color(0xFF666666),
                height: 1.6,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatColumn(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: context.mediumText.copyWith(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: context.boldText.copyWith(
            fontSize: 15,
            color: const Color(0xFF355C7D),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
