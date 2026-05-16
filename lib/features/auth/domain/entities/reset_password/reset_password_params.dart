class ResetPasswordParams {
  String? email;
  String? otp;
  String? newPassword;
  String? newPasswordConfirmation;

  ResetPasswordParams({this.email, this.otp, this.newPassword,
    this.newPasswordConfirmation});

  Map<String,dynamic>toMap(){
    return{
      "email" : email,
      "otp" : otp,
      "new_password" : newPassword,
      "new_password_confirmation" : newPasswordConfirmation
    };
  }

}