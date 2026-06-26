import 'dart:math' as math;

import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/fonts.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/local/auth_local_data_source.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/const.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/network_image_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/profile/profile_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/injection_container/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.appBarInd});
  final int appBarInd;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    if (sharedPreferences.getString(cacheTokenConst) != null) {
      context.read<ProfileCubit>().getProfile();
    }
    context.read<ProfileCubit>().getSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(sharedPreferences.get(cacheTokenConst));
    return Scaffold(
      backgroundColor: white,
      appBar: customAppBar(
        widget: SizedBox(),
        title: tr("profiles"),
        status: false,
        context: context,
        appBarInd: widget.appBarInd,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            left: context.width / 30,
            right: context.width / 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.height / 60),
              Container(
                padding: EdgeInsets.only(
                  top: context.height / 40,
                  bottom: context.height / 40,
                ),
                decoration: BoxDecoration(
                  color: greyLight,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: context.width / 15,
                        right: context.width / 15,
                      ),
                      child: Text(
                        tr("my_profile"),
                        style: TextStyles.textStyleBold12.copyWith(
                          color: orangeBold,
                          fontWeight: FontWeight.w800,
                        ),
                        textScaler: TextScaler.linear(1),
                      ),
                    ),
                    SizedBox(height: context.height / 50),
                    InkWell(
                      onTap: () {
                        context.pushNamed(
                          name: myProfileSc,
                          args: context.read<ProfileCubit>(),
                        );
                      },
                      child: BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          return context.read<ProfileCubit>().loading == true
                              ? SpinKitPulse(color: primary, size: 10)
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: context.width / 20),
                                    ClipOval(
                                      child: NetWorkImageHandler(
                                        image:
                                            context
                                                .read<ProfileCubit>()
                                                .profileResponse
                                                ?.data
                                                ?.image ??
                                            "",
                                        width: context.width / 6.5,
                                        height: context.width / 6.5,
                                      ),
                                    ),
                                    SizedBox(width: context.width / 60),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          context
                                                  .read<ProfileCubit>()
                                                  .profileResponse
                                                  ?.data
                                                  ?.fullName ??
                                              "",
                                          style: TextStyles.textStyleBold12
                                              .copyWith(
                                                fontWeight: FontWeight.w800,
                                                color: primary,
                                              ),
                                          textScaler: TextScaler.linear(1),
                                        ),
                                        SizedBox(height: context.height / 80),
                                        Text(
                                          "${context.read<ProfileCubit>().profileResponse?.data?.phoneNumber ?? ""}",
                                          style: TextStyles.textStyleBold12
                                              .copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: poppins,
                                              ),
                                          textScaler: TextScaler.linear(1),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    context.locale.languageCode == "ar"
                                        ? Transform.rotate(
                                            angle: 180 * math.pi / 180,
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: customSvg(
                                                name: forward1,
                                                width: context.width / 24,
                                                height: context.width / 24,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            alignment: Alignment.center,
                                            child: customSvg(
                                              name: forward1,
                                              width: context.width / 24,
                                              height: context.width / 24,
                                            ),
                                          ),

                                    SizedBox(width: context.width / 12),
                                  ],
                                );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.height / 55),
              Container(
                padding: EdgeInsets.only(
                  top: context.height / 30,
                  bottom: context.height / 40,
                ),
                decoration: BoxDecoration(
                  color: greyLight,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: context.width / 15,
                        right: context.width / 15,
                      ),
                      child: Text(
                        tr("services"),
                        style: TextStyles.textStyleBold12.copyWith(
                          color: orangeBold,
                          fontWeight: FontWeight.w800,
                        ),
                        textScaler: TextScaler.linear(1),
                      ),
                    ),
                    SizedBox(height: context.height / 50),

                    if (!Const.isTeacher) ...[
                      InkWell(
                        onTap: () {
                          context.pushNamed(name: coursesSc, args: "courses");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: context.width / 15),
                            Container(
                              alignment: Alignment.center,
                              child: customSvg(
                                name: course1,
                                width: context.width / 20,
                                height: context.width / 20,
                              ),
                            ),
                            SizedBox(width: context.width / 50),
                            Text(
                              tr("my_courses"),
                              style: TextStyles.textStyleBold12.copyWith(
                                color: primary,
                              ),
                              textScaler: TextScaler.linear(1),
                            ),
                            Spacer(),
                            context.locale.languageCode == "ar"
                                ? Transform.rotate(
                                    angle: 180 * math.pi / 180,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: customSvg(
                                        name: forward1,
                                        width: context.width / 24,
                                        height: context.width / 24,
                                      ),
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    child: customSvg(
                                      name: forward1,
                                      width: context.width / 24,
                                      height: context.width / 24,
                                    ),
                                  ),
                            SizedBox(width: context.width / 12),
                          ],
                        ),
                      ),
                      SizedBox(height: context.height / 30),
                    ],

                    InkWell(
                      onTap: () {
                        context.pushNamed(name: appointmentsSc);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: context.width / 15),
                          Container(
                            alignment: Alignment.center,
                            child: customSvg(
                              color: primary,
                              name: schedule,
                              width: context.width / 18,
                              height: context.width / 18,
                            ),
                          ),
                          SizedBox(width: context.width / 30),
                          Text(
                            tr("my_schedule"),
                            style: TextStyles.textStyleBold12.copyWith(
                              color: primary,
                            ),
                            textScaler: TextScaler.linear(1),
                          ),
                          Spacer(),
                          context.locale.languageCode == "ar"
                              ? Transform.rotate(
                                  angle: 180 * math.pi / 180,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: customSvg(
                                      name: forward1,
                                      width: context.width / 24,
                                      height: context.width / 24,
                                    ),
                                  ),
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  child: customSvg(
                                    name: forward1,
                                    width: context.width / 24,
                                    height: context.width / 24,
                                  ),
                                ),
                          SizedBox(width: context.width / 12),
                        ],
                      ),
                    ),

                    SizedBox(height: context.height / 30),

                    if (!Const.isTeacher) ...[
                      InkWell(
                        onTap: () {
                          context.pushNamed(
                            name: privateLessons,
                            args: "lessons",
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: context.width / 15),
                            Container(
                              alignment: Alignment.center,
                              child: customSvg(
                                name: new2,
                                width: context.width / 22,
                                height: context.width / 22,
                              ),
                            ),

                            SizedBox(width: context.width / 30),
                            Text(
                              tr("my_private_lessons"),
                              style: TextStyles.textStyleBold12.copyWith(
                                color: primary,
                              ),
                              textScaler: TextScaler.linear(1),
                            ),
                            Spacer(),
                            context.locale.languageCode == "ar"
                                ? Transform.rotate(
                                    angle: 180 * math.pi / 180,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: customSvg(
                                        name: forward1,
                                        width: context.width / 24,
                                        height: context.width / 24,
                                      ),
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    child: customSvg(
                                      name: forward1,
                                      width: context.width / 24,
                                      height: context.width / 24,
                                    ),
                                  ),
                            SizedBox(width: context.width / 12),
                          ],
                        ),
                      ),
                      SizedBox(height: context.height / 30),
                    ],

                    if (!Const.isTeacher) ...[
                      InkWell(
                        onTap: () {
                          context.pushNamed(name: certificateSc);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: context.width / 15),
                            Container(
                              alignment: Alignment.center,
                              child: customSvg(
                                name: certificate,
                                width: context.width / 20,
                                height: context.width / 20,
                              ),
                            ),
                            SizedBox(width: context.width / 30),
                            Text(
                              tr("certificates"),
                              style: TextStyles.textStyleBold12.copyWith(
                                color: primary,
                              ),
                              textScaler: TextScaler.linear(1),
                            ),
                            Spacer(),
                            context.locale.languageCode == "ar"
                                ? Transform.rotate(
                                    angle: 180 * math.pi / 180,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: customSvg(
                                        name: forward1,
                                        width: context.width / 24,
                                        height: context.width / 24,
                                      ),
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    child: customSvg(
                                      name: forward1,
                                      width: context.width / 24,
                                      height: context.width / 24,
                                    ),
                                  ),
                            SizedBox(width: context.width / 12),
                          ],
                        ),
                      ),
                      SizedBox(height: context.height / 30),
                    ],
                  ],
                ),
              ),
              SizedBox(height: context.height / 55),
              Container(
                padding: EdgeInsets.only(
                  top: context.height / 30,
                  bottom: context.height / 40,
                ),
                decoration: BoxDecoration(
                  color: greyLight,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: context.width / 15,
                        right: context.width / 15,
                      ),
                      child: Text(
                        tr("quick_links"),
                        style: TextStyles.textStyleBold12.copyWith(
                          color: orangeBold,
                          fontWeight: FontWeight.w800,
                        ),
                        textScaler: TextScaler.linear(1),
                      ),
                    ),
                    SizedBox(height: context.height / 45),
                    if (!Const.isTeacher) ...[
                      InkWell(
                        onTap: () {
                          context.pushNamed(name: favouriteSc);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: context.width / 15),

                            Container(
                              alignment: Alignment.center,
                              child: customSvg(
                                name: heart2,
                                width: context.width / 20,
                                height: context.width / 20,
                              ),
                            ),
                            SizedBox(width: context.width / 30),
                            Text(
                              tr("favorites"),
                              style: TextStyles.textStyleBold12.copyWith(
                                color: primary,
                              ),
                              textScaler: TextScaler.linear(1),
                            ),
                            Spacer(),
                            context.locale.languageCode == "ar"
                                ? Transform.rotate(
                                    angle: 180 * math.pi / 180,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: customSvg(
                                        name: forward1,
                                        width: context.width / 24,
                                        height: context.width / 24,
                                      ),
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    child: customSvg(
                                      name: forward1,
                                      width: context.width / 24,
                                      height: context.width / 24,
                                    ),
                                  ),

                            SizedBox(width: context.width / 12),
                          ],
                        ),
                      ),
                      SizedBox(height: context.height / 30),
                    ],

                    InkWell(
                      onTap: () {
                        context.pushNamed(
                          name: successStoriesSc,
                          args: "stories",
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: context.width / 15),
                          Container(
                            alignment: Alignment.center,
                            child: customSvg(
                              name: review,
                              width: context.width / 20,
                              height: context.width / 20,
                            ),
                          ),
                          SizedBox(width: context.width / 30),
                          Text(
                            tr("our_reviews"),
                            style: TextStyles.textStyleBold12.copyWith(
                              color: primary,
                            ),
                            textScaler: TextScaler.linear(1),
                          ),
                          Spacer(),
                          context.locale.languageCode == "ar"
                              ? Transform.rotate(
                                  angle: 180 * math.pi / 180,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: customSvg(
                                      name: forward1,
                                      width: context.width / 24,
                                      height: context.width / 24,
                                    ),
                                  ),
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  child: customSvg(
                                    name: forward1,
                                    width: context.width / 24,
                                    height: context.width / 24,
                                  ),
                                ),
                          SizedBox(width: context.width / 12),
                        ],
                      ),
                    ),

                    SizedBox(height: context.height / 30),
                    InkWell(
                      onTap: () {
                        context.pushNamed(name: blogSc, args: 0);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: context.width / 15),
                          Container(
                            alignment: Alignment.center,
                            child: customSvg(
                              name: blog1,
                              width: context.width / 20,
                              height: context.width / 20,
                            ),
                          ),
                          SizedBox(width: context.width / 30),
                          Text(
                            tr("blog"),
                            style: TextStyles.textStyleBold12.copyWith(
                              color: primary,
                            ),
                            textScaler: TextScaler.linear(1),
                          ),
                          Spacer(),
                          context.locale.languageCode == "ar"
                              ? Transform.rotate(
                                  angle: 180 * math.pi / 180,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: customSvg(
                                      name: forward1,
                                      width: context.width / 24,
                                      height: context.width / 24,
                                    ),
                                  ),
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  child: customSvg(
                                    name: forward1,
                                    width: context.width / 24,
                                    height: context.width / 24,
                                  ),
                                ),

                          SizedBox(width: context.width / 12),
                        ],
                      ),
                    ),
                    //  SizedBox(height: context.height/30,),

                    /* InkWell(
                      onTap: (){
                       // context.pushNamed(name: pointsSc);
                      },
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: context.width/15,),
                          Container(
                              alignment: Alignment.center,
                              child: customSvg(name:points,width: context.width/20,height: context.width/20)),
                          SizedBox(width: context.width/30,),
                          Text(tr("points"),style: TextStyles.textStyleBold12
                              .copyWith(color: primary),textScaler: TextScaler.linear(1),),
                          Spacer(),
                          context.locale.languageCode == "ar" ?
                          Transform.rotate(
                            angle: 180 * math.pi / 180,
                            child:  Container(
                                alignment: Alignment.center,
                                child: customSvg(name: forward1,width: context.width/24
                                    ,height: context.width/24)),

                          ) :Container(
                              alignment: Alignment.center,
                              child: customSvg(name: forward1,width: context.width/24
                                  ,height: context.width/24)),

                          SizedBox(width: context.width/12,)
                        ],),),*/
                    SizedBox(height: context.height / 60),
                  ],
                ),
              ),
              SizedBox(height: context.height / 55),
              Container(
                padding: EdgeInsets.only(
                  top: context.height / 30,
                  bottom: context.height / 40,
                ),
                decoration: BoxDecoration(
                  color: greyLight,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: context.width / 15,
                        right: context.width / 15,
                      ),
                      child: Text(
                        tr("regulations_policies"),
                        style: TextStyles.textStyleBold12.copyWith(
                          color: orangeBold,
                          fontWeight: FontWeight.w800,
                        ),
                        textScaler: TextScaler.linear(1),
                      ),
                    ),
                    SizedBox(height: context.height / 40),
                    InkWell(
                      onTap: () {
                        context.pushNamed(name: aboutUsSc);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: context.width / 15),
                          Container(
                            alignment: Alignment.center,
                            child: customSvg(
                              name: about,
                              width: context.width / 20,
                              height: context.width / 20,
                            ),
                          ),
                          SizedBox(width: context.width / 30),
                          Text(
                            tr("about_us"),
                            style: TextStyles.textStyleBold12.copyWith(
                              color: primary,
                            ),
                            textScaler: TextScaler.linear(1),
                          ),
                          Spacer(),
                          context.locale.languageCode == "ar"
                              ? Transform.rotate(
                                  angle: 180 * math.pi / 180,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: customSvg(
                                      name: forward1,
                                      width: context.width / 24,
                                      height: context.width / 24,
                                    ),
                                  ),
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  child: customSvg(
                                    name: forward1,
                                    width: context.width / 24,
                                    height: context.width / 24,
                                  ),
                                ),
                          SizedBox(width: context.width / 12),
                        ],
                      ),
                    ),
                    SizedBox(height: context.height / 30),
                    InkWell(
                      onTap: () {
                        context.pushNamed(name: termsAndConditions);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: context.width / 15),
                          Container(
                            alignment: Alignment.center,
                            child: customSvg(
                              name: terms,
                              width: context.width / 20,
                              height: context.width / 20,
                            ),
                          ),
                          SizedBox(width: context.width / 30),
                          Text(
                            tr("terms_conditions"),
                            style: TextStyles.textStyleBold12.copyWith(
                              color: primary,
                            ),
                            textScaler: TextScaler.linear(1),
                          ),
                          Spacer(),
                          context.locale.languageCode == "ar"
                              ? Transform.rotate(
                                  angle: 180 * math.pi / 180,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: customSvg(
                                      name: forward1,
                                      width: context.width / 24,
                                      height: context.width / 24,
                                    ),
                                  ),
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  child: customSvg(
                                    name: forward1,
                                    width: context.width / 24,
                                    height: context.width / 24,
                                  ),
                                ),
                          SizedBox(width: context.width / 12),
                        ],
                      ),
                    ),
                    /*  SizedBox(height: context.height/30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: context.width/15,),
                        Container(
                            alignment: Alignment.center,
                            child: customSvg(name: policy,width: context.width/20,height: context.width/20)),
                        SizedBox(width: context.width/30,),
                        Text(tr("privacy_policy"),style: TextStyles.textStyleBold12
                            .copyWith(color: primary),textScaler: TextScaler.linear(1),),
                        Spacer(),
                        context.locale.languageCode == "ar" ?
                        Transform.rotate(
                          angle: 180 * math.pi / 180,
                          child:  Container(
                              alignment: Alignment.center,
                              child: customSvg(name: forward1,width: context.width/24
                                  ,height: context.width/24)),

                        ) :Container(
                            alignment: Alignment.center,
                            child: customSvg(name: forward1,width: context.width/24
                                ,height: context.width/24)),
                        SizedBox(width: context.width/12,)
                      ],),*/
                    SizedBox(height: context.height / 30),
                    InkWell(
                      onTap: () {
                        context.pushNamed(name: frequentlyAsked);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: context.width / 15),
                          Container(
                            alignment: Alignment.center,
                            child: customSvg(
                              name: carrier,
                              width: context.width / 22,
                              height: context.width / 22,
                            ),
                          ),
                          SizedBox(width: context.width / 30),
                          Text(
                            tr("frequently_asked_questions"),
                            style: TextStyles.textStyleBold12.copyWith(
                              color: primary,
                            ),
                            textScaler: TextScaler.linear(1),
                          ),
                          Spacer(),
                          context.locale.languageCode == "ar"
                              ? Transform.rotate(
                                  angle: 180 * math.pi / 180,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: customSvg(
                                      name: forward1,
                                      width: context.width / 24,
                                      height: context.width / 24,
                                    ),
                                  ),
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  child: customSvg(
                                    name: forward1,
                                    width: context.width / 24,
                                    height: context.width / 24,
                                  ),
                                ),
                          SizedBox(width: context.width / 12),
                        ],
                      ),
                    ),
                    SizedBox(height: context.height / 60),
                  ],
                ),
              ),
              SizedBox(height: context.height / 55),
              Container(
                padding: EdgeInsets.only(
                  top: context.height / 30,
                  bottom: context.height / 40,
                ),
                decoration: BoxDecoration(
                  color: greyLight,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: context.width / 15,
                        right: context.width / 15,
                      ),
                      child: Text(
                        tr("help_center"),
                        style: TextStyles.textStyleBold12.copyWith(
                          color: orangeBold,
                          fontWeight: FontWeight.w800,
                        ),
                        textScaler: TextScaler.linear(1),
                      ),
                    ),
                    SizedBox(height: context.height / 40),
                    InkWell(
                      onTap: () {
                        //  context.read<ProfileCubit>().sendEmail(email:context.read<ProfileCubit>().settingsResponse!.data![0] )
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: context.width / 15),
                          Container(
                            alignment: Alignment.center,
                            child: customSvg(
                              name: contactUs,
                              width: context.width / 20,
                              height: context.width / 20,
                            ),
                          ),
                          SizedBox(width: context.width / 30),
                          Text(
                            tr("contact_us_via_email"),
                            style: TextStyles.textStyleBold12.copyWith(
                              color: primary,
                            ),
                            textScaler: TextScaler.linear(1),
                          ),
                          Spacer(),
                          context.locale.languageCode == "ar"
                              ? Transform.rotate(
                                  angle: 180 * math.pi / 180,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: customSvg(
                                      name: forward1,
                                      width: context.width / 24,
                                      height: context.width / 24,
                                    ),
                                  ),
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  child: customSvg(
                                    name: forward1,
                                    width: context.width / 24,
                                    height: context.width / 24,
                                  ),
                                ),
                          SizedBox(width: context.width / 12),
                        ],
                      ),
                    ),
                    SizedBox(height: context.height / 30),
                    BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        return context.read<ProfileCubit>().loading == true
                            ? SpinKitPulse(color: primary, size: 20)
                            : InkWell(
                                onTap: () {
                                  context.read<ProfileCubit>().openWhatsapp(
                                    context: context,
                                    text:
                                        "Hello This is a text from Dr.NadaSalma",
                                    number: context
                                        .read<ProfileCubit>()
                                        .settingsResponse!
                                        .data![0]
                                        .phoneContact!,
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: context.width / 15),
                                    Container(
                                      alignment: Alignment.center,
                                      child: customSvg(
                                        name: whatsApp,
                                        width: context.width / 20,
                                        height: context.width / 20,
                                      ),
                                    ),
                                    SizedBox(width: context.width / 30),
                                    Text(
                                      tr("contact_us_via_whatsApp"),
                                      style: TextStyles.textStyleBold12
                                          .copyWith(color: primary),
                                      textScaler: TextScaler.linear(1),
                                    ),
                                    Spacer(),
                                    context.locale.languageCode == "ar"
                                        ? Transform.rotate(
                                            angle: 180 * math.pi / 180,
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: customSvg(
                                                name: forward1,
                                                width: context.width / 24,
                                                height: context.width / 24,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            alignment: Alignment.center,
                                            child: customSvg(
                                              name: forward1,
                                              width: context.width / 24,
                                              height: context.width / 24,
                                            ),
                                          ),
                                    SizedBox(width: context.width / 12),
                                  ],
                                ),
                              );
                      },
                    ),
                    SizedBox(height: context.height / 50),
                  ],
                ),
              ),
              SizedBox(height: context.height / 55),
              Container(
                padding: EdgeInsets.only(
                  top: context.height / 30,
                  bottom: context.height / 30,
                ),
                decoration: BoxDecoration(
                  color: greyLight,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                child: Column(
                  children: [
                    BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        return context.read<ProfileCubit>().settingsLoading ==
                                true
                            ? SpinKitPulse(color: primary, size: 15)
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: customSvg(
                                      name: logo,
                                      width: context.width / 3,
                                      height: context.width / 3,
                                    ),
                                  ),
                                  SizedBox(height: context.height / 50),
                                  Text(
                                    context
                                        .read<ProfileCubit>()
                                        .settingsResponse!
                                        .data![0]
                                        .siteName,
                                    style: TextStyles.textStyleBold15.copyWith(
                                      color: primary,
                                    ),
                                    textScaler: TextScaler.linear(1),
                                  ),
                                  SizedBox(height: context.height / 40),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: context.height / 30,
                                      right: context.height / 30,
                                    ),
                                    child: Text(
                                      context
                                          .read<ProfileCubit>()
                                          .settingsResponse!
                                          .data![0]
                                          .siteDescription,
                                      style: TextStyles.textStyleNormal12
                                          .copyWith(color: primary),
                                      textScaler: TextScaler.linear(1),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(height: context.height / 40),
                                  Text(
                                    context
                                        .read<ProfileCubit>()
                                        .settingsResponse!
                                        .data![0]
                                        .siteAddress,
                                    style: TextStyles.textStyleNormal12
                                        .copyWith(color: primary),
                                    textScaler: TextScaler.linear(1),
                                  ),
                                  SizedBox(height: context.height / 40),
                                  Text(
                                    context
                                        .read<ProfileCubit>()
                                        .settingsResponse!
                                        .data![0]
                                        .phoneContact,
                                    style: TextStyles.textStyleNormal12
                                        .copyWith(color: primary),
                                    textScaler: TextScaler.linear(1),
                                  ),
                                ],
                              );
                      },
                    ),
                    SizedBox(width: context.width / 12),
                  ],
                ),
              ),
              SizedBox(height: context.height / 30),
            ],
          ),
        ),
      ),
    );
  }
}
