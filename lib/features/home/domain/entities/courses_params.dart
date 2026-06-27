class CoursesParams {
  final String? categoryId;
  final String? courseName;
  final String? topRated;
  final String? courseStatus;
  final String? isEnded;
  final int page;
  final int limit;
  String? type;

  CoursesParams({
    this.categoryId,
    this.type,
    this.courseName,
    this.topRated,
    this.courseStatus,
    this.isEnded,
    this.page = 1,
    this.limit = 10,
  });

  CoursesParams copyWith({
    String? categoryId,
    String? courseName,
    String? topRated,
    String? courseStatus,
    String? isEnded,
    int? page,
    int? limit,
  }) {
    return CoursesParams(
      categoryId: categoryId ?? this.categoryId,
      courseName: courseName ?? this.courseName,
      topRated: topRated ?? this.topRated,
      courseStatus: courseStatus ?? this.courseStatus,
      isEnded: isEnded ?? this.isEnded,
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }
}
