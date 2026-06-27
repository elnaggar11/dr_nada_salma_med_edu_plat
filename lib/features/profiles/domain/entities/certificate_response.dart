class CertificateResponse {
  bool? status;
  String? message;
  List<Data>? data;

  CertificateResponse({this.status, this.message, this.data});

  CertificateResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  dynamic title;
  dynamic slug;
  dynamic semiDescription;
  dynamic longDescription;
  dynamic categoryName;
  dynamic issuedAt;
  dynamic imageCertificate;
  dynamic studentName;

  Data({
    this.id,
    this.title,
    this.slug,
    this.semiDescription,
    this.longDescription,
    this.categoryName,
    this.issuedAt,
    this.imageCertificate,
    this.studentName,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] ?? json['course_title'];
    slug = json['slug'];
    semiDescription = json['semi_description'];
    longDescription = json['long_description'];
    categoryName = json['category_name'];
    issuedAt = json['issued_at'];
    imageCertificate = json['image_certificate'];
    studentName = json['student_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['semi_description'] = semiDescription;
    data['long_description'] = longDescription;
    data['category_name'] = categoryName;
    data['issued_at'] = issuedAt;
    data['image_certificate'] = imageCertificate;
    data['student_name'] = studentName;
    return data;
  }
}
