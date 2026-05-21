import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FadeColorButton extends StatefulWidget {
  FadeColorButton({
    super.key,
    this.onButtonPressed,
    this.buttonColor,
    this.isPressed,
    required this.btnTitle,
    this.isLoading = false,
  });

  final Function()? onButtonPressed;
  Color? buttonColor; // Initial color
  bool? isPressed;
  final String btnTitle;
  bool? isLoading;

  @override
  State<FadeColorButton> createState() => _FadeColorButtonState();
}

class _FadeColorButtonState extends State<FadeColorButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        onPressed: widget.onButtonPressed,
        color: Colors.transparent,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightElevation: 0,
        hoverElevation: 0,
        highlightColor: Colors.transparent,
        disabledColor: Colors.transparent,
        focusColor: Colors.transparent,
        focusElevation: 0,
        elevation: 0,

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300), // Animation duration
          curve: Curves.easeInOut, // Animation curve
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          margin: EdgeInsets.only(
            left: context.width / 40,
            right: context.width / 40,
          ),
          decoration: BoxDecoration(
            color: widget.buttonColor,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.btnTitle,
                style: TextStyles.textStyleNormal16.copyWith(
                  color: white,
                  fontWeight: FontWeight.w500,
                ),
                textScaler: TextScaler.linear(1.0),
              ),
              Spacer(),
              widget.isLoading == false
                  ? Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: white,
                        shape: BoxShape.circle,
                      ),
                      child: customSvg(
                        name: direction,
                        color: widget.buttonColor,
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.all(10),
                      child: SpinKitFadingFour(color: white, size: 25),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
