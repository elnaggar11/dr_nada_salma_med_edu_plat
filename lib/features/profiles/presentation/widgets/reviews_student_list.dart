import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/widgets/reviews_student_item.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/cubit/course_reviews/course_reviews_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ReviewsStudentList extends StatelessWidget {
  const ReviewsStudentList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseReviewsCubit, CourseReviewsState>(
      builder: (context, state) {
        if (state.status == CourseReviewsRequestState.loading) {
          return const Center(
            child: SpinKitPulse(color: primary, size: 50),
          );
        } else if (state.status == CourseReviewsRequestState.error) {
          return Center(
            child: Text(state.message),
          );
        } else if (state.status == CourseReviewsRequestState.loaded) {
          final reviews = state.response?.data ?? [];
          if (reviews.isEmpty) {
            return const Center(
              child: Text("No reviews found"),
            );
          }
          return ListView.builder(
            itemCount: reviews.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            addAutomaticKeepAlives: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) =>
                ReviewsStudentItem(review: reviews[index]),
          );
        }
        return const SizedBox();
      },
    );
  }
}
