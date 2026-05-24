import 'package:dr_nada_salma_med_edu_plat/core/utils/extensions.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/cubit/teacher_detail/teacher_detail_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/teacher/teacher_booking_footer.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/teacher/teacher_info_sections.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/teacher/teacher_profile_header.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/teacher/teacher_ratings_list.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/teacher/teacher_stat_cards.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/teacher/teacher_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart'; // For sl

class TeacherDetailView extends StatefulWidget {
  final String slug;

  const TeacherDetailView({super.key, required this.slug});

  @override
  State<TeacherDetailView> createState() => _TeacherDetailViewState();
}

class _TeacherDetailViewState extends State<TeacherDetailView> {
  @override
  void initState() {
    super.initState();
    context.read<TeacherDetailCubit>().getTeacherDetail(widget.slug);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<TeacherDetailCubit, TeacherDetailState>(
        builder: (context, state) {
          if (state.status == TeacherDetailRequestState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == TeacherDetailRequestState.error) {
            return Center(child: Text(state.message ?? "Error"));
          }

          if (state.status == TeacherDetailRequestState.success &&
              state.teacherDetail != null) {
            final teacher = state.teacherDetail!;
            return Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: 250,
                  ), // Space for sticky footer
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Video Player at Top
                      TeacherVideoPlayer(
                        videoUrl: teacher.videoUrl ?? "",
                        thumbnail: teacher.image,
                      ),
                      // Header Info
                      TeacherProfileHeader(teacher: teacher),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(color: Color(0xFFF0F0F0)),
                      ),
                      // Stats Row
                      TeacherStatCards(
                        // langu ages: teacher.languages ?? [],
                        studentsCount: teacher.studentsCount ?? 0,
                        experienceYears: teacher.experienceYears ?? 0,
                        coursesCount:  0,
                      ),
                      // About Section
                      if (teacher.bio != null)
                        TeacherAboutSection(bio: teacher.bio!),
                      // Target Audience
                      if (teacher.targetAudience != null)
                        TargetAudienceSection(
                          audience: teacher.targetAudience!,
                        ),
                      // Teaching Experiences
                      if (teacher.teachingExperiences != null &&
                          teacher.teachingExperiences!.isNotEmpty)
                        TeachingExperienceSection(
                          experiences: teacher.teachingExperiences!,
                        ),
                      // Availability
                      if (teacher.availability != null &&
                          teacher.availability!.isNotEmpty)
                        AvailabilitySection(
                          availability: teacher.availability!,
                        ),
                      // Ratings
                      if (teacher.reviews != null &&
                          teacher.reviews!.isNotEmpty)
                        TeacherRatingsList(
                          overallRating: teacher.rating ?? 0.0,
                          reviews: teacher.reviews!,
                        ),
                    ],
                  ),
                ),
                // Custom App Bar (Back button)
                Positioned(
                  top: 50,
                  right: 20,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                // Sticky Booking Footer
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TeacherBookingFooter(
                    price: teacher.hourlyPrice ?? 0.0,
                    onBookNow: () {
                      // Handle booking logic
                    },
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
