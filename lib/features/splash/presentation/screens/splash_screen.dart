import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/image_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif/gif.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  GifController? controller;
  @override
  void initState() {
    controller = GifController(vsync: this);
    context.read<SplashCubit>().setSplash();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: context.height / 8),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: context.width / 2.2),
              child: customSvg(name: wavy1, width: context.width / 1.9),
            ),
            Spacer(),
            Container(
              alignment: Alignment.center,
              child: ImageHandler(
                image: splashLogo,
                width: context.width / 1.8,
                height: context.width / 1.8,
              ),
            ),
            Spacer(),

            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: context.width / 2.0),
              child: customSvg(name: wavy2, width: context.width / 1.9),
            ),
            SizedBox(height: context.height / 9),
          ],
        ),
      ),
    );
  }
}
