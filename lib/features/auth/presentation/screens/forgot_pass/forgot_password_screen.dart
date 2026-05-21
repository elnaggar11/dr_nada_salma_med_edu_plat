import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_text_field.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/fade_button.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/forgot/forgot_password_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/forgot/forgot_password_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/custom_app_bar.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController mailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      appBar: customAppBar(
        appBarInd: -1,
        widget: SizedBox(),
        title: tr("forgot_password"),
        status: false,
        context: context,
        index: -1,
      ),
      body: Container(
        color: white,
        width: double.infinity,
        height: double.infinity,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: customSvg(
                  name: forgotPass,
                  width: context.width / 4.5,
                  height: context.width / 4.5,
                ),
              ),
              SizedBox(height: context.height / 28),
              Text(
                tr("forgot_password"),
                style: TextStyles.textStyleBold28.copyWith(color: orangeBold),
                textScaler: TextScaler.linear(1),
              ),
              SizedBox(height: context.height / 32),
              Text(
                tr("enter_email_link"),
                style: TextStyles.textStyleNormal14.copyWith(color: primary),
                textScaler: TextScaler.linear(1),
              ),
              SizedBox(height: context.height / 10),
              BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                builder: (context, state) {
                  return CustomTextField(
                    controller: context
                        .read<ForgotPasswordCubit>()
                        .mailController,
                    obscure: false,
                    validation: (String? val) {
                      if (val!.isEmpty) {
                        return tr("this_field_required");
                      } else {
                        return null;
                      }
                    },
                    labelColor: orangeBold,
                    labelTxt: tr("phone_email"),
                    suffixIcon: Container(
                      alignment: Alignment.center,
                      width: context.width / 7,
                      child: customSvg(name: mail, color: black),
                    ),
                  );
                },
              ),

              SizedBox(height: context.height / 18),
              BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                builder: (context, state) {
                  return FadeColorButton(
                    isLoading: context.read<ForgotPasswordCubit>().loading,
                    btnTitle: tr("get_the_code_now"),
                    buttonColor: context
                        .read<ForgotPasswordCubit>()
                        .buttonColor,
                    isPressed: false,
                    onButtonPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<ForgotPasswordCubit>().forgot(
                          params: ForgotPasswordParams(
                            email: context
                                .read<ForgotPasswordCubit>()
                                .mailController
                                .text,
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
