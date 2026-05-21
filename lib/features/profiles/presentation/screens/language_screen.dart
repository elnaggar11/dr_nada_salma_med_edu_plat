import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/fade_button.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/lang/language_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/widgets/language_item.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/injection_container/injection_container.dart'
    as di;

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        appBarInd: 0,
        widget: SizedBox(),
        title: tr("language"),
        status: false,
        context: context,
      ),
      backgroundColor: white,
      body: Column(
        children: [
          BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, state) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: context.read<LanguageCubit>().items.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return LanguageItem(
                    item: context.read<LanguageCubit>().items[index],
                    index: index,
                  );
                },
              );
            },
          ),
          Spacer(),
          BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, state) {
              return FadeColorButton(
                btnTitle: tr("save"),
                isPressed: false,
                buttonColor: primary,
                onButtonPressed: () {
                  if (context.read<LanguageCubit>().lang! == 'en') {
                    di.helper.updateLocalHeader("en");
                    msgKey.currentState!.showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          "Language has been set to english",
                          style: TextStyles.textStyleNormal13.copyWith(
                            color: white,
                          ),
                          textScaler: TextScaler.linear(1),
                        ),
                      ),
                    );
                    context.setLocale(
                      Locale(context.read<LanguageCubit>().lang!),
                    );
                    context.pushNamedAndRemoveUntil(name: splash);
                  } else {
                    di.helper.updateLocalHeader("ar");
                    msgKey.currentState!.showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          "تـم تغيير اللغـه إلي العـربيـة",
                          style: TextStyles.textStyleNormal13.copyWith(
                            color: white,
                          ),
                          textScaler: TextScaler.linear(1),
                        ),
                      ),
                    );
                    context.setLocale(
                      Locale(context.read<LanguageCubit>().lang!),
                    );
                    context.pushNamedAndRemoveUntil(name: splash);
                  }
                },
              );
            },
          ),
          SizedBox(height: context.height / 30),
        ],
      ),
    );
  }
}
