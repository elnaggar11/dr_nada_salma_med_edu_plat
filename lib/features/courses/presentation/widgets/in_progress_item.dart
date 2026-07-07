import 'dart:math' as math;

import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/favourite_button/favourite_button.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/network_image_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/in_person_training_info_card.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/presentation/cubit/favourite_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_details_params.dart';
import 'package:dr_nada_salma_med_edu_plat/injection_container/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class InProgressItem extends StatelessWidget {
  final String title;
  final String image;
  final String points;
  final String progress;
  final String slug;
  final dynamic favorited;
  final dynamic id;
  final String status;
  final String totalHours;
  final String categoryName;
  final String lectureNum;
  final String sectionNum;
  final bool? lecturesAreOpen;
  final bool showTrainingInfo;

  const InProgressItem({
    super.key,
    required this.title,
    required this.image,
    required this.points,
    required this.progress,
    required this.slug,
    required this.favorited,
    required this.id,
    required this.status,
    required this.totalHours,
    required this.categoryName,
    required this.lectureNum,
    required this.sectionNum,
    required this.lecturesAreOpen,
    this.showTrainingInfo = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (status == 'completed') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(
                "لقد اكتمل الكورس بالفعل",
                style: TextStyles.textStyleNormal13.copyWith(color: white),
                textScaler: TextScaler.linear(1),
              ),
            ),
          );
        } else {
          CoursesDetailsParams params = CoursesDetailsParams(
            slug: slug,
            status: status,
          );
          context.pushNamed(name: courseDetailsSc, args: params);
        }
      },
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.all(9),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: NetWorkImageHandler(
                        image: image,
                        width: context.width / 3.2,
                        height: context.width / 3.5,
                      ),
                    ),
                    BlocProvider(
                      create: (context) => sl<FavouriteCubit>(),
                      child: FavouriteButton(
                        isFavourite: favorited == true,
                        courseId: id.toString(),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: context.width / 50),
                Flexible(
                  fit: FlexFit.loose,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            categoryName,
                            style: TextStyles.textStyleBold10.copyWith(
                              fontWeight: FontWeight.w600,
                              color: primary,
                            ),
                            textScaler: TextScaler.linear(1),
                          ),
                          SizedBox(width: context.width / 20),
                          Text(
                            "+$points points",
                            style: TextStyles.textStyleBold10.copyWith(
                              fontWeight: FontWeight.w600,
                              color: primary,
                            ),
                            textScaler: TextScaler.linear(1),
                          ),
                        ],
                      ),

                      SizedBox(height: context.height / 110),

                      Text(
                        title,
                        style: TextStyles.textStyleBold16.copyWith(
                          fontWeight: FontWeight.w800,
                          color: orangeBold,
                        ),
                        textScaler: TextScaler.linear(1),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: context.height / 120),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              "$sectionNum sections",
                              style: TextStyles.textStyleBold10.copyWith(
                                color: primary,
                                fontWeight: FontWeight.w600,
                              ),
                              textScaler: TextScaler.linear(1),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),

                          customSvg(name: elipse),
                          Flexible(
                            child: Text(
                              "$lectureNum lectures",
                              style: TextStyles.textStyleNormal10.copyWith(
                                color: primary,
                                fontWeight: FontWeight.w600,
                              ),
                              textScaler: TextScaler.linear(1),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          customSvg(name: elipse),
                          Flexible(
                            child: Text(
                              "",
                              style: TextStyles.textStyleNormal10.copyWith(
                                color: primary,
                                fontWeight: FontWeight.w600,
                              ),
                              textScaler: TextScaler.linear(1),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (showTrainingInfo) ...[
              SizedBox(height: context.height / 60),
              const InPersonTrainingInfoCard(),
            ],
            SizedBox(height: context.height / 50),
            Row(
              children: [
                status == 'completed'
                    ? const SizedBox()
                    : status == 'ended'
                        ? InkWell(
                            onTap: () {
                              context.pushNamed(name: reviewsSc, args: {
                                "course_id": id,
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(
                                left: context.width / 30,
                                right: context.width / 30,
                                top: context.height / 60,
                                bottom: context.height / 60,
                              ),
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.all(Radius.circular(38)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(23),
                                      ),
                                    ),
                                    child: customSvg(name: review, color: primary),
                                  ),
                                  SizedBox(width: context.width / 60),
                                  Text(
                                    tr("view_reviews"),
                                    style: TextStyles.textStyleNormal10.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: white,
                                    ),
                                    textScaler: TextScaler.linear(1),
                                  ),
                                  SizedBox(width: context.width / 60),
                                  context.locale.languageCode == "ar"
                                      ? Transform.rotate(
                                          angle: 180 * math.pi / 180,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: customSvg(name: arrowRight),
                                          ),
                                        )
                                      : Container(
                                          alignment: Alignment.center,
                                          child: customSvg(name: arrowRight),
                                        ),
                                ],
                              ),
                            ),
                          )
                        : (lecturesAreOpen == true || lecturesAreOpen == null)
                            ? Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(
                                  left: context.width / 30,
                                  right: context.width / 30,
                                  top: context.height / 60,
                                  bottom: context.height / 60,
                                ),
                                decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.all(Radius.circular(38)),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(23),
                                        ),
                                      ),
                                      child: customSvg(name: carrier, color: primary),
                                    ),
                                    SizedBox(width: context.width / 60),
                                    Text(
                                      tr("keep_learning"),
                                      style: TextStyles.textStyleNormal10.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: white,
                                      ),
                                      textScaler: TextScaler.linear(1),
                                    ),
                                    SizedBox(width: context.width / 60),
                                    context.locale.languageCode == "ar"
                                        ? Transform.rotate(
                                            angle: 180 * math.pi / 180,
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: customSvg(name: arrowRight),
                                            ),
                                          )
                                        : Container(
                                            alignment: Alignment.center,
                                            child: customSvg(name: arrowRight),
                                          ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: context.width / 30,
                          right: context.width / 30,
                        ),
                        child: Text(
                          "$progress%",
                          style: TextStyles.textStyleNormal12.copyWith(
                            fontWeight: FontWeight.w600,
                            color: primary,
                          ),
                          textScaler: TextScaler.linear(1),
                        ),
                      ),
                      SizedBox(height: context.height / 80),
                      Container(
                        margin: EdgeInsets.only(
                          left: context.width / 28,
                          right: context.width / 28,
                        ),
                        child: LinearPercentIndicator(
                          percent: double.parse(progress.toString()) / 100,
                          barRadius: Radius.circular(6.0),
                          progressColor: primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
