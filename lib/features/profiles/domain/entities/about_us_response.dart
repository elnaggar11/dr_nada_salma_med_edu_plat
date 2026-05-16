class AboutUsResponse {
  bool? status;
  String? message;
  Data? data;

  AboutUsResponse({this.status, this.message, this.data});

  AboutUsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  dynamic titleOne;
  dynamic descriptionOne;
  dynamic imageOne;
  dynamic titleTwo;
  dynamic descriptionTwo;
  dynamic imageTwo;

  Data(
      {this.id,
        this.titleOne,
        this.descriptionOne,
        this.imageOne,
        this.titleTwo,
        this.descriptionTwo,
        this.imageTwo});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleOne = json['title_one'];
    descriptionOne = json['description_one'];
    imageOne = json['image_one'];
    titleTwo = json['title_two'];
    descriptionTwo = json['description_two'];
    imageTwo = json['image_two'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title_one'] = titleOne;
    data['description_one'] = descriptionOne;
    data['image_one'] = imageOne;
    data['title_two'] = titleTwo;
    data['description_two'] = descriptionTwo;
    data['image_two'] = imageTwo;
    return data;
  }
}