import 'dart:io';

import 'package:dio/dio.dart';

class UpdateProfileParams{
  String? fullName;
  String? phoneNumber;
  String? email;
  String? password;
  List<int>?specialties;
  List<int>? academicDegrees;
  File? img;

  UpdateProfileParams({this.fullName, this.phoneNumber, this.email,
      this.password, this.specialties, this.academicDegrees, this.img});




}