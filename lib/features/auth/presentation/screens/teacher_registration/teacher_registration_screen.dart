import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/teacher_registration/teacher_registration_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/widgets/teacher_availability_section.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/widgets/teacher_basic_info_section.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/widgets/teacher_contact_section.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/widgets/teacher_subjects_section.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/widgets/teacher_submission_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TeacherRegistrationScreen extends StatefulWidget {
  const TeacherRegistrationScreen({super.key});

  @override
  State<TeacherRegistrationScreen> createState() =>
      _TeacherRegistrationScreenState();
}

class _TeacherRegistrationScreenState extends State<TeacherRegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      appBar: customAppBar(
        title: tr("join_as_teacher"),
        status: false,
        context: context,
        widget: const SizedBox(),
        appBarInd: -1,
      ),
      body: BlocConsumer<TeacherRegistrationCubit, TeacherRegistrationState>(
        listener: (context, state) {
          // Listen for navigation or toasts handled by Cubit
        },
        builder: (context, state) {
          final cubit = context.read<TeacherRegistrationCubit>();

          if (cubit.loadingData) {
            return const Center(child: SpinKitPulse(color: primary, size: 60));
          }

          return SafeArea(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: context.height / 50),

                      // 1. Basic Info
                      const TeacherBasicInfoSection(),

                      SizedBox(height: context.height / 35),

                      // 2. Subjects
                      const TeacherSubjectsSection(),

                      SizedBox(height: context.height / 35),

                      // 3. Contact Details
                      const TeacherContactSection(),

                      SizedBox(height: context.height / 35),

                      // 4. Availability
                      const TeacherAvailabilitySection(),

                      SizedBox(height: context.height / 35),

                      // 5. Submission
                      TeacherSubmissionSection(formKey: _formKey),

                      SizedBox(height: context.height / 25),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
