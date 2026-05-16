
import 'package:dr_nada_salma_med_edu_plat/core/utils/api_base_helper.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/auth_inj.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/blog_inj.dart';
import 'package:dr_nada_salma_med_edu_plat/features/bottom_bar/bottom_bar_inj.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/courses_inj.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/favourite_inj.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/home_inj.dart';
import 'package:dr_nada_salma_med_edu_plat/features/notifications/notification_inj.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/profile_inj.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences sharedPreferences;
final sl = GetIt.instance;
final helper = ApiBaseHelper();

Future<void>init()async{
  sharedPreferences = await SharedPreferences.getInstance();
  helper.dioInit();
  sl.registerLazySingleton(()=> helper);
  sl.registerLazySingleton(()=> sharedPreferences);


  await authInj(sl);
  await coursesInj(sl);
  await initBlogInj(sl);
  await initProfileInj(sl);
  await initHomeInj(sl);
  await initBottomBarInj(sl);
  await initFavouriteInj(sl);
  await notificationsInj(sl);
}