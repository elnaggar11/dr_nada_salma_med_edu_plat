import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_text_field.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/fade_button.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/check/check_otp_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/reset_password/reset_password_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/reset/reset_pass_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/custom_app_bar.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.params});
  final CheckOtpParams params;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      appBar: customAppBar(
        appBarInd: -1,
        widget: SizedBox(),
        title: tr("register"),
        status: false,
        context: context,
        index: -1,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: context.height / 5),
                Container(
                  alignment: Alignment.center,
                  child: customSvg(name: forgotPass),
                ),
                SizedBox(height: context.height / 30),
                Text(
                  tr("reset_pass"),
                  style: TextStyles.textStyleBold28.copyWith(color: orangeBold),
                ),
                SizedBox(height: context.height / 20),
                BlocBuilder<ResetPassCubit, ResetPassState>(
                  builder: (context, state) {
                    return CustomTextField(
                      controller: passwordController,
                      obscure: context.read<ResetPassCubit>().obscure!,
                      labelTxt: tr("set_new_pass"),
                      labelColor: orangeBold,
                      suffixIcon: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,

                        onTap: () {
                          context.read<ResetPassCubit>().setVisibility(
                            visibility: context.read<ResetPassCubit>().obscure!,
                            type: "password",
                          );
                        },
                        child: context.read<ResetPassCubit>().obscure == true
                            ? Container(
                                width: context.width / 20,
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.visibility_off_outlined,
                                  color: primary,
                                  size: 20,
                                ),
                              )
                            : Container(
                                alignment: Alignment.center,
                                width: context.width / 20,
                                child: customSvg(
                                  name: visible,
                                  width: context.width / 20,
                                  height: context.width / 20,
                                ),
                              ),
                      ),
                      hintText: tr("enter_password_here"),
                      validation: (String? val) {
                        if (val!.isEmpty) {
                          return tr("this_field_required");
                        } else {
                          return null;
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: context.height / 20),
                BlocBuilder<ResetPassCubit, ResetPassState>(
                  builder: (context, state) {
                    return CustomTextField(
                      controller: confirmPassController,
                      obscure: context.read<ResetPassCubit>().obscure2!,
                      labelTxt: tr("confirm_new_pass"),
                      labelColor: orangeBold,
                      suffixIcon: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: () {
                          context.read<ResetPassCubit>().setVisibility(
                            visibility: context
                                .read<ResetPassCubit>()
                                .obscure2!,
                            type: "confirmPassword",
                          );
                        },
                        child: context.read<ResetPassCubit>().obscure2 == true
                            ? Container(
                                width: context.width / 20,
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.visibility_off_outlined,
                                  color: primary,
                                  size: 20,
                                ),
                              )
                            : Container(
                                width: context.width / 20,
                                alignment: Alignment.center,
                                child: customSvg(
                                  name: visible,
                                  width: context.width / 30,
                                  height: context.width / 30,
                                ),
                              ),
                      ),
                      hintText: tr("enter_new_password"),
                      validation: (String? val) {
                        if (val!.isEmpty) {
                          return tr("this_field_required");
                        } else if (passwordController.text !=
                            confirmPassController.text) {
                          return tr("password_mismatched");
                        } else {
                          return null;
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: context.height / 20),
                BlocBuilder<ResetPassCubit, ResetPassState>(
                  builder: (context, state) {
                    return FadeColorButton(
                      isLoading: context.read<ResetPassCubit>().loading,
                      btnTitle: tr("save_new_password"),
                      buttonColor: context.read<ResetPassCubit>().buttonColor,
                      isPressed: false,
                      onButtonPressed: () {
                        if (formKey.currentState!.validate()) {
                          print(
                            "confirmPass: ${confirmPassController.text}password : ${passwordController.text}email : ${widget.params.email}  otp :${widget.params.otp}",
                          );
                          context.read<ResetPassCubit>().resetPassword(
                            params: ResetPasswordParams(
                              email: widget.params.email,
                              otp: widget.params.otp,
                              newPassword: passwordController.text,
                              newPasswordConfirmation:
                                  confirmPassController.text,
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
      ),
    );
  }
}
