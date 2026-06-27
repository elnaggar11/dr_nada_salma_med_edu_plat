import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_text_field.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/cubit/teachers/teachers_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/teacher_card.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/teacher/subject_details_response.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../profiles/presentation/cubit/profile/profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeachersListScreen extends StatefulWidget {
  final String categoryName;
  final int? subjectId;

  const TeachersListScreen({
    super.key,
    required this.categoryName,
    this.subjectId,
  });

  @override
  State<TeachersListScreen> createState() => _TeachersListScreenState();
}

class _TeachersListScreenState extends State<TeachersListScreen> {
  final TextEditingController _searchController = TextEditingController();

  bool get _isTargetUser {
    bool isTargetUser = false;
    try {
      final userId = sharedPreferences.getInt("user_id");
      final userEmail = sharedPreferences.getString("user_email");
      final userFullName = sharedPreferences.getString("user_fullName");
      if (userId == 311 ||
          userId == 7 ||
          userEmail == "abdoshams2005@gmail.com" ||
          userEmail == "tamer005@gmail.com" ||
          userFullName == "Abdo Shamss" ||
          userFullName == "ebrahim reda") {
        isTargetUser = true;
      }
    } catch (_) {}

    if (!isTargetUser) {
      try {
        final profileCubit = BlocProvider.of<ProfileCubit>(
          context,
          listen: false,
        );
        final profile = profileCubit.profileResponse;
        if (profile != null && profile.data != null) {
          if (profile.data!.id == 311 ||
              profile.data!.id == 7 ||
              profile.data!.email == "abdoshams2005@gmail.com" ||
              profile.data!.email == "tamer005@gmail.com" ||
              profile.data!.fullName == "Abdo Shamss" ||
              profile.data!.fullName == "ebrahim reda") {
            isTargetUser = true;
          }
        }
      } catch (_) {}
    }
    return isTargetUser;
  }

