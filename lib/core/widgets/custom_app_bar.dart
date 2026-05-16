import 'dart:math' as math;

import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/bottom_bar/presentation/cubit/bottom_bar_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

AppBar? customAppBar({String? title, bool? status, BuildContext? context
  , required Widget? widget, int? index = -1, int? appBarInd,String? screenType}) {
  return AppBar(
    backgroundColor: white,
    elevation: 0,
    surfaceTintColor: white,
    automaticallyImplyLeading: false,
    leadingWidth: navKey.currentContext!.width / 1.5,

    leading: BlocBuilder<BottomBarCubit, BottomBarState>(
      builder: (context, state) {
        return InkWell(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            if(appBarInd == 0){
              context.pop();
              context.read<BottomBarCubit>().updateBottomBarVisibility(visible: true);
            }else {
              context.read<BottomBarCubit>().changeNavBarStatus(ind: 0);
            }
            if(index == 0){
              context.pop();
              context.read<BottomBarCubit>().updateBottomBarVisibility(visible: false);
            }
            if(appBarInd == -1){
              context.pop();
            }

          },
          child: Container(
            margin: EdgeInsets.only(left: navKey.currentContext!.width / 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: context.width/30,),
            context.locale.languageCode == "ar" ?
            Transform.rotate(
            angle: 180 * math.pi / 180,
              child:  Container(
                  alignment: Alignment.center,
                  child: customSvg(name: back,width: context.width/4
                      ,height: context.height/50)),

            ) : Container(
              alignment: Alignment.center,
              child: customSvg(name: back,width: context.width/4
                  ,height: context.height/50)),
                SizedBox(width: navKey.currentContext!.width / 50,),
                Flexible(
                  child: Text(title!, style: TextStyles.textStyleNormal14
                      .copyWith(color: primary, fontWeight:
                  FontWeight.w500,), textScaler: TextScaler.linear(1.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,),),
                SizedBox(width: context.width/30,),
              ],),),
        );
      },
    ),
    actions: [
      status == false ? SizedBox() : widget!,
      SizedBox(width: navKey.currentContext!.width / 20,)
    ],
  );
}