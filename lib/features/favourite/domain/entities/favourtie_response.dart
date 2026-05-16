class FavouriteResponse {
  bool? status;
  String? message;
  List<Data>? data;

  FavouriteResponse({this.status, this.message, this.data});

  FavouriteResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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
  Course? course;

  Data({this.id, this.course});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    course =
    json['course'] != null ? new Course.fromJson(json['course']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (course != null) {
      data['course'] = course!.toJson();
    }
    return data;
  }
}

class Course {
  int? id;
  dynamic title;
  dynamic slug;
  dynamic totalHours;
  dynamic semiDescription;
  dynamic longDescription;
  dynamic price;
  dynamic priceAfterDiscount;
  dynamic image;
  dynamic points;
  dynamic reviewsCount;
  dynamic categoryName;
  dynamic averageRating;
  bool? favorited;
  bool? canWatchCourse;
  List<Reviews>? reviews;
  ButtonActions? buttonActions;

  Course(
      {this.id,
        this.title,
        this.slug,
        this.totalHours,
        this.semiDescription,
        this.longDescription,
        this.price,
        this.priceAfterDiscount,
        this.image,
        this.points,
        this.reviewsCount,
        this.categoryName,
        this.averageRating,
        this.favorited,
        this.canWatchCourse,
        this.reviews,
        this.buttonActions});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    totalHours = json['total_hours'];
    semiDescription = json['semi_description'];
    longDescription = json['long_description'];
    price = json['price'];
    priceAfterDiscount = json['price_after_discount'];
    image = json['image'];
    points = json['points'];
    reviewsCount = json['reviews_count'];
    categoryName = json['category_name'];
    averageRating = json['average_rating'];
    favorited = json['favorited'];
    canWatchCourse = json['can_watch_course'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    buttonActions = json['button_actions'] != null
        ? new ButtonActions.fromJson(json['button_actions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['total_hours'] = totalHours;
    data['semi_description'] = semiDescription;
    data['long_description'] = longDescription;
    data['price'] = price;
    data['price_after_discount'] = priceAfterDiscount;
    data['image'] = image;
    data['points'] = points;
    data['reviews_count'] = reviewsCount;
    data['category_name'] = categoryName;
    data['average_rating'] = averageRating;
    data['favorited'] = favorited;
    data['can_watch_course'] = canWatchCourse;
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    if (buttonActions != null) {
      data['button_actions'] = buttonActions!.toJson();
    }
    return data;
  }
}

class Reviews {
  int? id;
  User? user;
  String? courseName;
  int? courseId;
  String? content;
  String? rating;
  String? createdAt;

  Reviews(
      {this.id,
        this.user,
        this.courseName,
        this.courseId,
        this.content,
        this.rating,
        this.createdAt});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    courseName = json['course_name'];
    courseId = json['course_id'];
    content = json['content'];
    rating = json['rating'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['course_name'] = courseName;
    data['course_id'] = courseId;
    data['content'] = content;
    data['rating'] = rating;
    data['created_at'] = createdAt;
    return data;
  }
}

class User {
  int? id;
  String? fullName;
  String? image;

  User({this.id, this.fullName, this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['image'] = image;
    return data;
  }
}

class ButtonActions {
  bool? enrollNow;
  bool? addToCart;
  bool? viewCourse;
  bool? reviewCourse;

  ButtonActions(
      {this.enrollNow, this.addToCart, this.viewCourse, this.reviewCourse});

  ButtonActions.fromJson(Map<String, dynamic> json) {
    enrollNow = json['enroll_now'];
    addToCart = json['add_to_cart'];
    viewCourse = json['view_course'];
    reviewCourse = json['review_course'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['enroll_now'] = enrollNow;
    data['add_to_cart'] = addToCart;
    data['view_course'] = viewCourse;
    data['review_course'] = reviewCourse;
    return data;
  }
}