  int _getSubjectId(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'جراحة':
      case 'surgery':
        return 1;
      case 'باطنة':
      case 'internal medicine':
        return 2;
      case 'أطفال':
      case 'pediatrics':
        return 3;
      case 'قلب':
      case 'cardiology':
        return 4;
      case 'عيون':
      case 'ophthalmology':
        return 5;
      default:
        return 3;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int subjectId =
        widget.subjectId ?? _getSubjectId(widget.categoryName);

    return BlocProvider<TeachersCubit>(
      create: (context) => sl<TeachersCubit>()
        ..fetchTeachers(subjectId: subjectId)
        ..fetchSubjectDetails(subjectId: subjectId),
      child: Builder(
        builder: (context) {
          final teachersCubit = context.read<TeachersCubit>();

          return Scaffold(
            backgroundColor: white,
            appBar: customAppBar(
              appBarInd: 0,
              title: widget.categoryName,
              context: context,
              status: true,
              widget: InkWell(
                onTap: () =>
                    _showFilterBottomSheet(context, teachersCubit, subjectId),
                child: customSvg(
                  name: filter,
                  color: orangeBold,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr("choose_preferred_specialty"),
                    style: TextStyles.textStyleBold18.copyWith(color: primary),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _searchController,
                    obscure: false,
                    hintText: tr("search_course_here"),
                    onChange: (val) {
                      teachersCubit.updateSearchQuery(
                        val ?? "",
                        subjectId: subjectId,
                      );
                      return null;
                    },
                    suffixIcon: Container(
                      padding: const EdgeInsets.all(12),
                      child: customSvg(
                        name: search,
                        color: primary,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    labelTxt: tr("search"),
                    labelColor: primary,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: BlocBuilder<TeachersCubit, TeachersState>(
                      builder: (context, state) {
                        if (state.status == TeachersRequestState.loading) {
                          return const Center(
                            child: CircularProgressIndicator(color: orangeBold),
                          );
                        }

                        if (state.status == TeachersRequestState.error) {
                          return Center(
                            child: Text(
                              state.message ?? tr("an_error_occurred"),
                              style: TextStyles.textStyleBold14.copyWith(
                                color: red,
                              ),
                            ),
                          );
                        }

                        if (state.teachers.isEmpty) {
                          return Center(
                            child: Text(
                              tr("no_courses"),
                              style: TextStyles.textStyleBold16.copyWith(
                                color: grey1,
                              ),
                            ),
                          );
                        }

                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                childAspectRatio: 0.95,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                              ),
                          itemCount: state.teachers.length,
                          itemBuilder: (context, index) {
                            final teacher = state.teachers[index];
                            return TeacherCard(
                              name: teacher.name ?? "dr",
                              specialty:
                                  teacher.specialty ?? widget.categoryName,
                              image:
                                  teacher.image ?? "",
                              rating: teacher.rating ?? 0.0,
                              experience:
                                  "${teacher.experienceYears}+ ${tr("years_experience")}",
                              studentCount: teacher.studentsCount ?? 0,
                              price: (teacher.hourlyPrice ?? 0.0)
                                  .toStringAsFixed(0),
                              slug: teacher.slug ?? "",
                              teacherId: teacher.id ?? 0,
                              subjectId: subjectId,
                              onBookPressed: () {
                                context.pushNamed(
                                  name: teacherDetailSc,
                                  args: {
                                    "teacher_id": teacher.id ?? 0,
                                    "subject_id": subjectId,
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showFilterBottomSheet(
    BuildContext screenContext,
    TeachersCubit cubit,
    int subjectId,
  ) {
    final currentState = cubit.state;
    int? localSpecialtyId = currentState.selectedSpecialtyId;
    double localMinPrice = currentState.minPrice;
    double localMaxPrice = currentState.maxPrice;

    showModalBottomSheet(
      context: screenContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.75,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return BlocBuilder<TeachersCubit, TeachersState>(
              bloc: cubit,
              builder: (context, state) {
                return StatefulBuilder(
                  builder: (context, setLocalState) {
                    List<SubjectSpecialty> apiSpecialties =
                        state.subjectDetails?.data?.specialties ?? [];

                    List<SubjectSpecialty> defaultSpecialties = [
                      SubjectSpecialty(
                        id: 101,
                        name: tr("orthopedics"),
                        teachersCount: 0,
                      ),
                      SubjectSpecialty(
                        id: 102,
                        name: tr("internal_medicine"),
                        teachersCount: 0,
                      ),
                      SubjectSpecialty(
                        id: 103,
                        name: tr("pediatrics"),
                        teachersCount: 0,
                      ),
                      SubjectSpecialty(
                        id: 104,
                        name: tr("cardiology"),
                        teachersCount: 0,
                      ),
                      SubjectSpecialty(
                        id: 105,
                        name: tr("ophthalmology"),
                        teachersCount: 0,
                      ),
                    ];

                    List<SubjectSpecialty> specialties = List.from(
                      apiSpecialties,
                    );

                    // Add defaults if they don't already exist in the API response
                    for (var defSpec in defaultSpecialties) {
                      if (!specialties.any((s) => s.name == defSpec.name)) {
                        specialties.add(defSpec);
                      }
                    }

                    return Container(
                      decoration: const BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      child: ListView(
                        controller: scrollController,
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 16,
                          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
                        ),
                        children: [
                          // Drag handle
                          Center(
                            child: Container(
                              width: 40,
                              height: 4,
                              margin: const EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color: grey1.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),

                          // Header
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  cubit.clearAllFilters(subjectId: subjectId);
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete_outline,
                                      color: orangeBold,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      tr("clear_all"),
                                      style: TextStyles.textStyleBold14
                                          .copyWith(color: orangeBold),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                tr("filter_medical_screen"),
                                style: TextStyles.textStyleBold18.copyWith(
                                  color: orangeBold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          if (!_isTargetUser) ...[
                            // Price range
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(
                                        Icons.keyboard_arrow_up,
                                        color: primary,
                                        size: 20,
                                      ),
                                      Text(
                                        tr("cost"),
                                        style: TextStyles.textStyleBold16
                                            .copyWith(color: primary),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  RangeSlider(
                                    values: RangeValues(
                                      localMinPrice,
                                      localMaxPrice,
                                    ),
                                    min: 0.0,
                                    max: 500.0,
                                    divisions: 50,
                                    activeColor: orangeBold,
                                    inactiveColor: grey1.withOpacity(0.2),
                                    labels: RangeLabels(
                                      "${localMinPrice.toStringAsFixed(0)} ${tr("sar")}",
                                      "${localMaxPrice.toStringAsFixed(0)} ${tr("sar")}",
                                    ),
                                    onChanged: (RangeValues values) {
                                      setLocalState(() {
                                        localMinPrice = values.start;
                                        localMaxPrice = values.end;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _priceBox(
                                        "${localMaxPrice.toStringAsFixed(0)} ${tr("sar")}",
                                      ),
                                      _priceBox(
                                        "${localMinPrice.toStringAsFixed(0)} ${tr("sar")}",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],

                          // Specialties
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      Icons.keyboard_arrow_up,
                                      color: primary,
                                      size: 20,
                                    ),
                                    Text(
                                      tr("speciality"),
                                      style: TextStyles.textStyleBold16
                                          .copyWith(color: primary),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                if (state.loadingSubjectDetails)
                                  const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: CircularProgressIndicator(
                                        color: orangeBold,
                                      ),
                                    ),
                                  )
                                else
                                  ...specialties.map((spec) {
                                    final bool isSelected =
                                        localSpecialtyId == spec.id;
                                    return InkWell(
                                      onTap: () {
                                        setLocalState(() {
                                          localSpecialtyId = isSelected
                                              ? null
                                              : spec.id;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${spec.teachersCount ?? 0}",
                                              style: TextStyles.textStyleBold12
                                                  .copyWith(color: orangeBold),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  spec.name ?? "",
                                                  style: TextStyles
                                                      .textStyleBold14
                                                      .copyWith(
                                                        color: isSelected
                                                            ? orangeBold
                                                            : primary,
                                                      ),
                                                ),
                                                const SizedBox(width: 12),
                                                Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: isSelected
                                                          ? orangeBold
                                                          : primary.withOpacity(
                                                              0.5,
                                                            ),
                                                      width: 2,
                                                    ),
                                                    color: isSelected
                                                        ? orangeBold
                                                        : Colors.transparent,
                                                  ),
                                                  child: isSelected
                                                      ? const Icon(
                                                          Icons.check,
                                                          size: 12,
                                                          color: white,
                                                        )
                                                      : null,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Apply button
                          ElevatedButton(
                            onPressed: () {
                              cubit.updateFilters(
                                specialtyId: localSpecialtyId,
                                minPrice: localMinPrice,
                                maxPrice: localMaxPrice,
                                subjectId: subjectId,
                                clearSpecialty: localSpecialtyId == null,
                              );
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary.withOpacity(0.1),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  tr("apply"),
                                  style: TextStyles.textStyleBold16.copyWith(
                                    color: primary,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primary,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12,
                                    color: white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _priceBox(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: black.withOpacity(0.08)),
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFF9F9F9),
      ),
      child: Text(
        label,
        style: TextStyles.textStyleBold14.copyWith(color: primary),
      ),
    );
  }
}
