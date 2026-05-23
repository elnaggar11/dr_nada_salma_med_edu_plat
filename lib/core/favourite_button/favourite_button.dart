import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/local/auth_local_data_source.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/presentation/cubit/favourite_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/injection_container/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FavouriteButton extends StatefulWidget {
  final bool isFavourite;
  final String courseId;
  final int? index;
  final double height;
  final double width;

  const FavouriteButton({
    super.key,
    required this.isFavourite,
    required this.courseId,
    this.index,
    this.height = 30,
    this.width = 30,
  });

  @override
  State<FavouriteButton> createState() => _FavouriteButtonScreenState();
}

class _FavouriteButtonScreenState extends State<FavouriteButton> {
  bool loading = false;
  late bool fvv;

  @override
  void initState() {
    fvv = widget.isFavourite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouriteCubit, FavouriteState>(
      listener: (context, state) {},
      buildWhen: (previous, current) => current != previous,
      builder: (context, state) {
        final bloc = BlocProvider.of<FavouriteCubit>(context, listen: false);

        return InkWell(
          onTap: () async {
            final token = sharedPreferences.get(cacheTokenConst);
            if (token.toString() == '0' || token == null || token == "") {
              /* return showDialog(
                  context: context,
                  useSafeArea: true,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return BackToLogin();
                  });*/
            } else {
              setState(() {
                fvv == false ? fvv = true : fvv = false;
              });
              await bloc.doFavourite(fvv, widget.courseId);
              //  await bloc.doFavourite(fvv, widget.adId);
            }
          },
          child: BlocBuilder<FavouriteCubit, FavouriteState>(
            builder: (context, state) {
              return bloc.loading
                  ? const Center(
                      child: SizedBox(
                        width: 10,
                        height: 10,
                        child: SpinKitPulse(color: white),
                      ),
                    )
                  : fvv
                  ? Container(
                      margin: EdgeInsets.all(7),
                      padding: EdgeInsets.all(11),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: red,
                      ),
                      child: customSvg(name: heart, color: white),
                    )
                  : Container(
                      margin: EdgeInsets.all(7),
                      padding: EdgeInsets.all(11),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: white,
                      ),
                      child: customSvg(name: heart),
                    );
            },
          ),
        );
      },
    );
  }
}
