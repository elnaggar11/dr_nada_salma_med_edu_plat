import 'package:cached_network_image/cached_network_image.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
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
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.width * 0.05,
        vertical: context.height * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const InfoSectionTitle(title: "تقييم المدرس"),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: context.width * 0.06,
                  ),
                  SizedBox(width: context.width * 0.02),
                  Text(
                    "$overallRating",
                    style: context.boldText.copyWith(
                      fontSize: context.width * 0.045,
                      color: context.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: context.height * 0.025),
          ...reviews
              .map((review) => _buildReviewItem(context, review))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildReviewItem(BuildContext context, TeacherReview review) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.height * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey[200],
                backgroundImage: review.userImage != null
                    ? CachedNetworkImageProvider(review.userImage!)
                    : null,
                child: review.userImage == null
                    ? const Icon(Icons.person, color: Colors.grey)
                    : null,
              ),
              SizedBox(width: 15),
              // Name and Time
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName ?? "مستخدم",
                      style: context.boldText.copyWith(fontSize: 15),
                    ),
                    Text(
                      review.date ?? "",
                      style: context.regularText.copyWith(
                        fontSize: 12,
                        color: context.hintColor,
                      ),
                    ),
                  ],
                ),
              ),
              // Stars
              RatingBarIndicator(
                rating: review.rating ?? 0,
                itemBuilder: (context, index) =>
                    const Icon(Icons.star, color: Colors.amber),
                itemCount: 5,
                itemSize: 14,
              ),
            ],
          ),
          SizedBox(height: 15),
          Text(
            review.comment ?? "",
            style: context.regularText.copyWith(
              fontSize: 14,
              height: 1.5,
              color: const Color(0xFF5A5A5A),
            ),
          ),
          if (reviews.indexOf(review) != reviews.length - 1) ...[
            SizedBox(height: 20),
            const Divider(color: Color(0xFFF0F0F0), thickness: 1),
          ],
        ],
      ),
    );
  }
}
