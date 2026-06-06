class RegisterParams {
  String? fullName;
  String? phoneNumber;
  String? email;
  String? password;
  String? passwordConfirmation;
  dynamic countryCode;
  dynamic countrySymbol;

  RegisterParams({
    this.fullName,
    this.phoneNumber,
    this.email,
    this.password,
    this.passwordConfirmation,
    this.countryCode,
    this.countrySymbol,
  });

  Map<String, dynamic> toMap() {
    return {
      "full_name": fullName,
      if (phoneNumber != null && phoneNumber!.isNotEmpty)
        "phone_number": phoneNumber,
      "email": email,
      // "country_code": countryCode.toString(),
      // "country_symbol": countrySymbol.toString(),
      "password": password,
      "password_confirmation": passwordConfirmation,
    };
  }
}
