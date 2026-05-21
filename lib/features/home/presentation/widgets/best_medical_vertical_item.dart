import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/favourite_button/favourite_button.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/network_image_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/bottom_bar/presentation/cubit/bottom_bar_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/presentation/cubit/favourite_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_details_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/public_courses_response.dart';
import 'package:dr_nada_salma_med_edu_plat/injection_container/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BestMedicalVerticalItem extends StatelessWidget {
  const BestMedicalVerticalItem({
    super.key,
    required this.typeIndex,
    required this.data,
  });
  final int typeIndex;
  final Data data;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomBarCubit, BottomBarState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            CoursesDetailsParams params = CoursesDetailsParams(
              slug: data.slug,
              status: "",
            );
            context.pushNamed(name: courseDetailsSc, args: params);
          },
          child: Container(
            color: Colors.transparent,
            margin: EdgeInsets.all(7),
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: NetWorkImageHandler(
                        image: data.image,
                        width: context.width / 2.3,
                        height: context.width / 2.7,
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
                SizedBox(width: context.width / 50),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                          /*   Text("+${data.points} points",style: TextStyles.textStyleBold10
                        .copyWith(fontWeight: FontWeight.w600,color: primary)
                      ,textScaler: TextScaler.linear(1),),*/
                        ],
                      ),

                      SizedBox(height: context.height / 200),

                      Text(
                        "${data.title}",
                        style: TextStyles.textStyleBold16.copyWith(
                          fontWeight: FontWeight.w800,
                          color: orangeBold,
                        ),
                        textScaler: TextScaler.linear(1),
                      ),
                      SizedBox(height: context.height / 140),
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
                          Flexible(
                            child: Text(
                              "(${data.reviewsCount})",
                              style: TextStyles.textStyleNormal12.copyWith(
                                color: grey1,
                                fontWeight: FontWeight.w300,
                              ),
                              overflow: TextOverflow.ellipsis,
                              textScaler: TextScaler.linear(1),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.height / 80),
                      /* Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text("\$${data.priceAfterDiscount ?? 0}",style: TextStyles.textStyleBold16.copyWith
                          (color: orangeBold,),
                          textScaler: TextScaler.linear(1),),
                      ),
                      SizedBox(width: context.width/20,),
                      Flexible(
                        child: Text("\$${data.price ?? 0}",style: TextStyles.textStyleNormal12.copyWith
                          (color: grey1,fontWeight: FontWeight.w500)
                          ,textScaler: TextScaler.linear(1),),
                      ),
                    ],)*/
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
