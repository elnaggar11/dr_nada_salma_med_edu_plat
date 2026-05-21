class CoursesParams {
  final String? categoryId;
  final String? courseName;
  final String? topRated;
  final int page;
  final int limit;
  String? type;

  CoursesParams({
    this.categoryId,
    this.type,
    this.courseName,
    this.topRated,
    this.page = 1,
    this.limit = 10,
  });

  CoursesParams copyWith({
    String? categoryId,
    String? courseName,
    String? topRated,
    int? page,
    int? limit,
  }) {
    return CoursesParams(
      categoryId: categoryId ?? this.categoryId,
      courseName: courseName ?? this.courseName,
      topRated: topRated ?? this.topRated,
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }
}
