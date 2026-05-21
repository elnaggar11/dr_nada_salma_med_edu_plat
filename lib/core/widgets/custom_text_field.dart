import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  String? hintText;
  final String? icon;
  final bool obscure;
  final String? labelTxt;
  final String? fieldType;
  final Color? labelColor;
  final TextInputType? textInputType;
  Widget? suffixIcon;
  Widget? prefixIcon;
  bool? isRegistered;
  String? Function(String?)? validation;
  String? Function(String?)? onChange;
  CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.icon,
    required this.obscure,
    this.labelTxt,
    this.textInputType,
    this.validation,
    this.onChange,
    this.fieldType,
    this.suffixIcon,
    this.prefixIcon,
    this.labelColor = black,
    this.isRegistered = true,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: context.width / 30,
        right: context.width / 30,
      ),
      width: double.infinity,
      child: MediaQuery(
        data: MediaQueryData(textScaler: TextScaler.linear(1)),
        child: TextFormField(
          controller: widget.controller,
          style: TextStyles.textStyleNormal13.copyWith(
            color: grey2,
            letterSpacing: -0.408,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          obscureText: widget.obscure,
          keyboardType: widget.textInputType,
          onChanged: widget.onChange,
          enabled: widget.isRegistered,
          decoration: InputDecoration(
            prefix: widget.prefixIcon,
            constraints: BoxConstraints(minWidth: 0, maxWidth: 30),
            isDense: true,
            isCollapsed: true,

            prefixIconConstraints: BoxConstraints(
              minWidth: 20,
              maxWidth: 20,
              minHeight: 0,
              maxHeight: context.height / 20,
            ),

            errorStyle: TextStyles.textStyleNormal12.copyWith(
              color: primary,
              letterSpacing: -.16,
            ),
            alignLabelWithHint: true,

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(38.0)),
              borderSide: BorderSide(color: black.withOpacity(.1)),
            ),
            suffixIcon: widget.suffixIcon,

            hintText: widget.hintText,
            hintStyle: TextStyles.textStyleNormal12.copyWith(
              color: grey2,
              letterSpacing: -0.408,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(38.0)),
              borderSide: BorderSide(color: black.withOpacity(.1)),
            ),

            fillColor: white,
            filled: true,

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(38.0)),
              borderSide: BorderSide(color: black.withOpacity(.1)),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(38.0)),
              borderSide: BorderSide(color: black.withOpacity(.1)),
            ),
            contentPadding: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 21,
              bottom: 19,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(38.0)),
              borderSide: BorderSide(color: primary),
            ),

            label: RichText(
              textScaler: TextScaler.linear(1.0),
              textAlign: TextAlign.start,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: widget.labelTxt!,
                    style: TextStyles.textStyleBold13.copyWith(
                      color: widget.labelColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: " *",
                    style: TextStyles.textStyleBold13.copyWith(color: red),
                  ),
                ],
              ),
            ),
          ),
          validator: widget.validation,
        ),
      ),
    );
  }
}
