import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/exceptions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/data/courses_remote_data_sources_impl.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/categories_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/courses_status_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/courses_status_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/teacher/teachers_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/teacher/subject_details_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/teacher/teacher_detail_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/course_reviews_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/repositories/courses_repositories.dart';

class CoursesRepositoryImpl implements CoursesRepositories {
  final CoursesRemoteDataSource coursesRemoteDataSource;

  CoursesRepositoryImpl(this.coursesRemoteDataSource);

  @override
  Future<Either<Failure, CategoriesResponse>> getCategories() async {
    try {
      final response = await coursesRemoteDataSource.getCategories();
      return Right(response);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnAuthorizedException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnprocessableContentException catch (e) {
      return left(ServerFailure(message: e.message));
    } on ForbiddenException catch (e) {
      return left(ServerFailure(message: e.message));
    } on NotFoundException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, CoursesStatusResponse>> getCoursesStatus({
    CoursesStatusParams? params,
  }) async {
    try {
      final response = await coursesRemoteDataSource.getCoursesStatus(
        params: params,
      );
      return Right(response);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnAuthorizedException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnprocessableContentException catch (e) {
      return left(ServerFailure(message: e.message));
    } on ForbiddenException catch (e) {
      return left(ServerFailure(message: e.message));
    } on NotFoundException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getTeacherDetail({
    required int teacherId,
    required int subjectId,
  }) async {
    try {
      final response = await coursesRemoteDataSource.getTeacherDetail(
        teacherId: teacherId,
        subjectId: subjectId,
      );
      return Right(response);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnAuthorizedException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnprocessableContentException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, TeachersResponse>> getTeachers({
    required Map<String, dynamic> query,
  }) async {
    try {
      final response = await coursesRemoteDataSource.getTeachers(query: query);
      return Right(response);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnAuthorizedException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnprocessableContentException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, SubjectDetailsResponse>> getSubjectDetails({
    required int subjectId,
  }) async {
    try {
      final response = await coursesRemoteDataSource.getSubjectDetails(
        subjectId: subjectId,
      );
      return Right(response);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnAuthorizedException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnprocessableContentException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<TeacherReview>>> getTeacherReviews({
    required int teacherId,
  }) async {
    try {
      final response = await coursesRemoteDataSource.getTeacherReviews(
        teacherId: teacherId,
      );
      return Right(response);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnAuthorizedException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnprocessableContentException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<TeacherTimeSlot>>> getTeacherTimeSlots({
    required int teacherId,
  }) async {
    try {
      final response = await coursesRemoteDataSource.getTeacherTimeSlots(
        teacherId: teacherId,
      );
      return Right(response);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnAuthorizedException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnprocessableContentException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> bookTeacher({
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await coursesRemoteDataSource.bookTeacher(body: body);
      return Right(response);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnAuthorizedException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnprocessableContentException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, CourseReviewsResponse>> getCourseReviews({
    required int courseId,
  }) async {
    try {
      final response = await coursesRemoteDataSource.getCourseReviews(
        courseId: courseId,
      );
      return Right(response);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnAuthorizedException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnprocessableContentException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }
}
