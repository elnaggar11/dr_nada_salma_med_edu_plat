import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/teacher/teachers_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/teacher/subject_details_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/repositories/courses_repositories.dart';

part 'teachers_state.dart';

class TeachersCubit extends Cubit<TeachersState> {
  final CoursesRepositories _coursesRepository;
  Timer? _debounce;

  TeachersCubit(this._coursesRepository) : super(TeachersState());

  Future<void> fetchTeachers({required int subjectId}) async {
    emit(state.copyWith(status: TeachersRequestState.loading));

    final Map<String, dynamic> queryParameters = {
      "subject_id": subjectId.toString(),
      "min_price": state.minPrice.toInt().toString(),
      "max_price": state.maxPrice.toInt().toString(),
      "per_page": "15",
    };

    if (state.searchQuery.isNotEmpty) {
      queryParameters["search"] = state.searchQuery;
    }

    if (state.selectedSpecialtyId != null) {
      queryParameters["specialty_id"] = state.selectedSpecialtyId.toString();
    }

    final result = await _coursesRepository.getTeachers(query: queryParameters);

    result.fold(
      (failure) {
        String msg = "Unknown error occurred";
        if (failure is ServerFailure) msg = failure.message;
        if (failure is AuthFailure) msg = failure.message;
        emit(
          state.copyWith(
            status: TeachersRequestState.error,
            message: msg,
          ),
        );
      },
      (response) {
        emit(
          state.copyWith(
            status: TeachersRequestState.success,
            teachers: response.data ?? [],
          ),
        );
      },
    );
  }

  void updateSearchQuery(String query, {required int subjectId}) {
    emit(state.copyWith(searchQuery: query));

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      fetchTeachers(subjectId: subjectId);
    });
  }

  void updateFilters({
    int? specialtyId,
    double? minPrice,
    double? maxPrice,
    required int subjectId,
    bool clearSpecialty = false,
  }) {
    emit(state.copyWith(
      selectedSpecialtyId: specialtyId,
      minPrice: minPrice,
      maxPrice: maxPrice,
      clearSpecialty: clearSpecialty,
    ));

    fetchTeachers(subjectId: subjectId);
  }

  void clearAllFilters({required int subjectId}) {
    emit(state.copyWith(
      searchQuery: "",
      clearSpecialty: true,
      minPrice: 0.0,
      maxPrice: 500.0,
    ));

    fetchTeachers(subjectId: subjectId);
  }

  Future<void> fetchSubjectDetails({required int subjectId}) async {
    emit(state.copyWith(loadingSubjectDetails: true));

    final result = await _coursesRepository.getSubjectDetails(subjectId: subjectId);

    result.fold(
      (failure) {
        emit(state.copyWith(loadingSubjectDetails: false));
      },
      (response) {
        emit(
          state.copyWith(
            loadingSubjectDetails: false,
            subjectDetails: response,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
