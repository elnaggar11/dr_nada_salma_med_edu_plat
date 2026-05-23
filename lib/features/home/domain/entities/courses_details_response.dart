class CoursesDetailsResponse {
  bool? status;
  String? message;
  Data? data;

  CoursesDetailsResponse({this.status, this.message, this.data});

  CoursesDetailsResponse.fromJson(Map<String, dynamic> json) {
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
  dynamic favorited;
  bool? canWatchCourse;
  List<Features>? features;
  List<Contents>? contents;
  List<Reviews>? reviews;
  ButtonActions? buttonActions;

  Data({
    this.id,
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
    this.features,
    this.contents,
    this.reviews,
    this.buttonActions,
  });

  Data.fromJson(Map<String, dynamic> json) {
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
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(Features.fromJson(v));
      });
    }
    if (json['contents'] != null) {
      contents = <Contents>[];
      json['contents'].forEach((v) {
        contents!.add(Contents.fromJson(v));
      });
    }

    buttonActions = json['button_actions'] != null
        ? ButtonActions.fromJson(json['button_actions'])
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
    if (features != null) {
      data['features'] = features!.map((v) => v.toJson()).toList();
    }
    if (contents != null) {
      data['contents'] = contents!.map((v) => v.toJson()).toList();
    }
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    if (buttonActions != null) {
      data['button_actions'] = buttonActions!.toJson();
    }
    return data;
  }
}

class Features {
  int? id;
  int? courseId;
  String? feature;

  Features({this.id, this.courseId, this.feature});

  Features.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    feature = json['feature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['course_id'] = courseId;
    data['feature'] = feature;
    return data;
  }
}

class Contents {
  int? id;
  int? courseId;
  String? title;
  int? totalNumLecture;
  String? totalTime;
  List<Lectures>? lectures;

  Contents({
    this.id,
    this.courseId,
    this.title,
    this.totalNumLecture,
    this.totalTime,
    this.lectures,
  });

  Contents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    title = json['title'];
    totalNumLecture = json['total_num_lecture'];
    totalTime = json['total_time'];
    if (json['lectures'] != null) {
      lectures = <Lectures>[];
      json['lectures'].forEach((v) {
        lectures!.add(Lectures.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['course_id'] = courseId;
    data['title'] = title;
    data['total_num_lecture'] = totalNumLecture;
    data['total_time'] = totalTime;
    if (lectures != null) {
      data['lectures'] = lectures!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lectures {
  int? id;
  String? title;
  String? video;
  String? timeMinutes;

  Lectures({this.id, this.title, this.video, this.timeMinutes});

  Lectures.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    video = json['video'];
    timeMinutes = json['time_minutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['video'] = video;
    data['time_minutes'] = timeMinutes;
    return data;
  }
}

class Reviews {
  int? id;
  User? user;
  dynamic courseName;
  dynamic content;
  dynamic rating;
  dynamic createdAt;

  Reviews({
    this.id,
    this.user,
    this.courseName,
    this.content,
    this.rating,
    this.createdAt,
  });

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    courseName = json['course_name'];
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
    data['content'] = content;
    data['rating'] = rating;
    data['created_at'] = createdAt;
    return data;
  }
}

class User {
  int? id;
  dynamic fullName;
  dynamic image;

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
