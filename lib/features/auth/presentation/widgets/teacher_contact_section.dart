import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_text_field.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/extensions.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/teacher_registration/teacher_registration_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/widgets/register_section_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherContactSection extends StatelessWidget {
  const TeacherContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TeacherRegistrationCubit>();
    return Column(
      children: [
        RegisterSectionHeader(
          title: tr("contact_info"),
          icon: Icons.phone_outlined,
        ),
        CustomTextField(
          controller: cubit.whatsappController,
          obscure: false,
          labelTxt: tr("whatsapp_required"),
          hintText: tr("whatsapp_hint"),
          textInputType: TextInputType.phone,
          inputFormatters: [EnglishNumbersFormatter()],
          validation: (val) {
            if (val == null || val.trim().isEmpty) {
              return tr("this_field_required");
            }
            return null;
          },
        ),
        SizedBox(height: context.height / 45),
        CustomTextField(
          controller: cubit.alternativeController,
          obscure: false,
          labelTxt: tr("alternative_contact"),
          hintText: tr("whatsapp_hint"),
          textInputType: TextInputType.phone,
          inputFormatters: [EnglishNumbersFormatter()],
        ),
      ],
    );
  }
}
