import 'package:flutter/material.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/extensions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';

class AppBtn extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color? color;
  final TextStyle? style;
  final double? width;
  final double? height;
  final double? radius;

  const AppBtn({
    super.key,
    required this.title,
    required this.onPressed,
    this.color,
    this.style,
    this.width,
    this.height,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(radius ?? context.width / 15),
        child: Container(
          width: width ?? double.infinity,
          height: height ?? context.height / 14,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color ?? context.primaryColor,
            borderRadius: BorderRadius.circular(radius ?? context.width / 15),
            boxShadow: [
              BoxShadow(
                color: (color ?? context.primaryColor).withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Text(
            title,
            style:
                style ??
                context.boldText.copyWith(
                  fontSize: context.width / 20,
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
