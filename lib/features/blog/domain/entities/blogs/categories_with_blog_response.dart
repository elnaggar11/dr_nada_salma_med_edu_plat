class CategoriesWithBlogResponse {
  bool? status;
  String? message;
  List<Data>? data;

  CategoriesWithBlogResponse({this.status, this.message, this.data});

  CategoriesWithBlogResponse.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? slug;
  dynamic description;
  List<Blogs>? blogs;

  Data({this.name, this.slug, this.description, this.blogs});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    if (json['blogs'] != null) {
      blogs = <Blogs>[];
      json['blogs'].forEach((v) {
        blogs!.add(Blogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['slug'] = slug;
    data['description'] = description;
    if (blogs != null) {
      data['blogs'] = blogs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Blogs {
  int? id;
  dynamic title;
  dynamic description;
  dynamic slug;
  dynamic image;
  dynamic status;
  dynamic timePublish;
  dynamic isActive;
  dynamic metaTitle;
  dynamic metaDescription;
  dynamic categoryId;
  dynamic createdAt;

  Blogs(
      {this.id,
        this.title,
        this.description,
        this.slug,
        this.image,
        this.status,
        this.timePublish,
        this.isActive,
        this.metaTitle,
        this.metaDescription,
        this.categoryId,
        this.createdAt});

  Blogs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    slug = json['slug'];
    image = json['image'];
    status = json['status'];
    timePublish = json['time_publish'];
    isActive = json['is_active'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['slug'] = slug;
    data['image'] = image;
    data['status'] = status;
    data['time_publish'] = timePublish;
    data['is_active'] = isActive;
    data['meta_title'] = metaTitle;
    data['meta_description'] = metaDescription;
    data['category_id'] = categoryId;
    data['created_at'] = createdAt;
    return data;
  }
}