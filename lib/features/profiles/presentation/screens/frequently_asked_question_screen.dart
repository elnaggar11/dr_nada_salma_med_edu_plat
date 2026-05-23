import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/frequently_cubit/frequently_asked_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/widgets/frequently_asked_question_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FrequentlyAskedQuestionScreen extends StatefulWidget {
  const FrequentlyAskedQuestionScreen({super.key});

  @override
  State<FrequentlyAskedQuestionScreen> createState() =>
      _FrequentlyAskedQuestionScreenState();
}

class _FrequentlyAskedQuestionScreenState
    extends State<FrequentlyAskedQuestionScreen> {
  @override
  void initState() {
    context.read<FrequentlyAskedCubit>().getFaqs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: customAppBar(
        appBarInd: 0,
        widget: SizedBox(),
        title: tr("frequently_asked_questions"),
        context: context,
        status: false,
      ),
      body: BlocBuilder<FrequentlyAskedCubit, FrequentlyAskedState>(
        builder: (context, state) {
          return SizedBox(
            child: BlocBuilder<FrequentlyAskedCubit, FrequentlyAskedState>(
              builder: (context, state) {
                return context.read<FrequentlyAskedCubit>().loading == true
                    ? SizedBox(child: SpinKitPulse(color: primary, size: 50))
                    : ListView.builder(
                        itemCount: context
                            .read<FrequentlyAskedCubit>()
                            .faqsResponse!
                            .data!
                            .length,
                        scrollDirection: Axis.vertical,
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            FrequentlyAskedQuestionItem(
                              controller: context
                                  .read<FrequentlyAskedCubit>()
                                  .faqsResponse!
                                  .data![index]
                                  .controller,
                              index: index,
                              faqsData: context
                                  .read<FrequentlyAskedCubit>()
                                  .faqsResponse!
                                  .data![index],
                            ),
                      );
              },
            ),
          );
        },
      ),
    );
  }
}
