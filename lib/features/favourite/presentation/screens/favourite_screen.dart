import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/presentation/cubit/favourite_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/presentation/widgets/favourite_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    context.read<FavouriteCubit>().getFavouritesByUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: customAppBar(
        appBarInd: 0,
        title: tr("favorites"),
        context: context,
        status: false,
        widget: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customSvg(name: delete, color: red),
            SizedBox(width: context.width / 50),
            Text(
              tr("clear_all"),
              style: TextStyles.textStyleNormal12.copyWith(
                color: red,
                fontWeight: FontWeight.w500,
              ),
              textScaler: TextScaler.linear(1),
            ),
          ],
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: BlocBuilder<FavouriteCubit, FavouriteState>(
          builder: (context, state) {
            return context.read<FavouriteCubit>().favLoading == true
                ? Center(child: SpinKitPulse(color: primary, size: 50))
                : (context.read<FavouriteCubit>().favouriteResponse == null ||
                      context
                          .read<FavouriteCubit>()
                          .favouriteResponse!
                          .data!
                          .isEmpty)
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(color: white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: customSvg(
                            name: heart,
                            color: primary,
                            width: context.width / 5,
                            height: context.width / 5,
                          ),
                        ),
                        SizedBox(height: context.height / 80),
                        Text(
                          tr("no_favourite"),
                          style: TextStyles.textStyleBold15.copyWith(
                            color: primary,
                          ),
                          textScaler: TextScaler.linear(1),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: context
                        .read<FavouriteCubit>()
                        .favouriteResponse!
                        .data!
                        .length,
                    padding: EdgeInsets.only(top: 0),
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => FavouriteItem(
                      data: context
                          .read<FavouriteCubit>()
                          .favouriteResponse!
                          .data![index],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
