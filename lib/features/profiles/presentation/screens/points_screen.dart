import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/points/points_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/widgets/history_points_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PointsScreen extends StatefulWidget {


  @override
  State<PointsScreen> createState() => _PointsScreenState();
  
}

class _PointsScreenState extends State<PointsScreen> {

  @override
  void initState() {
    context.read<PointsCubit>().getPoints();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(widget: SizedBox(),status: false,context: context,index: 0,title: "points"),
      backgroundColor: white,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: context.width/20,right: context.width/20),
            child: Text(tr("reward_points"),style: TextStyles.textStyleBold20
                .copyWith(color: primary,fontWeight: FontWeight.w600)
              ,textScaler: TextScaler.linear(1),),
          ),
          SizedBox(height: context.height/40,),
          Container(
            margin: EdgeInsets.only(left: context.width/20,right: context.width/20),
            height: context.height/4.3,
            width: context.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  primary,
                  orange,
                ], stops: [0.0, 1.0],),),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    customSvg(name: book),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            alignment : Alignment.center,
                            child: customSvg(name: coins)),
                        SizedBox(height: context.height/60,),
                        Text(tr("total_points"),style: TextStyles.textStyleBold18
                            .copyWith(fontWeight: FontWeight.w600,color: white),
                          textScaler: TextScaler.linear(1),),
                        SizedBox(height: context.height/60,),
                        BlocBuilder<PointsCubit, PointsState>(
                          builder: (context, state) {
                            return context.read<PointsCubit>().loading == true ? 
                            SpinKitPulse(color: white,size: 10,) : 
                            Text(context.read<PointsCubit>().pointsResponse == null ? "0" :
                            context.read<PointsCubit>().pointsResponse!.data!.myPoints.toString()
                              ,style: TextStyles.textStyleBold32
                                  .copyWith(fontWeight: FontWeight.bold,color: white),
                          textScaler: TextScaler.linear(1),);
                            },),],),
                  ],),
                Container(
                    alignment: Alignment.topLeft,
                    child: customSvg(name: circle)),
                Container(
                    alignment: Alignment.bottomLeft,
                    child: customSvg(name: circle2)),
              ],),),
          SizedBox(height: context.height/20,),
          Container(
            margin: EdgeInsets.only(left: context.width/18,right: context.width/18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(tr("history_points"),style: TextStyles.textStyleNormal14
                    .copyWith(fontWeight: FontWeight.w600,color: primary)
                  ,textScaler: TextScaler.linear(1),),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(tr("view_all_my_points"),style: TextStyles.textStyleBold12
                        .copyWith(fontWeight: FontWeight.w600
                        ,color: orange),textScaler: TextScaler.linear(1),),
                    SizedBox(width: context.width/40,),
                    customSvg(name: forward,color: orange)
                  ],)],),),
          SizedBox(height: context.height/30,),
          Expanded(child:
          BlocBuilder<PointsCubit, PointsState>(
            builder: (context, state) {
              return context.read<PointsCubit>().loading == true ?
                  SpinKitPulse(color: primary,size: 70,) :
              (context.read<PointsCubit>().pointsResponse == null  ||
                  context.read<PointsCubit>().pointsResponse!.data!.courses!.isEmpty)?
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            alignment : Alignment.center,
                            child: customSvg(name: coins,color: primary,
                                height: context.width/6,
                                width: context.width/6)),
                        SizedBox(height: context.height/80,),
                        Text(tr("no_history_found"),style: TextStyles
                            .textStyleNormal15.copyWith(color: primary),textScaler: TextScaler.linear(1),)
                      ],
                    ),
                  ) :

                ListView.builder(
              itemCount: context.read<PointsCubit>().pointsResponse!.data!.courses!.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 0
                  ,left: context.width/40,right: context.width/40),
              scrollDirection: Axis.vertical,
              itemBuilder: (context,index)=>HistoryPointsItem(courses: context.read<PointsCubit>().pointsResponse!.data!.courses![index],));
  },
),)
        ],
      ),
    );
  }
}