import 'package:dr_nada_salma_med_edu_plat/features/bottom_bar/presentation/cubit/bottom_bar_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void> initBottomBarInj(GetIt s) async {
  s.registerFactory(() => BottomBarCubit());
}
