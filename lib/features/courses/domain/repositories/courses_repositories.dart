import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/categories_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/courses_status_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/courses_status_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/teacher/teachers_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/teacher/subject_details_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/teacher/teacher_detail_response.dart';

abstract class CoursesRepositories {
  Future<Either<Failure, CategoriesResponse>> getCategories();
  Future<Either<Failure, CoursesStatusResponse>> getCoursesStatus({
    CoursesStatusParams? params,
  });
  Future<Either<Failure, Map<String, dynamic>>> getTeacherDetail({
    required int teacherId,
    required int subjectId,
  });
  Future<Either<Failure, TeachersResponse>> getTeachers({
    required Map<String, dynamic> query,
  });
  Future<Either<Failure, SubjectDetailsResponse>> getSubjectDetails({
    required int subjectId,
  });
  Future<Either<Failure, List<TeacherReview>>> getTeacherReviews({
    required int teacherId,
  });
  Future<Either<Failure, List<TeacherTimeSlot>>> getTeacherTimeSlots({
    required int teacherId,
  });
  Future<Either<Failure, Map<String, dynamic>>> bookTeacher({
    required Map<String, dynamic> body,
  });
}
