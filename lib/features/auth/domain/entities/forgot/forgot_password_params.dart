class ForgotPasswordParams {
  String? email;

  ForgotPasswordParams({this.email});

  Map<String,dynamic>toMap(){
    return {
      "email" : email
    };
  }
}