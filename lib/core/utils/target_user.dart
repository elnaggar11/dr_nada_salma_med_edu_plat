import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/profile/profile_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/injection_container/injection_container.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

bool isTargetUser(BuildContext context) {
  try {
    final userId = sharedPreferences.getInt("user_id");
    final userEmail = sharedPreferences.getString("user_email");
    final userFullName = sharedPreferences.getString("user_fullName");
    if (_matchesTargetUser(
      id: userId,
      email: userEmail,
      fullName: userFullName,
    )) {
      return true;
    }
  } catch (_) {}

  try {
    final profileCubit = BlocProvider.of<ProfileCubit>(context, listen: false);
    final profile = profileCubit.profileResponse;
    final profileData = profile?.data;
    return _matchesTargetUser(
      id: profileData?.id,
      email: profileData?.email,
      fullName: profileData?.fullName,
    );
  } catch (_) {
    return false;
  }
}

bool _matchesTargetUser({
  required int? id,
  required String? email,
  required String? fullName,
}) {
  return id == 311 ||
      id == 7 ||
      email == "abdoshams2005@gmail.com" ||
      email == "tamerahmed00009@gmail.com" ||
      fullName == "Abdo Shamss" ||
      fullName == "ebrahim reda";
}
