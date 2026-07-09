import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/exceptions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/data/home_remote_data_source_impl.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_details_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_details_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/hero_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/public_courses_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/success_stories_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/watch_course_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/watch_course_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/repositories/home_repositories.dart';

class HomeRepositoryImpl implements HomeRepositories {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepositoryImpl(this.homeRemoteDataSource);

  @override
  Future<Either<Failure, SuccessStoriesResponse>> getSuccessStories() async {
    try {
      final response = await homeRemoteDataSource.getSuccessStories();
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
  Future<Either<Failure, HeroResponse>> getHeroes() async {
    try {
      final response = await homeRemoteDataSource.getHeroes();
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
  Future<Either<Failure, PublicCoursesResponse>> getCourses({
    CoursesParams? params,
  }) async {
    try {
      final response = await homeRemoteDataSource.getCourses(params: params!);
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
  Future<Either<Failure, CoursesDetailsResponse>> getCoursesDetails({
    CoursesDetailsParams? params,
  }) async {
    try {
      final response = await homeRemoteDataSource.getCoursesDetails(
        params: CoursesDetailsParams(slug: params!.slug),
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
  Future<Either<Failure, PublicCoursesResponse>> getPrivateLessons({
    CoursesParams? params,
  }) async {
    try {
      final response = await homeRemoteDataSource.getPrivateLessons(
        params: params!,
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
  Future<Either<Failure, WatchCourseResponse>> watchCourse({
    WatchCourseParams? params,
  }) async {
    try {
      final response = await homeRemoteDataSource.watchCourse(params: params!);
      return Right(response);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnAuthorizedException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnprocessableContentException catch (e) {
      return left(ServerFailure(message: e.message));
    } on ForbiddenException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, dynamic>> requestCourseBooking({
    required List<int> courseIds,
    String? couponCode,
  }) async {
    try {
      final response = await homeRemoteDataSource.requestCourseBooking(
        courseIds: courseIds,
        couponCode: couponCode,
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
    }
  }
}
