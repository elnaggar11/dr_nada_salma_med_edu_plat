class BlogBySlugResponse {
  bool? status;
  String? message;
  Data? data;

  BlogBySlugResponse({this.status, this.message, this.data});

  BlogBySlugResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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
  dynamic title;
  dynamic description;
  dynamic slug;
  dynamic author;
  dynamic image;
  dynamic status;
  dynamic timePublish;
  dynamic isActive;
  dynamic metaTitle;
  dynamic metaDescription;
  dynamic categoryId;
  dynamic createdAt;
  dynamic categoryName;
  dynamic authorName;
  dynamic authorImage;

  Data({
    this.id,
    this.title,
    this.description,
    this.slug,
    this.author,
    this.image,
    this.status,
    this.timePublish,
    this.isActive,
    this.metaTitle,
    this.metaDescription,
    this.categoryId,
    this.createdAt,
    this.categoryName,
    this.authorName,
    this.authorImage,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    slug = json['slug'];
    author = json['author'];
    image = json['image'];
    status = json['status'];
    timePublish = json['time_publish'];
    isActive = json['is_active'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    categoryName = json['category_name'];
    authorName = json['author_name'];
    authorImage = json['author_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['slug'] = slug;
    data['author'] = author;
    data['image'] = image;
    data['status'] = status;
    data['time_publish'] = timePublish;
    data['is_active'] = isActive;
    data['meta_title'] = metaTitle;
    data['meta_description'] = metaDescription;
    data['category_id'] = categoryId;
    data['created_at'] = createdAt;
    data['category_name'] = categoryName;
    data['author_name'] = authorName;
    data['author_image'] = authorImage;
    return data;
  }
}
