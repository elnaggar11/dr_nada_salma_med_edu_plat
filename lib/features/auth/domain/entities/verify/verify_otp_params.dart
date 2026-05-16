class VerifyOtpParams {
  String? email;
  String? otp;
  String? type;
  String? fcmToken;

  VerifyOtpParams({this.email, this.otp,this.type,this.fcmToken});

  Map<String,dynamic>toMap(){
    return {
      "email" : email,
      "otp" : otp,
      "fcm_token" : fcmToken
    };
  }
}