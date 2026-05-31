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
import '../../../../main.dart';
import '../../../profiles/presentation/cubit/profile/profile_cubit.dart';

class PrivateLessonsItem extends StatelessWidget {
  final Data data;

  const PrivateLessonsItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    bool isTargetUser = false;
    try {
      final userId = sharedPreferences.getInt("user_id");
      final userEmail = sharedPreferences.getString("user_email");
      final userFullName = sharedPreferences.getString("user_fullName");
      if (userId == 311 ||
          userId == 7 ||
          userEmail == "abdoshams2005@gmail.com" ||
          userEmail == "tamerahmed00009@gmail.com" ||
          userFullName == "Abdo Shamss" ||
          userFullName == "ebrahim reda") {
        isTargetUser = true;
      }
    } catch (_) {}

    if (!isTargetUser) {
      try {
        final profileCubit = BlocProvider.of<ProfileCubit>(
          context,
          listen: false,
        );
        final profile = profileCubit.profileResponse;
        if (profile != null && profile.data != null) {
          if (profile.data!.id == 311 ||
              profile.data!.id == 7 ||
              profile.data!.email == "abdoshams2005@gmail.com" ||
              profile.data!.email == "tamerahmed00009@gmail.com" ||
              profile.data!.fullName == "Abdo Shamss" ||
              profile.data!.fullName == "ebrahim reda") {
            isTargetUser = true;
          }
        }
      } catch (_) {}
    }

    return BlocBuilder<BottomBarCubit, BottomBarState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            CoursesDetailsParams params = CoursesDetailsParams(
              slug: data.slug,
              status: "",
            );
            context.pushNamed(name: emptyPrivateLessons);
          },
          child: Container(
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
                    Text(
                      "+${data.points} points",
                      style: TextStyles.textStyleBold10.copyWith(
                        fontWeight: FontWeight.w600,
                        color: primary,
                      ),
                      textScaler: TextScaler.linear(1),
                    ),
                  ],
                ),
                SizedBox(height: context.height / 80),
                Text(
                  "${data.title} !",
                  style: TextStyles.textStyleBold16.copyWith(
                    fontWeight: FontWeight.w800,
                    color: orangeBold,
                  ),
                  textScaler: TextScaler.linear(1),
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
                if (!isTargetUser)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "\$${data.price}",
                        style: TextStyles.textStyleBold16.copyWith(
                          color: orangeBold,
                        ),
                        textScaler: TextScaler.linear(1),
                      ),
                      SizedBox(width: context.width / 20),
                      Text(
                        "\$${data.priceAfterDiscount ?? 0}",
                        style: TextStyles.textStyleNormal12.copyWith(
                          color: grey1,
                          fontWeight: FontWeight.w500,
                        ),
                        textScaler: TextScaler.linear(1),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
