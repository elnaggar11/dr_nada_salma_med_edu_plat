class PublicCoursesResponse {
  String? status;
  String? message;
  List<Data>? data;
  Pagination? pagination;

  PublicCoursesResponse({
    this.status,
    this.message,
    this.data,
    this.pagination,
  });

  PublicCoursesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
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
  dynamic hourlyRateAfterDiscount;
  dynamic priceBreakdown;
  ButtonActions? buttonActions;
  int? progress;
  String? courseStatus;
  bool? isEnded;

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
    this.buttonActions,
    this.progress,
    this.courseStatus,
    this.isEnded,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    totalHours = json['total_hours'];
    contentsCount = json['contents_count'];
    lecturesCount = json['lectures_count'];
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
    discountPercentage = json['discount_percentage'];
    hasDiscount = json['has_discount'];
    teachersCount = json['teachers_count'];
    minHourlyRate = json['min_hourly_rate'];
    hourlyRateAfterDiscount = json['hourly_rate_after_discount'];
    priceBreakdown = json['price_breakdown'];
    buttonActions = json['button_actions'] != null
        ? ButtonActions.fromJson(json['button_actions'])
        : null;
    progress = json['progress'];
    courseStatus = json['course_status'];
    isEnded = json['is_ended'];
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
    data['hourly_rate_after_discount'] = hourlyRateAfterDiscount;
    data['price_breakdown'] = priceBreakdown;
    if (buttonActions != null) {
      data['button_actions'] = buttonActions!.toJson();
    }
    data['progress'] = progress;
    data['course_status'] = courseStatus;
    data['is_ended'] = isEnded;
    return data;
  }
}

class ButtonActions {
  bool? enrollNow;
  bool? addToCart;
  bool? viewCourse;
  bool? reviewCourse;
  bool? viewReviews;

  ButtonActions({
    this.enrollNow,
    this.addToCart,
    this.viewCourse,
    this.reviewCourse,
    this.viewReviews,
  });

  ButtonActions.fromJson(Map<String, dynamic> json) {
    enrollNow = json['enroll_now'];
    addToCart = json['add_to_cart'];
    viewCourse = json['view_course'];
    reviewCourse = json['review_course'];
    viewReviews = json['view_reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['enroll_now'] = enrollNow;
    data['add_to_cart'] = addToCart;
    data['view_course'] = viewCourse;
    data['review_course'] = reviewCourse;
    data['view_reviews'] = viewReviews;
    return data;
  }
}

class Pagination {
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;

  Pagination({this.currentPage, this.lastPage, this.perPage, this.total});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    lastPage = json['lastPage'];
    perPage = json['perPage'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['lastPage'] = lastPage;
    data['perPage'] = perPage;
    data['total'] = total;
    return data;
  }
}
