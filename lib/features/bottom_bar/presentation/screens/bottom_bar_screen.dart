import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/bottom_bar/presentation/cubit/bottom_bar_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreensState();
}

class _BottomBarScreensState extends State<BottomBarScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return; // Allow the pop if already handled
        }
        final bool? shouldPop = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: white,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: customSvg(
                      name: logo,
                      width: context.width / 5,
                      height: context.width / 5,
                    ),
                  ),
                  Text(
                    tr("confirm_exit"),
                    style: TextStyles.textStyleBold16.copyWith(color: primary),
                    textScaler: TextScaler.linear(1),
                  ),
                  SizedBox(height: context.height / 50),
                  Text(
                    tr("exit_screen"),
                    style: TextStyles.textStyleNormal12.copyWith(
                      color: primary,
                    ),
                    textScaler: TextScaler.linear(1),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(false), // Stay on screen
                  child: Text(
                    tr("no"),
                    style: TextStyles.textStyleBold12.copyWith(color: primary),
                    textScaler: TextScaler.linear(1),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(true), // Exit screen
                  child: Text(
                    tr("yes"),
                    style: TextStyles.textStyleBold14.copyWith(color: primary),
                    textScaler: TextScaler.linear(1),
                  ),
                ),
              ],
            );
          },
        );
        if (shouldPop == true) {
          Navigator.of(context).pop(); // Perform the pop
        }
      },
      child: Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: BlocBuilder<BottomBarCubit, BottomBarState>(
            builder: (context, state) {
              return context.read<BottomBarCubit>().pageList(
                context: context,
              )[context.read<BottomBarCubit>().pageIndex];
            },
          ),
        ),

        bottomNavigationBar: BlocBuilder<BottomBarCubit, BottomBarState>(
          builder: (context, state) {
            return context.read<BottomBarCubit>().visibility == true
                ? Container(
                    color: white,
                    height: context.height / 8.5,
                    child: BottomNavigationBar(
                      currentIndex: context.read<BottomBarCubit>().pageIndex,
                      backgroundColor: white,
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: orangeBold,
                      unselectedItemColor: primary,
                      selectedLabelStyle: TextStyles.textStyleNormal12.copyWith(
                        color: primary,
                      ),
                      unselectedLabelStyle: TextStyles.textStyleNormal12
                          .copyWith(color: primary),
                      showSelectedLabels: true,
                      showUnselectedLabels: true,

                      elevation: 1,
                      onTap: (int? ind) {
                        context.read<BottomBarCubit>().changeNavBarStatus(
                          ind: ind,
                        );
                      },
                      items: [
                        BottomNavigationBarItem(
                          icon: customSvg(
                            name: home,
                            color: context.read<BottomBarCubit>().pageIndex == 0
                                ? orangeBold
                                : primary,
                          ),
                          label: tr("home"),
                          backgroundColor: white,
                        ),
                        BottomNavigationBarItem(
                          icon: customSvg(
                            name: blog,
                            color: context.read<BottomBarCubit>().pageIndex == 1
                                ? orangeBold
                                : primary,
                          ),
                          label: tr("blog"),
                          backgroundColor: white,
                        ),
                        BottomNavigationBarItem(
                          icon: customSvg(
                            name: course,
                            color: context.read<BottomBarCubit>().pageIndex == 2
                                ? orangeBold
                                : primary,
                          ),
                          label: tr("my_courses"),
                          backgroundColor: white,
                        ),
                        /*  BottomNavigationBarItem(icon: customSvg(name: cart,color:context.read<BottomBarCubit>().pageIndex == 3 ? orangeBold : primary)
                      ,label: tr("cart"),backgroundColor: white),*/
                        BottomNavigationBarItem(
                          icon: customSvg(
                            name: profile,
                            color: context.read<BottomBarCubit>().pageIndex == 3
                                ? orangeBold
                                : primary,
                          ),
                          label: tr("my_profile"),
                          backgroundColor: white,
                        ),
                      ],
                    ),
                  )
                : SizedBox();
          },
        ),
      ),
    );
  }
}
