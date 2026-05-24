import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/fade_button.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/register/register_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/register/register_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_text_field.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/widgets/check_box_tile.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String? phoneNum = "";
  String? countryCode = "+966";
  String? countrySymbol = "SA";

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
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: context.height / 140),
                Container(
                  alignment: Alignment.center,
                  child: customSvg(
                    name: logo,
                    width: context.width / 2.4,
                    height: context.width / 2.4,
                  ),
                ),
                SizedBox(height: context.height / 60),
                Text(
                  tr("create_new_account"),
                  style: TextStyles.textStyleExtraBold24.copyWith(
                    fontWeight: FontWeight.w800,
                    color: primary,
                  ),
                  textScaler: TextScaler.linear(1),
                ),
                SizedBox(height: context.height / 50),
                Text(
                  tr("welcome_back"),
                  style: TextStyles.textStyleNormal12.copyWith(color: greey),
                  textScaler: TextScaler.linear(1),
                ),
                SizedBox(height: context.height / 20),
                CustomTextField(
                  controller: fullNameController,
                  obscure: false,
                  suffixIcon: Container(
                    width: context.width / 15,
                    margin: EdgeInsets.only(
                      left: context.width / 20,
                      right: context.width / 20,
                    ),
                    alignment: Alignment.center,
                    child: customSvg(
                      name: user,
                      width: context.width / 20,
                      height: context.width / 20,
                    ),
                  ),
                  prefixIcon: SizedBox(width: 0),
                  labelTxt: tr("full_name"),
                  hintText: tr("enter_full_name"),
                  validation: (String? val) {
                    if (val!.isEmpty) {
                      return tr("this_field_required");
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: context.height / 20),
                Container(
                  margin: EdgeInsets.only(
                    left: context.width / 30,
                    right: context.width / 30,
                  ),
                  child: IntlPhoneField(
                    controller: phoneController,
                    style: TextStyles.textStyleNormal14.copyWith(color: grey2),
                    dropdownDecoration: BoxDecoration(color: white),
                    dropdownTextStyle: TextStyles.textStyleNormal14.copyWith(
                      color: black,
                    ),
                    validator: (val) {
                      if (val!.number.isEmpty) {
                        return tr("this_field_required");
                      } else if (val.number.length < 8) {
                        return tr("the_phone_number");
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        top: context.width / 20,
                        bottom: context.width / 20,
                      ),
                      prefix: VerticalDivider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      label: RichText(
                        textScaler: TextScaler.linear(1.0),
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: tr("phone_number"),
                              style: TextStyles.textStyleBold12.copyWith(
                                color: black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: " *",
                              style: TextStyles.textStyleBold13.copyWith(
                                color: red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      labelStyle: TextStyles.textStyleNormal13.copyWith(
                        color: black,
                      ),

                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(38)),
                        borderSide: BorderSide(color: black.withOpacity(.1)),
                      ),
                      errorStyle: TextStyles.textStyleNormal11.copyWith(
                        color: grey1,
                      ),
                      suffixIcon: Container(
                        width: context.width / 25,
                        alignment: Alignment.center,
                        child: customSvg(name: call),
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(38)),
                        borderSide: BorderSide(color: black.withOpacity(.1)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(38)),
                        borderSide: BorderSide(color: black.withOpacity(.1)),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(38)),
                        borderSide: BorderSide(color: black.withOpacity(.1)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(38)),
                        borderSide: BorderSide(color: black.withOpacity(.1)),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(38)),
                        borderSide: BorderSide(color: black.withOpacity(.1)),
                      ),
                    ),
                    initialCountryCode: 'SA',
                    onChanged: (phone) {
                      phoneNum = phone.number;
                      countryCode = phone.countryCode;
                      countrySymbol = phone.countryISOCode;
                    },
                  ),
                ),
                SizedBox(height: context.height / 28),
                CustomTextField(
                  controller: emailController,
                  obscure: false,
                  validation: (String? val) {
                    if (val!.isEmpty) {
                      return tr("this_field_required");
                    } else if (!val.contains("@")) {
                      return tr("mail_contain_2");
                    } else if (!val.contains(".")) {
                      return tr("mail_contain_2");
                    } else if (!val.contains("com")) {
                      return tr("mail_contain_com");
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
                SizedBox(height: context.height / 15),
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    return CustomTextField(
                      controller: passwordController,
                      obscure: context.read<RegisterCubit>().obscure!,
                      validation: (String? val) {
                        if (val!.isEmpty) {
                          return tr("this_field_required");
                        } else if (passwordController.text !=
                            confirmPasswordController.text) {
                          return tr("password_mismatched");
                        } else if (val.length < 8) {
                          return tr("password_length");
                        } else {
                          return null;
                        }
                      },
                      suffixIcon: InkWell(
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          context.read<RegisterCubit>().setVisibility(
                            visibility: context.read<RegisterCubit>().obscure,
                            type: "password",
                          );
                        },
                        child: Container(
                          width: context.width / 15,
                          margin: EdgeInsets.only(
                            left: context.width / 20,
                            right: context.width / 20,
                          ),
                          alignment: Alignment.center,
                          child: context.read<RegisterCubit>().obscure == true
                              ? Container(
                                  alignment: Alignment.center,
                                  width: context.width / 20,
                                  child: Icon(
                                    Icons.visibility_off_outlined,
                                    color: primary,
                                    size: 20,
                                  ),
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  width: context.width / 15,
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
                SizedBox(height: context.height / 15),
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    return CustomTextField(
                      controller: confirmPasswordController,
                      obscure: context.read<RegisterCubit>().obscure2!,
                      validation: (String? val) {
                        if (val!.isEmpty) {
                          return tr("this_field_required");
                        } else if (passwordController.text !=
                            confirmPasswordController.text) {
                          return tr("password_mismatched");
                        } else if (val.length < 8) {
                          return tr("password_length");
                        } else {
                          return null;
                        }
                      },
                      suffixIcon: InkWell(
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          context.read<RegisterCubit>().setVisibility(
                            visibility: context.read<RegisterCubit>().obscure2,
                            type: "confirmPassword",
                          );
                        },
                        child: Container(
                          width: context.width / 13,
                          margin: EdgeInsets.only(
                            left: context.width / 20,
                            right: context.width / 20,
                          ),
                          alignment: Alignment.center,
                          child: context.read<RegisterCubit>().obscure2 == true
                              ? Icon(
                                  Icons.visibility_off_outlined,
                                  color: primary,
                                  size: 20,
                                )
                              : customSvg(
                                  name: visible,
                                  width: context.width / 20,
                                  height: context.width / 20,
                                ),
                        ),
                      ),
                      prefixIcon: SizedBox(width: 0),
                      labelTxt: tr("confirm_pass"),
                      hintText: tr("enter_confirm_password"),
                    );
                  },
                ),
                SizedBox(height: context.height / 33),
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    return CheckboxListTileWidget(title: tr("sign_up"));
                  },
                ),
                SizedBox(height: context.height / 25),
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    return FadeColorButton(
                      isLoading: context.read<RegisterCubit>().loading,
                      onButtonPressed: () {
                        if (context.read<RegisterCubit>().isChecked == false) {
                          msgKey.currentState!.showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40),
                                ),
                              ),
                              content: Text(
                                tr("agree_terms"),
                                style: TextStyles.textStyleNormal13.copyWith(
                                  color: white,
                                ),
                                textScaler: TextScaler.linear(1),
                              ),
                            ),
                          );
                        } else {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            context.read<RegisterCubit>().register(
                              params: RegisterParams(
                                fullName: fullNameController.text,
                                phoneNumber: phoneNum,
                                countryCode: countryCode,
                                countrySymbol: countrySymbol,
                                email: emailController.text,
                                password: passwordController.text,
                                passwordConfirmation:
                                    confirmPasswordController.text,
                              ),
                            );
                          }
                        }
                      },
                      buttonColor: context.read<RegisterCubit>().buttonColor,
                      isPressed: context.read<RegisterCubit>().isPressed,
                      btnTitle: tr("sign_in"),
                    );
                  },
                ),

                SizedBox(height: context.height / 20),
                RichText(
                  textScaler: TextScaler.linear(1),
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: tr("have_account"),
                        style: TextStyles.textStyleNormal14.copyWith(
                          color: black,
                        ),
                      ),
                      TextSpan(
                        text: tr("log_in"),
                        style: TextStyles.textStyleNormal14.copyWith(
                          color: primary,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.pushNamed(name: loginSc);
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
