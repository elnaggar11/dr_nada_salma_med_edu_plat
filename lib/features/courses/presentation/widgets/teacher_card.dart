import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/network_image_handler.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TeacherCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String image;
  final double rating;
  final String experience;
  final int studentCount;
  final String price;
  final bool isVerified;
  final String slug;
  final VoidCallback onBookPressed;

  const TeacherCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.image,
    required this.rating,
    required this.experience,
    required this.studentCount,
    required this.price,
    required this.slug,
    this.isVerified = true,
    required this.onBookPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, "teacherDetailSc", arguments: slug),
      child: Container(
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Section with badges
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                  child: NetWorkImageHandler(
                    image: image,
                    width: double.infinity,
                    height: context.height / 5,
                  ),
                ),
                // Rating Badge
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Text(
                          rating.toString(),
                          style: TextStyles.textStyleBold10.copyWith(
                            color: primary,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.star, color: Colors.amber, size: 14),
                      ],
                    ),
                  ),
                ),
                // Experience Badge
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: primary.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      experience,
                      style: TextStyles.textStyleBold10.copyWith(color: white),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  // Name
                  Text(
                    name,
                    style: TextStyles.textStyleBold16.copyWith(color: primary),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  // Specialty
                  Text(
                    specialty,
                    style: TextStyles.textStyleNormal12.copyWith(color: grey1),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 16),

                  // Info Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Verified
                      _buildInfoItem(
                        icon: Icons.verified_outlined,
                        label: tr("verified"),
                        color: primary,
                      ),
                      // Students
                      _buildInfoItem(
                        icon: Icons.school_outlined,
                        label: "+$studentCount ${tr("student")}",
                        color: orangeBold,
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Footer Row: Price and Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr("starts_from"),
                            style: TextStyles.textStyleNormal10.copyWith(
                              color: grey1,
                            ),
                          ),
                          Text(
                            "$price ${tr("sar")}",
                            style: TextStyles.textStyleBold14.copyWith(
                              color: primary,
                            ),
                          ),
                        ],
                      ),
                      // Booking Button
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: onBookPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                          ),
                          child: Text(
                            tr("book_now"),
                            style: TextStyles.textStyleBold12.copyWith(
                              color: white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyles.textStyleNormal10.copyWith(color: grey1)),
      ],
    );
  }
}
