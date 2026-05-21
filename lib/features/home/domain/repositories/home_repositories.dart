import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_details_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_details_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/hero_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/public_courses_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/success_stories_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/watch_course_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/watch_course_response.dart';

abstract class HomeRepositories {
  Future<Either<Failure, SuccessStoriesResponse>> getSuccessStories();
  Future<Either<Failure, HeroResponse>> getHeroes();
  Future<Either<Failure, PublicCoursesResponse>> getCourses({
    CoursesParams? params,
  });
  Future<Either<Failure, PublicCoursesResponse>> getPrivateLessons({
    CoursesParams? params,
  });
  Future<Either<Failure, CoursesDetailsResponse>> getCoursesDetails({
    CoursesDetailsParams params,
  });
  Future<Either<Failure, WatchCourseResponse>> watchCourse({
    WatchCourseParams? params,
  });
}
