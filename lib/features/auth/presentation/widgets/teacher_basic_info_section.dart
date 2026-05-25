import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_text_field.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/extensions.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/teacher_registration/teacher_registration_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/widgets/register_section_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherBasicInfoSection extends StatelessWidget {
  const TeacherBasicInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TeacherRegistrationCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RegisterSectionHeader(
          title: tr("basic_info"),
          icon: Icons.person_outline,
        ),

        // Full name input
        CustomTextField(
          controller: cubit.nameController,
          obscure: false,
          labelTxt: tr("full_name"),
          hintText: tr("full_name"),
          inputFormatters: [EnglishNumbersFormatter()],
          validation: (val) {
            if (val == null || val.trim().isEmpty) {
              return tr("this_field_required");
            }
            return null;
          },
        ),

        SizedBox(height: context.height / 45),

        // Email input
        CustomTextField(
          controller: cubit.emailController,
          obscure: false,
          labelTxt: tr("email"),
          hintText: tr("email"),
          textInputType: TextInputType.emailAddress,
          inputFormatters: [EnglishNumbersFormatter()],
          validation: (val) {
            if (val == null || val.trim().isEmpty) {
              return tr("this_field_required");
            }
            final emailRegExp = RegExp(
              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
            );
            if (!emailRegExp.hasMatch(val.trim())) {
              return tr("enter_correct_email");
            }
            return null;
          },
        ),

        SizedBox(height: context.height / 45),

        // Specialty selector
        _SpecialtySelector(cubit: cubit),

        SizedBox(height: context.height / 45),

        // Multi-line bio input
        _BioField(cubit: cubit),
      ],
    );
  }
}

class _SpecialtySelector extends StatelessWidget {
  final TeacherRegistrationCubit cubit;

  const _SpecialtySelector({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showSpecialtyBottomSheet(context, cubit),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textScaler: const TextScaler.linear(1.0),
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: tr("specialty"),
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
                Text(
                  cubit.selectedSpecialtyId != null
                      ? cubit.specialties
                                .firstWhere(
                                  (e) =>
                                      e.id ==
                                      cubit
                                          .selectedSpecialtyId,
                                )
                                .name ??
                            ""
                      : tr("choose_specialty"),
                  style: TextStyles.textStyleNormal12
                      .copyWith(
                        color:
                            cubit.selectedSpecialtyId != null
                            ? black
                            : grey2,
                      ),
                ),
              ],
            ),
            const Icon(Icons.arrow_drop_down, color: grey2),
          ],
        ),
      ),
    );
  }

  void _showSpecialtyBottomSheet(
    BuildContext context,
    TeacherRegistrationCubit cubit,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tr("specialty"),
                style: TextStyles.textStyleBold16.copyWith(color: primary),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: cubit.specialties.length,
                  itemBuilder: (context, index) {
                    final item = cubit.specialties[index];
                    return ListTile(
                      title: Text(
                        item.name ?? "",
                        style: TextStyles.textStyleNormal14,
                      ),
                      trailing: cubit.selectedSpecialtyId == item.id
                          ? const Icon(Icons.check_circle, color: orangeBold)
                          : null,
                      onTap: () {
                        cubit.selectSpecialty(item.id!);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BioField extends StatelessWidget {
  final TeacherRegistrationCubit cubit;

  const _BioField({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.width / 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: cubit.bioController,
            maxLines: 4,
            minLines: 3,
            keyboardType: TextInputType.multiline,
            inputFormatters: [EnglishNumbersFormatter()],
            style: TextStyles.textStyleNormal13.copyWith(
              color: grey2,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              label: RichText(
                textScaler: const TextScaler.linear(1.0),
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: tr("about_you"),
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
              hintText: tr("about_you_hint"),
              hintStyle: TextStyles.textStyleNormal12
                  .copyWith(color: grey2),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                  color: black.withOpacity(.1),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                  color: black.withOpacity(.1),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                  color: black.withOpacity(.1),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                  color: black.withOpacity(.1),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                  color: primary,
                ),
              ),
              errorStyle: TextStyles.textStyleNormal12
                  .copyWith(color: primary, letterSpacing: -.16),
              contentPadding: const EdgeInsets.all(20),
              fillColor: white,
              filled: true,
              floatingLabelBehavior:
                  FloatingLabelBehavior.always,
            ),
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return tr("this_field_required");
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
