import 'package:dr_nada_salma_med_edu_plat/core/errors/exceptions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/api_base_helper.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/categories_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/courses_status_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/courses_status_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/teacher/teachers_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/teacher/subject_details_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/teacher/teacher_detail_response.dart';

const categoriesApi = "/courses/categories_public";
const coursesTypesApi = "/profile/";
const teacherDetailApi = "/courses/teacher-details/";
const tutoringTeachersApi = "/tutoring/teachers";
const tutoringSubjectsApi = "/tutoring/subjects/";

abstract class CoursesRemoteDataSource {
  Future<CategoriesResponse> getCategories();
  Future<CoursesStatusResponse> getCoursesStatus({CoursesStatusParams? params});
  Future<Map<String, dynamic>> getTeacherDetail({
    required int teacherId,
    required int subjectId,
  });
  Future<TeachersResponse> getTeachers({required Map<String, dynamic> query});
  Future<SubjectDetailsResponse> getSubjectDetails({required int subjectId});
  Future<List<TeacherReview>> getTeacherReviews({required int teacherId});
  Future<List<TeacherTimeSlot>> getTeacherTimeSlots({required int teacherId});
  Future<Map<String, dynamic>> bookTeacher({required Map<String, dynamic> body});
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
      final coursesType = params!.coursesType ?? "";
      final courseStatus = params.courseStatus ?? "";
      final url = coursesType.startsWith("/")
          ? "$coursesType$courseStatus"
          : "$coursesTypesApi$coursesType$courseStatus";
      final response = await helper.get(url: url);
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
  Future<Map<String, dynamic>> getTeacherDetail({
    required int teacherId,
    required int subjectId,
  }) async {
    try {
      final response = await helper.get(
        url: "/tutoring/teachers/$teacherId?subject_id=$subjectId",
      );
      return response;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<TeachersResponse> getTeachers({
    required Map<String, dynamic> query,
  }) async {
    try {
      final response = await helper.get(url: tutoringTeachersApi, query: query);
      return TeachersResponse.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<SubjectDetailsResponse> getSubjectDetails({
    required int subjectId,
  }) async {
    try {
      final response = await helper.get(url: "$tutoringSubjectsApi$subjectId");
      return SubjectDetailsResponse.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<List<TeacherTimeSlot>> getTeacherTimeSlots({
    required int teacherId,
  }) async {
    try {
      final response = await helper.get(
        url: "/tutoring/teachers/$teacherId/time-slots?limit=40",
      );

      if (response['data'] is List) {
        return (response['data'] as List)
            .map((i) => TeacherTimeSlot.fromJson(i))
            .toList();
      }

      if (response['data'] is Map && response['data']['data'] is List) {
        return (response['data']['data'] as List)
            .map((i) => TeacherTimeSlot.fromJson(i))
            .toList();
      }

      return [];
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<List<TeacherReview>> getTeacherReviews({
    required int teacherId,
  }) async {
    try {
      final response = await helper.get(
        url: "/tutoring/teachers/$teacherId/reviews?per_page=10",
      );

      if (response['data'] is List) {
        return (response['data'] as List)
            .map((i) => TeacherReview.fromJson(i))
            .toList();
      }

      if (response['data'] is Map && response['data']['data'] is List) {
        return (response['data']['data'] as List)
            .map((i) => TeacherReview.fromJson(i))
            .toList();
      }

      return [];
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> bookTeacher({
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await helper.postJson(
        url: "/tutoring/bookings",
        body: body,
      );
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
