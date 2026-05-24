import 'package:cached_network_image/cached_network_image.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/extensions.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/teacher/teacher_detail_response.dart';
import 'package:flutter/material.dart';

class TeacherProfileHeader extends StatelessWidget {
  final TeacherDetail teacher;

  const TeacherProfileHeader({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.width * 0.05,
        vertical: context.height * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                            fontSize: context.width * 0.055,
                          ),
                        ),
                        if (teacher.isVerified ?? false) ...[
                          SizedBox(width: context.width * 0.02),
                          Icon(
                            Icons.verified,
                            color: Colors.blue,
                            size: context.width * 0.05,
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: context.height * 0.01),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: context.width * 0.045,
                        ),
                        SizedBox(width: context.width * 0.01),
                        Text(
                          "${teacher.rating ?? 0.0}",
                          style: context.mediumText.copyWith(
                            fontSize: context.width * 0.035,
                          ),
                        ),
                        Text(
                          " (${teacher.reviewsCount ?? 0})",
                          style: context.regularText.copyWith(
                            fontSize: context.width * 0.035,
                            color: context.hintColor,
                          ),
                        ),
                        SizedBox(width: context.width * 0.04),
                        Icon(
                          Icons.location_on,
                          color: Colors.grey,
                          size: context.width * 0.045,
                        ),
                        SizedBox(width: context.width * 0.01),
                        Text(
                          "${teacher.country ?? ""}, ${teacher.city ?? ""}",
                          style: context.regularText.copyWith(
                            fontSize: context.width * 0.035,
                            color: context.hintColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Avatar
              Container(
                width: context.width * 0.2,
                height: context.width * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(context.width * 0.04),
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
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
          SizedBox(height: 20),
          // Price Box
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F8FA),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "سعر الساعة",
                    style: context.regularText.copyWith(
                      fontSize: 12,
                      color: context.hintColor,
                    ),
                  ),
                  SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "\$${teacher.hourlyPrice ?? 0.0}",
                          style: context.boldText.copyWith(
                            fontSize: 20,
                            color: context.primaryColor,
                          ),
                        ),
                        TextSpan(
                          text: " /ساعة",
                          style: context.mediumText.copyWith(
                            fontSize: 14,
                            color: const Color(0xFFFF6B35),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
