import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/fonts.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/fade_button.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/check/check_otp_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/resend_otp/resend_otp_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/verify/verify_otp_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/check_otp/check_otp_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/resend_otp/resend_otp_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/verify/verify_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class VerificationScreen extends StatefulWidget {
  final VerifyOtpParams params;

  const VerificationScreen({super.key, required this.params});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController verificationCodeController =
      TextEditingController();

  @override
  void initState() {
    context.read<VerifyCubit>().startTimer();
    context.read<VerifyCubit>().getFcmToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        appBarInd: -1,
        index: -1,
        title: tr("verify_otp"),
        status: false,
        context: context,
        widget: SizedBox(),
      ),
      backgroundColor: white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: context.height / 15),
              BlocBuilder<VerifyCubit, VerifyState>(
                builder: (context, state) {
                  return context.read<VerifyCubit>().error == true
                      ? Container(
                          margin: EdgeInsets.only(
                            left: context.width / 5,
                            right: context.width / 5,
                          ),

                          padding: EdgeInsets.only(
                            top: context.width / 30,
                            bottom: context.width / 30,
                          ),
                          decoration: BoxDecoration(
                            color: pink,
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                tr("an_error"),
                                style: TextStyles.textStyleBold12.copyWith(
                                  color: white,
                                  fontWeight: FontWeight.w600,
                                ),
                                textScaler: TextScaler.linear(1),
                              ),
                              SizedBox(width: context.width / 30),
                              Container(
                                alignment: Alignment.center,
                                child: customSvg(name: disLike, color: white),
                              ),
                            ],
                          ),
                        )
                      : SizedBox();
                },
              ),
              SizedBox(height: context.height / 40),
              BlocBuilder<VerifyCubit, VerifyState>(
                builder: (context, state) {
                  return context.read<VerifyCubit>().error == true
                      ? SizedBox()
                      : SizedBox(height: context.height / 20);
                },
              ),
              Container(
                alignment: Alignment.center,
                child: customSvg(name: verification),
              ),
              SizedBox(height: context.height / 26),
              Text(
                tr("email_verification"),
                style: TextStyles.textStyleBold28.copyWith(color: orangeBold),
                textScaler: TextScaler.linear(1),
              ),
              SizedBox(height: context.height / 28),
              Text(
                tr("enter_code"),
                style: TextStyles.textStyleNormal14.copyWith(
                  color: black,
                  fontFamily: poppins,
                ),
                textScaler: TextScaler.linear(1),
              ),
              SizedBox(height: context.height / 15),
              BlocBuilder<VerifyCubit, VerifyState>(
                builder: (context, state) {
                  return OtpTextField(
                    numberOfFields: 4,
                    clearText: false,
                    enabledBorderColor:
                        context
                                .read<VerifyCubit>()
                                .verificationCodeController
                                .text
                                .length >=
                            4
                        ? primary
                        : grey3,
                    focusedBorderColor: primary,
                    alignment: Alignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textStyle: TextStyles.textStyleBold28.copyWith(
                      color: primary,
                    ),
                    contentPadding: EdgeInsets.zero,
                    autoFocus: true,
                    borderColor: primary,
                    fieldWidth: context.width / 5.7,
                    //set to true to show as box or false to show as dash
                    showFieldAsBox: false,

                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      context
                              .read<VerifyCubit>()
                              .verificationCodeController
                              .text =
                          code;
                    },
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode) {
                      context
                              .read<VerifyCubit>()
                              .verificationCodeController
                              .text =
                          verificationCode;
                    }, // end onSubmit
                  );
                },
              ),
              SizedBox(height: context.height / 15),
              BlocBuilder<ResendOtpCubit, ResendOtpState>(
                builder: (context, state) {
                  return RichText(
                    textScaler: TextScaler.linear(1),
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: tr("nt_receive_code"),
                          style: TextStyles.textStyleNormal14.copyWith(
                            color: black,
                          ),
                        ),
                        WidgetSpan(
                          child: context.read<ResendOtpCubit>().loading == true
                              ? Container(
                                  width: context.width / 20,
                                  height: context.width / 20,
                                  alignment: Alignment.center,
                                  child: SpinKitFadingCircle(
                                    color: primary,
                                    size: 20,
                                  ),
                                )
                              : RichText(
                                  textHeightBehavior: TextHeightBehavior(
                                    applyHeightToFirstAscent: true,
                                    applyHeightToLastDescent: true,
                                  ),
                                  textScaler: TextScaler.linear(1),
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: tr("resend_code"),
                                        style: TextStyles.textStyleNormal14
                                            .copyWith(
                                              color: primary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            context
                                                .read<ResendOtpCubit>()
                                                .resendOtp(
                                                  params: ResendOtpParams(
                                                    email: widget.params.email,
                                                  ),
                                                );
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: context.height / 20),
              BlocBuilder<VerifyCubit, VerifyState>(
                builder: (context, state) {
                  return Text(
                    "${tr("code_expired")} ${context.read<VerifyCubit>().timerText}",
                    style: TextStyles.textStyleNormal13.copyWith(
                      color: primary,
                    ),
                    textScaler: TextScaler.linear(1),
                  );
                },
              ),
              SizedBox(height: context.height / 15),

              widget.params.type == "reset"
                  ? BlocBuilder<CheckOtpCubit, CheckOtpState>(
                      builder: (context, state) {
                        return FadeColorButton(
                          isLoading: context.read<CheckOtpCubit>().loading,
                          onButtonPressed: () {
                            context.read<CheckOtpCubit>().checkOtp(
                              params: CheckOtpParams(
                                email: widget.params.email,
                                otp: context
                                    .read<VerifyCubit>()
                                    .verificationCodeController
                                    .text
                                    .toString(),
                              ),
                            );
                          },
                          buttonColor:
                              context
                                      .read<VerifyCubit>()
                                      .verificationCodeController
                                      .text
                                      .length ==
                                  4
                              ? primary
                              : context.read<VerifyCubit>().buttonColor,
                          isPressed: context.read<VerifyCubit>().isPressed,
                          btnTitle: tr("verify"),
                        );
                      },
                    )
                  : BlocBuilder<VerifyCubit, VerifyState>(
                      builder: (context, state) {
                        return FadeColorButton(
                          isLoading: context.read<VerifyCubit>().loading,
                          onButtonPressed: () {
                            context.read<VerifyCubit>().verifyOtp(
                              params: VerifyOtpParams(
                                fcmToken: context.read<VerifyCubit>().fcmToken,
                                type: widget.params.type,
                                email: widget.params.email,
                                otp: context
                                    .read<VerifyCubit>()
                                    .verificationCodeController
                                    .text
                                    .toString(),
                              ),
                            );
                          },
                          buttonColor:
                              context
                                      .read<VerifyCubit>()
                                      .verificationCodeController
                                      .text
                                      .length ==
                                  4
                              ? primary
                              : context.read<VerifyCubit>().buttonColor,
                          isPressed: context.read<VerifyCubit>().isPressed,
                          btnTitle: tr("verify"),
                        );
                      },
                    ),
              SizedBox(height: context.height / 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    context.read<VerifyCubit>().timer?.cancel();
    super.dispose();
  }
}
