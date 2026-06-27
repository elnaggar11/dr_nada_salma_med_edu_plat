import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/favourite_button/favourite_button.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/network_image_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/presentation/cubit/favourite_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_details_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/public_courses_response.dart';
import 'package:dr_nada_salma_med_edu_plat/injection_container/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:easy_localization/easy_localization.dart';

class BestMedicalItem extends StatelessWidget {
  final Data data;

  const BestMedicalItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CoursesDetailsParams params = CoursesDetailsParams(
          slug: data.slug,
          status: "",
        );
        context.pushNamed(name: courseDetailsSc, args: params);
      },
      child: Container(
        color: white,
        margin: EdgeInsets.only(left: 5, right: 5),
        width: context.width / 1.6,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: NetWorkImageHandler(
                    image: data.image!,
                    width: context.width / 1.6,
                    height: context.height / 4.3,
                  ),
                ),
                BlocProvider(
                  create: (context) => sl<FavouriteCubit>(),
                  child: FavouriteButton(
                    isFavourite: data.favorited,
                    courseId: data.id.toString(),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.height / 50),
            Row(
              children: [
                Text(
                  "${data.categoryName}",
                  style: TextStyles.textStyleBold10.copyWith(
                    fontWeight: FontWeight.w600,
                    color: primary,
                  ),
                  textScaler: TextScaler.linear(1),
                ),
                SizedBox(width: context.width / 20),
                /* Text("+${data.points} ${tr("points")}",style: TextStyles.textStyleBold10
                  .copyWith(fontWeight: FontWeight.w600,color: primary)
                ,textScaler: TextScaler.linear(1),)*/
              ],
            ),
            SizedBox(height: context.height / 80),
            Text(
              data.title.toString(),
              style: TextStyles.textStyleBold16.copyWith(
                fontWeight: FontWeight.w800,
                color: orangeBold,
              ),
              maxLines: 1,
              textScaler: TextScaler.linear(1),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: context.height / 100),
            Text(
              "– ${data.totalHours}",
              style: TextStyles.textStyleBold16.copyWith(
                fontWeight: FontWeight.w800,
                color: orangeBold,
              ),
              textScaler: TextScaler.linear(1),
            ),
            SizedBox(height: context.height / 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${data.averageRating}",
                  style: TextStyles.textStyleBold12.copyWith(
                    fontWeight: FontWeight.w600,
                    color: primary,
                  ),
                  textScaler: TextScaler.linear(1),
                ),
                SizedBox(width: context.width / 60),
                RatingBarIndicator(
                  rating: double.parse(data.averageRating.toString()),
                  itemSize: 15,
                  itemCount: 5,
                  itemBuilder: (context, index) =>
                      customSvg(name: star, color: gold),
                ),
                SizedBox(width: context.width / 50),
                Text(
                  "(${data.reviewsCount})",
                  style: TextStyles.textStyleNormal12.copyWith(
                    color: grey1,
                    fontWeight: FontWeight.w300,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textScaler: TextScaler.linear(1),
                ),
              ],
            ),
            SizedBox(height: context.height / 80),
            if (data.buttonActions?.viewReviews == true)
              InkWell(
                onTap: () {
                  context.pushNamed(name: reviewsSc, args: {
                    "course_id": data.id,
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.all(Radius.circular(38)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      customSvg(name: review, color: white, height: 16),
                      SizedBox(width: 8),
                      Text(
                        tr("view_reviews"),
                        style: TextStyles.textStyleNormal10.copyWith(
                          fontWeight: FontWeight.w500,
                          color: white,
                        ),
                        textScaler: TextScaler.linear(1),
                      ),
                    ],
                  ),
                ),
              ),
            if (data.buttonActions?.viewReviews == true)
              SizedBox(height: context.height / 80),
            /*   Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("\$${data.priceAfterDiscount ?? 0}",style: TextStyles.textStyleBold16.copyWith
                  (color: orangeBold,),
                  textScaler: TextScaler.linear(1),),
                SizedBox(width: context.width/20,),
                Text("\$ ${data.price ?? 0}",style: TextStyles.textStyleNormal12.copyWith
                  (color: grey1,fontWeight: FontWeight.w500)
                  ,textScaler: TextScaler.linear(1),),
            ],)*/
          ],
        ),
      ),
    );
  }
}
