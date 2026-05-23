import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

SvgPicture customSvg({
  String? name,
  double? width,
  double? height,
  Color? color,
}) {
  return SvgPicture.asset(
    name!,
    width: width,
    height: height,
    alignment: Alignment.center,
    fit: BoxFit.cover,
    color: color,
  );
}
