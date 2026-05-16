class ResendOtpParams {
  String? email;

  ResendOtpParams({this.email});

  Map<String,dynamic>toMap(){
    return {
      "email" : email
    };
  }
}