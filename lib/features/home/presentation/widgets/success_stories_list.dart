import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/success_stories_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/widgets/success_stories_item.dart';
import 'package:flutter/widgets.dart';

class SuccessStoriesList extends StatelessWidget {
  List<String> imgList = [profile1, profile2];
  final SuccessStoriesResponse successStoriesResponse;

  SuccessStoriesList({super.key, required this.successStoriesResponse});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: context.width / 50,
        right: context.width / 50,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: ClampingScrollPhysics(),
        child: Row(
          children: successStoriesResponse.data!
              .map((e) => SuccessStoriesItem(data: e))
              .toList(),
        ),
      ),
    );
  }
}
