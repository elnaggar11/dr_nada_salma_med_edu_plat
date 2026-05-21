import 'dart:math' as math;

import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/profile/profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProfilesScreen extends StatelessWidget {
  final ProfileCubit profileCubit;

  const MyProfilesScreen({super.key, required this.profileCubit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: customAppBar(
        appBarInd: 0,
        widget: SizedBox(),
        title: tr("my_profile"),
        status: false,
        context: context,
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
                        tr("profile_settings"),
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
                        context.pushNamed(
                          name: editProfileSc,
                          args: profileCubit,
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
                              name: editProfile,
                              width: context.width / 20,
                              height: context.width / 20,
                            ),
                          ),
                          SizedBox(width: context.width / 50),
                          Text(
                            tr("edit_profile_data"),
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
                        context.pushNamed(name: languageSc);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: context.width / 15),
                          Container(
                            alignment: Alignment.center,
                            child: customSvg(
                              name: language,
                              width: context.width / 20,
                              height: context.width / 20,
                            ),
                          ),
                          SizedBox(width: context.width / 30),
                          Text(
                            tr("language"),
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
                        tr("account_settings"),
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
                        showDialog(
                          useRootNavigator: true,
                          useSafeArea: true,
                          context: context,
                          builder: (context) => BlocProvider.value(
                            value: profileCubit,
                            child: AlertDialog(
                              backgroundColor: white,
                              title: Column(
                                children: [
                                  Text(
                                    tr("delete_your_account"),
                                    style: TextStyles.textStyleBold16.copyWith(
                                      color: red,
                                    ),
                                    textScaler: TextScaler.linear(1),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: context.height / 50),
                                  Container(
                                    alignment: Alignment.center,
                                    child: customSvg(
                                      name: logo,
                                      width: context.width / 3,
                                      height: context.width / 3,
                                    ),
                                  ),
                                ],
                              ),
                              content: Text(
                                tr("reversible"),
                                style: TextStyles.textStyleNormal10.copyWith(
                                  color: black,
                                ),
                                textScaler: TextScaler.linear(1),
                                textAlign: TextAlign.center,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  20.0,
                                ), // Adjust the radius as needed
                              ),

                              actions: <Widget>[
                                BlocBuilder<ProfileCubit, ProfileState>(
                                  builder: (context, state) {
                                    return MaterialButton(
                                      color: red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(25),
                                        ),
                                      ),
                                      onPressed: () {
                                        context
                                            .read<ProfileCubit>()
                                            .deleteAccount();
                                      },
                                      child:
                                          context
                                                  .read<ProfileCubit>()
                                                  .deleteLoading ==
                                              true
                                          ? SizedBox(
                                              width: context.width / 16,
                                              height: context.width / 16,
                                              child: CircularProgressIndicator(
                                                color: white,
                                              ),
                                            )
                                          : Text(
                                              tr("delete"),
                                              style: TextStyles.textStyleBold13
                                                  .copyWith(color: white),
                                              textScaler: TextScaler.linear(1),
                                            ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
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
                              name: clear,
                              width: context.width / 20,
                              height: context.width / 20,
                            ),
                          ),
                          SizedBox(width: context.width / 30),
                          Text(
                            tr("delete_account"),
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
                        showDialog(
                          useRootNavigator: true,
                          useSafeArea: true,
                          context: context,
                          builder: (context) => BlocProvider.value(
                            value: profileCubit,
                            child: AlertDialog(
                              backgroundColor: white,
                              title: Column(
                                children: [
                                  Text(
                                    tr("sure_log_out"),
                                    style: TextStyles.textStyleBold16.copyWith(
                                      color: primary,
                                    ),
                                    textScaler: TextScaler.linear(1),
                                    textAlign: TextAlign.center,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: customSvg(
                                      name: logo,
                                      width: context.width / 3,
                                      height: context.width / 3,
                                    ),
                                  ),
                                ],
                              ),
                              content: Text(
                                tr("reversible"),
                                style: TextStyles.textStyleNormal10.copyWith(
                                  color: black,
                                ),
                                textScaler: TextScaler.linear(1),
                                textAlign: TextAlign.center,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  20.0,
                                ), // Adjust the radius as needed
                              ),

                              actions: <Widget>[
                                BlocBuilder<ProfileCubit, ProfileState>(
                                  builder: (context, state) {
                                    return MaterialButton(
                                      color: primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(25),
                                        ),
                                      ),
                                      onPressed: () {
                                        context.read<ProfileCubit>().logOut();
                                      },
                                      child:
                                          context
                                                  .read<ProfileCubit>()
                                                  .logLoading ==
                                              true
                                          ? SizedBox(
                                              width: context.width / 16,
                                              height: context.width / 16,
                                              child: CircularProgressIndicator(
                                                color: white,
                                              ),
                                            )
                                          : Text(
                                              tr("logout"),
                                              style: TextStyles.textStyleBold13
                                                  .copyWith(color: white),
                                              textScaler: TextScaler.linear(1),
                                            ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
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
                              name: logout,
                              width: context.width / 20,
                              height: context.width / 20,
                            ),
                          ),
                          SizedBox(width: context.width / 30),
                          Text(
                            tr("logout"),
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
            ],
          ),
        ),
      ),
    );
  }
}
