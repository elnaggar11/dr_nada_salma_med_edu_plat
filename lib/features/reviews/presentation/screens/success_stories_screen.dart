import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/success_stories/success_stories_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/widgets/success_stories_item.dart';
import 'package:dr_nada_salma_med_edu_plat/features/shimmer/success_stories/success_stories_shimmer_vertical_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuccessStoriesScreen extends StatefulWidget {
  final String type;

  const SuccessStoriesScreen({super.key, required this.type});

  @override
  State<SuccessStoriesScreen> createState() => _SuccessStoriesScreenState();
}

class _SuccessStoriesScreenState extends State<SuccessStoriesScreen> {
  @override
  void initState() {
    context.read<SuccessStoriesCubit>().getSuccessStories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        children: [
          ?widget.type == "stories"
              ? customAppBar(
                  appBarInd: 0,
                  widget: SizedBox(),
                  status: false,
                  title: tr("success_stories"),
                  index: 1,
                  context: context,
                )
              : SizedBox(),
          Expanded(
            child: BlocBuilder<SuccessStoriesCubit, SuccessStoriesState>(
              builder: (context, state) {
                return context.read<SuccessStoriesCubit>().loading == true
                    ? SuccessStoriesShimmerVerticalList()
                    : ListView.builder(
                        itemCount: context
                            .read<SuccessStoriesCubit>()
                            .successStoriesResponse!
                            .data!
                            .length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        addAutomaticKeepAlives: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) => SuccessStoriesItem(
                          data: context
                              .read<SuccessStoriesCubit>()
                              .successStoriesResponse!
                              .data![index],
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
