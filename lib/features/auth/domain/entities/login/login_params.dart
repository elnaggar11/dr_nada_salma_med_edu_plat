import 'package:dr_nada_salma_med_edu_plat/core/utils/const.dart';

class LoginParams {
  String? email;
  String? password;
  String? fcmToken;
  bool isTeacher;

  LoginParams({this.email, this.password, this.fcmToken, bool? isTeacher})
    : isTeacher = isTeacher ?? Const.isTeacher;

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "password": password,
      "fcm_token": fcmToken,
      "is_teacher": isTeacher ? 1 : 0,
    };
  }
}
