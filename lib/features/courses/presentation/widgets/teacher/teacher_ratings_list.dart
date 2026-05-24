import 'package:easy_localization/easy_localization.dart';
import '../../../../../gen/locale_keys.g.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/extensions.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/teacher/teacher_detail_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/teacher/teacher_info_sections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TeacherRatingsList extends StatelessWidget {
  final double overallRating;
  final List<TeacherReview> reviews;

  const TeacherRatingsList({
    super.key,
    required this.overallRating,
    required this.reviews,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InfoSectionTitle(title: LocaleKeys.teacher_rating.tr()),
              Row(
                children: [
                  Text(
                    overallRating.toStringAsFixed(2),
                    style: context.boldText.copyWith(
                      fontSize: 18,
                      color: const Color(0xFFF06523),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.star, color: Color(0xFFF06523), size: 24),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...reviews
              .map((review) => _buildReviewItem(context, review))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildReviewItem(BuildContext context, TeacherReview review) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar
              CircleAvatar(
                radius: 24,
                backgroundColor: const Color(0xFFF0F0F0),
                backgroundImage: review.userImage != null
                    ? CachedNetworkImageProvider(review.userImage!)
                    : null,
                child: review.userImage == null
                    ? const Icon(Icons.person, color: Colors.grey, size: 24)
                    : null,
              ),
              const SizedBox(width: 12),
              // Name and Time
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName ?? LocaleKeys.user.tr(),
                      style: context.boldText.copyWith(
                        fontSize: 16,
                        color: const Color(0xFF355C7D),
                      ),
                    ),
                    Text(
                      review.date ?? "",
                      style: context.mediumText.copyWith(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              // Stars
              RatingBarIndicator(
                rating: review.rating ?? 0,
                itemBuilder: (context, index) =>
                    const Icon(Icons.star, color: Color(0xFFFFB100)),
                itemCount: 5,
                itemSize: 18,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            review.comment ?? "",
            style: context.mediumText.copyWith(
              fontSize: 15,
              height: 1.8,
              color: const Color(0xFF666666),
            ),
          ),
          if (reviews.indexOf(review) != reviews.length - 1) ...[
            const SizedBox(height: 20),
            const Divider(color: Color(0xFFF0F0F0), thickness: 1),
          ],
        ],
      ),
    );
  }
}
