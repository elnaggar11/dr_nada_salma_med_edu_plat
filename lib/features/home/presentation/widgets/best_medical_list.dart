import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/bottom_bar/presentation/cubit/bottom_bar_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/public_courses_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/widgets/best_medical_course_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BestMedicalList extends StatelessWidget {
  final PublicCoursesResponse? publicCoursesResponse;

  const BestMedicalList({super.key, required this.publicCoursesResponse});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: context.width / 30,
        right: context.width / 30,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: AlwaysScrollableScrollPhysics(),
        child: publicCoursesResponse!.data!.isEmpty
            ? SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: customSvg(
                        name: course,
                        width: context.width / 8,
                        height: context.width / 8,
                      ),
                    ),
                    Text(
                      tr("no_courses"),
                      style: TextStyles.textStyleBold15.copyWith(
                        color: primary,
                      ),
                      textScaler: TextScaler.linear(1),
                    ),
                  ],
                ),
              )
            : Row(
                children: publicCoursesResponse!.data!
                    .map(
                      (e) => BlocBuilder<BottomBarCubit, BottomBarState>(
                        builder: (context, state) {
                          return BestMedicalItem(data: e);
                        },
                      ),
                    )
                    .toList(),
              ),
      ),
    );
  }
}
