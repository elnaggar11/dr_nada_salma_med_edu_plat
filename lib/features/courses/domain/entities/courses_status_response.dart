class CoursesStatusResponse {
  dynamic status;
  String? message;
  List<Data>? data;

  CoursesStatusResponse({this.status, this.message, this.data});

  CoursesStatusResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      if (json['data'] is List) {
        for (var v in json['data']) {
          data!.add(Data.fromJson(v));
        }
      } else if (json['data'] is Map<String, dynamic>) {
        data!.add(Data.fromJson(json['data']));
      }
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
  dynamic totalHours;
  dynamic contentsCount;
  dynamic lecturesCount;
  dynamic semiDescription;
  dynamic longDescription;
  dynamic price;
  dynamic priceAfterDiscount;
  dynamic image;
  dynamic points;
  dynamic reviewsCount;
  dynamic categoryName;
  dynamic averageRating;
  dynamic favorited;
  dynamic canWatchCourse;
  dynamic discountPercentage;
  dynamic hasDiscount;
  dynamic teachersCount;
  dynamic minHourlyRate;
  ButtonActions? buttonActions;
  dynamic progress;

  Data({
    this.id,
    this.title,
    this.slug,
    this.totalHours,
    this.contentsCount,
    this.lecturesCount,
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
    this.discountPercentage,
    this.hasDiscount,
    this.teachersCount,
    this.minHourlyRate,
    this.buttonActions,
    this.progress,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] ?? json['name'];
    slug = json['slug'];
    totalHours = json['total_hours'];
    contentsCount = json['contents_count'];
    lecturesCount = json['lectures_count'];
    semiDescription = json['semi_description'] ?? json['description'];
    longDescription = json['long_description'];
    price = json['price'];
    priceAfterDiscount = json['price_after_discount'];
    image = json['image'];
    points = json['points'];
    reviewsCount = json['reviews_count'];
    categoryName = json['category_name'];
    if (categoryName == null) {
      if (json['specialty'] != null &&
          json['specialty'] is Map &&
          json['specialty']['name'] != null) {
        categoryName = json['specialty']['name'];
      } else if (json['specialties'] != null &&
          json['specialties'] is List &&
          (json['specialties'] as List).isNotEmpty) {
        categoryName = json['specialties'][0]['name'];
      }
    }
    averageRating = json['average_rating'];
    favorited = json['favorited'];
    canWatchCourse = json['can_watch_course'];
    discountPercentage = json['discount_percentage'];
    hasDiscount = json['has_discount'];
    teachersCount = json['teachers_count'];
    minHourlyRate = json['min_hourly_rate'];
    buttonActions = json['button_actions'] != null
        ? ButtonActions.fromJson(json['button_actions'])
        : null;
    progress = json['progress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['total_hours'] = totalHours;
    data['contents_count'] = contentsCount;
    data['lectures_count'] = lecturesCount;
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
    data['discount_percentage'] = discountPercentage;
    data['has_discount'] = hasDiscount;
    data['teachers_count'] = teachersCount;
    data['min_hourly_rate'] = minHourlyRate;
    if (buttonActions != null) {
      data['button_actions'] = buttonActions!.toJson();
    }
    data['progress'] = progress;
    return data;
  }
}

class ButtonActions {
  bool? enrollNow;
  bool? addToCart;
  bool? viewCourse;
  bool? reviewCourse;

  ButtonActions({
    this.enrollNow,
    this.addToCart,
    this.viewCourse,
    this.reviewCourse,
  });

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
