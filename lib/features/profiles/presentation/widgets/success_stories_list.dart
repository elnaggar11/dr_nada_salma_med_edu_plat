import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/empty_course_widget.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/success_stories/success_stories_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/widgets/success_stories_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:dr_nada_salma_med_edu_plat/gen/locale_keys.g.dart';
import 'package:dr_nada_salma_med_edu_plat/injection_container/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuccessStoriesList extends StatelessWidget {
  SuccessStoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SuccessStoriesCubit>()..getSuccessStories(),
      child: BlocBuilder<SuccessStoriesCubit, SuccessStoriesState>(
        builder: (context, state) {
          if (state is SuccessStoriesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SuccessStoriesErrorState) {
            return Center(child: Text(state.message ?? "حدث خطأ ما"));
          } else if (state is SuccessStoriesSuccessState) {
            final list = state.successStoriesResponse?.data ?? [];
            if (list.isEmpty) {
              return Center(
                child: EmptyCourseWidget(title: LocaleKeys.empty_success_stories.tr()),
              );
            }
            return ListView.builder(
              itemCount: list.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              addAutomaticKeepAlives: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) =>
                  SuccessStoriesItem(data: list[index]),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

