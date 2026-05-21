import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/profile/profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogOutWidget extends StatelessWidget {
  const LogOutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(
          left: context.width / 15,
          right: context.width / 15,
        ),

        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        child: Material(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: context.height / 30),
              Text(
                tr("sure_log_out"),
                style: TextStyles.textStyleBold16.copyWith(color: primary),
                textScaler: TextScaler.linear(1),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.height / 30),
              Text(
                "This action is reversible!",
                style: TextStyles.textStyleNormal10.copyWith(color: black),
                textScaler: TextScaler.linear(1),
              ),
              SizedBox(height: context.height / 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      return MaterialButton(
                        color: primary,
                        onPressed: () {},
                        child: context.read<ProfileCubit>().logLoading == true
                            ? SizedBox(
                                width: context.width / 14,
                                height: context.width / 14,
                                child: CircularProgressIndicator(color: white),
                              )
                            : Text(
                                tr("log_out"),
                                style: TextStyles.textStyleBold14.copyWith(
                                  color: primary,
                                ),
                                textScaler: TextScaler.linear(1),
                              ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
