import 'package:dr_nada_salma_med_edu_plat/core/errors/exceptions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/api_base_helper.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/categories_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/courses_status_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/courses_status_params.dart';

const categoriesApi = "/courses/categories_public";
const coursesTypesApi = "/profile/";
const teacherDetailApi = "/courses/teacher-details/";

abstract class CoursesRemoteDataSource {
  Future<CategoriesResponse> getCategories();
  Future<CoursesStatusResponse> getCoursesStatus({CoursesStatusParams? params});
  Future<Map<String, dynamic>> getTeacherDetail({required String slug});
}

class CoursesRemoteDataSourceImpl implements CoursesRemoteDataSource {
  final ApiBaseHelper helper;

  CoursesRemoteDataSourceImpl(this.helper);

  @override
  Future<CategoriesResponse> getCategories() async {
    try {
      final response = await helper.get(url: categoriesApi);
      return CategoriesResponse.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<CoursesStatusResponse> getCoursesStatus({
    CoursesStatusParams? params,
  }) async {
    try {
      final response = await helper.get(
        url: coursesTypesApi + params!.coursesType! + params.courseStatus!,
      );
      print("response :$response");
      return CoursesStatusResponse.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> getTeacherDetail({required String slug}) async {
    try {
      final response = await helper.get(url: "$teacherDetailApi$slug");
      return response;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }
}
