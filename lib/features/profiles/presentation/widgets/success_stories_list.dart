import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/success_stories_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/widgets/success_stories_item.dart';
import 'package:flutter/cupertino.dart';

class SuccessStoriesList extends StatelessWidget {
  List<String> imgList = [
    profile1,
    profile2,
    profile1,
    profile2,
    profile1,
    profile2,
    profile1,
  ];

  SuccessStoriesList({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        itemCount: imgList.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        addAutomaticKeepAlives: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) => SuccessStoriesItem(data: Data()),
      ),
    );
  }
}
