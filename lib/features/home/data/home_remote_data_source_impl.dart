import 'package:dr_nada_salma_med_edu_plat/core/errors/exceptions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/api_base_helper.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_details_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_details_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/hero_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/public_courses_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/success_stories_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/watch_course_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/watch_course_response.dart';

const successStoriesApi = "/success-stories";
const heroesApi = "/pages/hero";
const coursesApi = "/courses";
const privateLessonsApi = "/courses/courses-private";
const coursesDetailsApi = "/courses/";
const watchCourseApi = "/lectures/watch";

abstract class HomeRemoteDataSource {
  Future<SuccessStoriesResponse>getSuccessStories();
  Future<HeroResponse>getHeroes();
  Future<PublicCoursesResponse>getCourses({CoursesParams params});
  Future<PublicCoursesResponse>getPrivateLessons({CoursesParams params});
  Future<CoursesDetailsResponse>getCoursesDetails({CoursesDetailsParams? params});
  Future<WatchCourseResponse>watchCourse({WatchCourseParams params});
}
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiBaseHelper helper;

  HomeRemoteDataSourceImpl(this.helper);

  @override
  Future<SuccessStoriesResponse> getSuccessStories() async {
    try {
      final response = await helper.get(url: successStoriesApi);
      return SuccessStoriesResponse.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<HeroResponse> getHeroes() async{
    try {
      final response = await helper.get(url: heroesApi);
      return HeroResponse.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<PublicCoursesResponse> getCourses({CoursesParams? params}) async{
    try {
      final response = params!.type == "filter" ?
          await helper.get(url: '$coursesApi?page=${params.page}?category_id=${params.categoryId}&course_name=${params.courseName}&top_rated=${params.topRated}',):

      await helper.get(url: '$coursesApi?page=${params.page}',);
      print(response.toString());
      return PublicCoursesResponse.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<CoursesDetailsResponse> getCoursesDetails({CoursesDetailsParams? params}) async{
    try {
      final response = await helper.get(url: '$coursesDetailsApi${params!.slug!}',);
      return CoursesDetailsResponse.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<PublicCoursesResponse> getPrivateLessons({CoursesParams? params}) async{
    try {
      final response = params!.type == "filter" ?
      await helper.get(url: '$privateLessonsApi?category_id=${params!.categoryId}&${params.courseName}&top_rated=${params.topRated}',) :
      await helper.get(url: privateLessonsApi,);
      return PublicCoursesResponse.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<WatchCourseResponse> watchCourse({WatchCourseParams? params}) async{
    try {
      final response = await helper.get(url: '$watchCourseApi?lecture_id=${params!.lectureId}&course_id=${params.courseId}',);
      return WatchCourseResponse.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }

}