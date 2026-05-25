import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/fade_button.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/network_image_handler.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:dr_nada_salma_med_edu_plat/gen/locale_keys.g.dart';
import 'package:flutter/material.dart';

class PrivateLessonItem extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final List<String> tags;
  final String? discount;
  final VoidCallback onDetailsPressed;

  const PrivateLessonItem({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.tags,
    this.discount,
    required this.onDetailsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image Section
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: NetWorkImageHandler(
              image: image,
              width: double.infinity,
              height: context.height / 4,
            ),
          ),

          SizedBox(height: 16),

          // Discount Badge Row (Example)
          if (discount != null && discount!.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.percent, size: 16, color: primary),
                      SizedBox(width: 4),
                      Text(
                        discount!,
                        style: TextStyles.textStyleBold12.copyWith(
                          color: primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],

          // Title
          Text(
            title,
            style: TextStyles.textStyleBold18.copyWith(color: primary),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 12),

          // Description
          Text(
            description,
            style: TextStyles.textStyleNormal12.copyWith(color: grey1),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: 16),

          // Tags
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: tags.map((tag) => _buildTag(tag)).toList(),
          ),

          SizedBox(height: 24),

          // Detail Button
          FadeColorButton(
            btnTitle: LocaleKeys.view_details.tr(),
            buttonColor: primary,
            onButtonPressed: onDetailsPressed,
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: orangeBold.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyles.textStyleBold12.copyWith(color: orangeBold),
      ),
    );
  }
}
