class CheckOtpParams {
  String? otp;
  String? email;

  CheckOtpParams({this.otp, this.email});

  Map<String, dynamic> toMap() {
    return {"email": email, "otp": otp};
  }
}
