import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_text_field.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/fade_button.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/login/login_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/widgets/checkbox_remmber_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  initState() {
    context.read<LoginCubit>().getFcmToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: context.height / 16),
                Container(
                  alignment: Alignment.center,
                  child: customSvg(
                    name: logo,
                    width: context.width / 2.4,
                    height: context.width / 2.4,
                  ),
                ),
                SizedBox(height: context.height / 80),
                Text(
                  tr("login_account"),
                  style: TextStyles.textStyleExtraBold24.copyWith(
                    fontWeight: FontWeight.w800,
                    color: primary,
                  ),
                  textScaler: TextScaler.linear(1),
                ),
                SizedBox(height: context.height / 38),
                Text(
                  tr("welcome_back"),
                  style: TextStyles.textStyleNormal12.copyWith(color: greey),
                  textScaler: TextScaler.linear(1),
                ),
                SizedBox(height: context.height / 25),
                CustomTextField(
                  controller: mailController,
                  labelColor: primary,
                  obscure: false,
                  validation: (String? val) {
                    if (val!.isEmpty) {
                      return tr("this_field_required");
                    } else if (!mailController.text.contains(".")) {
                      return tr("mail_contain");
                    } else if (!mailController.text.contains("@")) {
                      return tr("mail_contain_2");
                    } else {
                      return null;
                    }
                  },
                  suffixIcon: Container(
                    width: context.width / 15,
                    margin: EdgeInsets.only(
                      left: context.width / 20,
                      right: context.width / 20,
                    ),
                    alignment: Alignment.center,
                    child: customSvg(
                      name: mail,
                      width: context.width / 20,
                      height: context.width / 20,
                    ),
                  ),
                  prefixIcon: SizedBox(width: 0),
                  labelTxt: tr("email"),
                  hintText: tr("enter_email"),
                ),

                SizedBox(height: context.height / 28),

                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return CustomTextField(
                      controller: passController,
                      obscure: context.read<LoginCubit>().obscure!,
                      validation: (String? val) {
                        if (val!.isEmpty) {
                          return tr("this_field_required");
                        } else {
                          return null;
                        }
                      },
                      labelColor: primary,
                      suffixIcon: InkWell(
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          context.read<LoginCubit>().setVisibility(
                            visibility: context.read<LoginCubit>().obscure,
                          );
                        },
                        child: Container(
                          width: context.width / 15,
                          margin: EdgeInsets.only(
                            left: context.width / 20,
                            right: context.width / 20,
                          ),
                          alignment: Alignment.center,
                          child: context.read<LoginCubit>().obscure == true
                              ? Container(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.visibility_off_outlined,
                                    color: primary,
                                    size: 20,
                                  ),
                                )
                              : Container(
                                  width: context.width / 15,
                                  alignment: Alignment.center,
                                  child: customSvg(
                                    name: visible,
                                    width: context.width / 20,
                                    height: context.width / 20,
                                  ),
                                ),
                        ),
                      ),
                      prefixIcon: SizedBox(width: 0),
                      labelTxt: tr("password"),
                      hintText: tr("enter_password"),
                    );
                  },
                ),

                SizedBox(height: context.height / 50),
                Container(
                  margin: EdgeInsets.only(
                    left: context.width / 70,
                    right: context.width / 70,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            return CheckboxRememberWidget();
                          },
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.pushNamed(name: forgotPassSc);
                        },
                        child: Text(
                          tr("forgot_password"),
                          textScaler: TextScaler.linear(1),
                          style: TextStyles.textStyleNormal12.copyWith(
                            color: primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.height / 60),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return Container(
                      margin: EdgeInsets.only(
                        left: context.width / 40,
                        right: context.width / 40,
                      ),
                      child: FadeColorButton(
                        isLoading: context.read<LoginCubit>().loading,
                        onButtonPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<LoginCubit>().login(
                              params: LoginParams(
                                email: mailController.text,
                                password: passController.text,
                                fcmToken: context.read<LoginCubit>().fcmToken,
                              ),
                            );
                          }
                        },
                        buttonColor: context.read<LoginCubit>().buttonColor,
                        isPressed: context.read<LoginCubit>().isPressed,
                        btnTitle: tr("login"),
                      ),
                    );
                  },
                ),

                SizedBox(height: context.height / 60),

                Container(
                  margin: EdgeInsets.only(
                    left: context.width / 40,
                    right: context.width / 40,
                  ),
                  child: FadeColorButton(
                    onButtonPressed: () {
                      context.pushNamed(name: teacherRegistrationSc);
                    },
                    buttonColor: primary,
                    isPressed: false,
                    btnTitle: tr("join_as_teacher"),
                  ),
                ),

                SizedBox(height: context.height / 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: customSvg(name: leftGradient),
                    ),
                    SizedBox(width: context.width / 18),
                    Text(
                      tr("or"),
                      style: TextStyles.textStyleBold12.copyWith(
                        color: black,
                        fontWeight: FontWeight.w700,
                      ),
                      textScaler: TextScaler.linear(1),
                    ),
                    SizedBox(width: context.width / 18),
                    Container(
                      alignment: Alignment.center,
                      child: customSvg(name: rightGradient),
                    ),
                  ],
                ),
                /* SizedBox(height: context.height/20,),
                Container(
                    margin: EdgeInsets.only(left: context.width/30,right: context.width/30),
                    child: GoogleButtonWidget()),*/
                SizedBox(height: context.height / 20),
                RichText(
                  textScaler: TextScaler.linear(1),
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: tr("don’t_have_account"),
                        style: TextStyles.textStyleNormal14.copyWith(
                          color: black,
                        ),
                      ),
                      TextSpan(
                        text: tr("create_an_account"),
                        style: TextStyles.textStyleNormal14.copyWith(
                          color: primary,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.pushNamed(name: registerSc);
                          },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.height / 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
