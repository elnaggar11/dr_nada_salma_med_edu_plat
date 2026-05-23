import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/fade_button.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/teacher_registration/teacher_registration_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherSubmissionSection extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const TeacherSubmissionSection({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TeacherRegistrationCubit>();
    return Column(
      children: [
        // Terms checkbox
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width / 30),
          child: Row(
            children: [
              Checkbox(
                activeColor: orangeBold,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                value: cubit.isCheckedTerms,
                onChanged: cubit.toggleTermsCheck,
              ),
              Expanded(
                child: Text(
                  tr("accept_terms"),
                  style: TextStyles.textStyleNormal12.copyWith(color: grey2),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.height / 50),
        // Submit button
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width / 30),
          child: FadeColorButton(
            onButtonPressed: () {
              if (formKey.currentState!.validate()) {
                cubit.submitApplication();
              }
            },
            buttonColor: cubit.buttonColor ?? orangeBold,
            isPressed: cubit.submitting,
            btnTitle: tr("submit_application"),
          ),
        ),
      ],
    );
  }
}
