import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/fade_button.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/teacher_registration/teacher_registration_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/widgets/register_section_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherSubjectsSection extends StatelessWidget {
  const TeacherSubjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TeacherRegistrationCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RegisterSectionHeader(
          title: tr("choose_subject"),
          icon: Icons.book_outlined,
        ),
        GestureDetector(
          onTap: () => _showSubjectsBottomSheet(context, cubit),
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: context.width / 30,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 18,
            ),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(38.0),
              border: Border.all(color: black.withOpacity(.1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        textScaler: const TextScaler.linear(1.0),
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: tr("choose_subject"),
                              style: TextStyles.textStyleBold13
                                  .copyWith(
                                    color: black,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            TextSpan(
                              text: " *",
                              style: TextStyles.textStyleBold13
                                  .copyWith(color: red),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      cubit.selectedSubjectIds.isEmpty
                          ? Text(
                              tr("choose_subjects"),
                              style: TextStyles.textStyleNormal12
                                  .copyWith(color: grey2),
                            )
                          : Wrap(
                              spacing: 6,
                              runSpacing: 4,
                              children: cubit.subjects
                                  .where(
                                    (e) => cubit
                                        .selectedSubjectIds
                                        .contains(e.id),
                                  )
                                  .map(
                                    (sub) => Container(
                                      padding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                      decoration: BoxDecoration(
                                        color: primary
                                            .withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(
                                              12,
                                            ),
                                      ),
                                      child: Text(
                                        sub.name ?? "",
                                        style: TextStyles
                                            .textStyleNormal11
                                            .copyWith(
                                              color: primary,
                                              fontWeight:
                                                  FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: grey2),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showSubjectsBottomSheet(
    BuildContext context,
    TeacherRegistrationCubit cubit,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    tr("choose_subject"),
                    style: TextStyles.textStyleBold16.copyWith(color: primary),
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cubit.subjects.length,
                      itemBuilder: (context, index) {
                        final item = cubit.subjects[index];
                        final isSelected = cubit.selectedSubjectIds.contains(
                          item.id,
                        );
                        return ListTile(
                          title: Text(
                            item.name ?? "",
                            style: TextStyles.textStyleNormal14,
                          ),
                          trailing: isSelected
                              ? const Icon(Icons.check_circle, color: orangeBold)
                              : null,
                          onTap: () {
                            cubit.toggleSubject(item.id!);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  FadeColorButton(
                    onButtonPressed: () {
                      Navigator.pop(context);
                    },
                    buttonColor: primary,
                    isPressed: false,
                    btnTitle: tr("apply"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
