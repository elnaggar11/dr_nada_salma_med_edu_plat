import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/specialists/specialist_response.dart'
    as spec;
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/teacher_registration/subject_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/teacher_registration/teacher_application_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/teacher_registration/teacher_application_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/usecases/get_specialties_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/usecases/get_subjects_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/usecases/submit_teacher_application_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'teacher_registration_state.dart';

class TeacherRegistrationCubit extends Cubit<TeacherRegistrationState> {
  final GetSpecialtiesUseCase getSpecialtiesUseCase;
  final GetSubjectsUseCase getSubjectsUseCase;
  final SubmitTeacherApplicationUseCase submitTeacherApplicationUseCase;

  TeacherRegistrationCubit({
    required this.getSpecialtiesUseCase,
    required this.getSubjectsUseCase,
    required this.submitTeacherApplicationUseCase,
  }) : super(TeacherRegistrationInitial());

  // Text Editing Controllers (following rules)
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();
  final whatsappController = TextEditingController();
  final alternativeController = TextEditingController();

  // Selected state variables
  List<spec.Data> specialties = [];
  List<SubjectData> subjects = [];
  List<String> selectedDays = [];
  List<int> selectedSubjectIds = [];
  int? selectedSpecialtyId;
  String fromTime = "";
  String toTime = "";
  bool isCheckedTerms = false;

  bool loadingData = false;
  bool submitting = false;

  Color? buttonColor = orangeBold;

  Future<void> loadInitialData() async {
    loadingData = true;
    emit(TeacherRegistrationLoadingDataState());

    try {
      final specResult = await getSpecialtiesUseCase(NoParams());
      final subResult = await getSubjectsUseCase(NoParams());

      specResult.fold(
        (fail) {
          loadingData = false;
          if (fail is ServerFailure) {
            emit(TeacherRegistrationDataErrorState(msg: fail.message));
          } else {
            emit(
              TeacherRegistrationDataErrorState(
                msg: "Error fetching specialties",
              ),
            );
          }
        },
        (specResponse) {
          specialties = specResponse.data ?? [];
          subResult.fold(
            (fail) {
              loadingData = false;
              if (fail is ServerFailure) {
                emit(TeacherRegistrationDataErrorState(msg: fail.message));
              } else {
                emit(
                  TeacherRegistrationDataErrorState(
                    msg: "Error fetching subjects",
                  ),
                );
              }
            },
            (subResponse) {
              subjects = subResponse.data ?? [];
              loadingData = false;
              emit(TeacherRegistrationDataLoadedState());
            },
          );
        },
      );
    } catch (e) {
      loadingData = false;
      emit(TeacherRegistrationDataErrorState(msg: e.toString()));
    }
  }

  void toggleSubject(int id) {
    if (selectedSubjectIds.contains(id)) {
      selectedSubjectIds.clear();
    } else {
      selectedSubjectIds.clear();
      selectedSubjectIds.add(id);
    }
    for (var sub in subjects) {
      sub.isChecked = selectedSubjectIds.contains(sub.id);
    }
    emit(TeacherRegistrationUpdateUIState());
  }

  void toggleDay(String day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
    emit(TeacherRegistrationUpdateUIState());
  }

  void selectSpecialty(int id) {
    selectedSpecialtyId = id;
    emit(TeacherRegistrationUpdateUIState());
  }

  void selectFromTime(String time) {
    fromTime = time;
    emit(TeacherRegistrationUpdateUIState());
  }

  void selectToTime(String time) {
    toTime = time;
    emit(TeacherRegistrationUpdateUIState());
  }

  void toggleTermsCheck(bool? value) {
    isCheckedTerms = value ?? false;
    emit(TeacherRegistrationUpdateUIState());
  }

  Future<void> submitApplication() async {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        selectedSpecialtyId == null ||
        bioController.text.trim().isEmpty ||
        selectedSubjectIds.isEmpty ||
        whatsappController.text.trim().isEmpty ||
        selectedDays.isEmpty ||
        fromTime.isEmpty ||
        toTime.isEmpty) {
      msgKey.currentState!.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            "يرجى ملء جميع الحقول المطلوبة واختيار الأيام والأوقات والمواد",
            style: TextStyles.textStyleNormal12.copyWith(color: white),
          ),
        ),
      );
      return;
    }

    if (!isCheckedTerms) {
      msgKey.currentState!.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            "يجب الموافقة على الشروط والأحكام وسياسة الخصوصية للمتابعة",
            style: TextStyles.textStyleNormal12.copyWith(color: white),
          ),
        ),
      );
      return;
    }

    submitting = true;
    buttonColor = orangeBold;
    emit(TeacherRegistrationSubmitLoadingState());

    try {
      final params = TeacherApplicationParams(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        specialtyId: selectedSpecialtyId!,
        bio: bioController.text.trim(),
        subjectIds: selectedSubjectIds,
        whatsapp: whatsappController.text.trim(),
        alternativeContact: alternativeController.text.trim(),
        availableDays: selectedDays,
        fromTime: fromTime,
        toTime: toTime,
      );

      final result = await submitTeacherApplicationUseCase(params);
      result.fold(
        (fail) {
          submitting = false;
          buttonColor = orangeBold;
          if (fail is ServerFailure) {
            msgKey.currentState!.showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(
                  fail.message,
                  style: TextStyles.textStyleNormal12.copyWith(color: white),
                ),
              ),
            );
            emit(TeacherRegistrationSubmitErrorState(msg: fail.message));
          } else {
            msgKey.currentState!.showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(
                  "حدث خطأ أثناء تقديم الطلب",
                  style: TextStyles.textStyleNormal12.copyWith(color: white),
                ),
              ),
            );
            emit(TeacherRegistrationSubmitErrorState(msg: "Submission Error"));
          }
        },
        (response) {
          submitting = false;
          buttonColor = orangeBold;
          msgKey.currentState!.showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(
                response.message ?? "تم تقديم طلب الانضمام بنجاح",
                style: TextStyles.textStyleNormal12.copyWith(color: white),
              ),
            ),
          );
          // Go back to login screen on success
          navKey.currentContext!.pop();
          emit(TeacherRegistrationSubmitSuccessState(response: response));
        },
      );
    } catch (e) {
      submitting = false;
      buttonColor = orangeBold;
      msgKey.currentState!.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            e.toString(),
            style: TextStyles.textStyleNormal12.copyWith(color: white),
          ),
        ),
      );
      emit(TeacherRegistrationSubmitErrorState(msg: e.toString()));
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    bioController.dispose();
    whatsappController.dispose();
    alternativeController.dispose();
    return super.close();
  }
}
