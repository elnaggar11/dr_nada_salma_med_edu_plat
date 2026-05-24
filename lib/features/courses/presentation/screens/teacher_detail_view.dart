import 'dart:ui' as ui;

import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/teacher/teacher_detail_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/cubit/teacher_detail/teacher_detail_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/teacher/teacher_booking_footer.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/teacher/teacher_info_sections.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/teacher/teacher_profile_header.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/teacher/teacher_ratings_list.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/teacher/teacher_video_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:url_launcher/url_launcher.dart';

class TeacherDetailView extends StatefulWidget {
  final int teacherId;
  final int subjectId;

  const TeacherDetailView({
    super.key,
    required this.teacherId,
    required this.subjectId,
  });

  @override
  State<TeacherDetailView> createState() => _TeacherDetailViewState();
}

class _TeacherDetailViewState extends State<TeacherDetailView> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _hoursController = TextEditingController(
    text: '1',
  );

  DateTime? selectedDate;
  int hoursCount = 1;
  String? countryCode = '+966';
  String? countrySymbol = 'SA';
  String? _phoneNumber = '';

  @override
  void initState() {
    super.initState();
    context.read<TeacherDetailCubit>().getTeacherDetail(
      widget.teacherId,
      widget.subjectId,
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _notesController.dispose();
    _hoursController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
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
                  padding: const EdgeInsets.only(bottom: 380),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TeacherVideoPlayer(
                        videoUrl: teacher.videoUrl ?? "",
                        thumbnail: teacher.image,
                      ),
                      TeacherProfileHeader(teacher: teacher),
                      if (teacher.bio != null)
                        TeacherAboutSection(bio: teacher.bio!),
                      if (teacher.targetAudience != null)
                        TargetAudienceSection(
                          audience: teacher.targetAudience!,
                        ),
                      if (teacher.teachingExperiences != null &&
                          teacher.teachingExperiences!.isNotEmpty)
                        TeachingExperienceSection(
                          experiences: teacher.teachingExperiences!,
                        ),
                      if (teacher.availability != null &&
                          teacher.availability!.isNotEmpty)
                        AvailabilitySection(
                          availability: teacher.availability!,
                        ),
                      if (teacher.reviews != null &&
                          teacher.reviews!.isNotEmpty)
                        TeacherRatingsList(
                          overallRating: teacher.rating ?? 0.0,
                          reviews: teacher.reviews!,
                        ),
                      TeacherBookingFooter(
                        price: teacher.hourlyPrice ?? 0.0,
                        bookingPolicyHint: teacher.bookingPolicyHint,
                        onBookNow: () => _showBookingSheet(context, teacher),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 20,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Directionality(
                        textDirection: ui.TextDirection.ltr,
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
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

  void _showBookingSheet(BuildContext context, TeacherDetail teacher) {
    selectedDate = null;
    hoursCount = 1;
    _hoursController.text = '1';
    _phoneController.clear();
    _notesController.clear();
    _phoneNumber = '';
    countryCode = '+966';
    countrySymbol = 'SA';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final totalPrice = (teacher.hourlyPrice ?? 0) * hoursCount;

            return Directionality(
              textDirection: ui.TextDirection.rtl,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: context.width / 25),
                  constraints: BoxConstraints(maxHeight: context.height * 0.9),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: context.width / 16,
                            vertical: context.height / 28,
                          ),
                          color: primary,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  tr("book_session"),
                                  style: TextStyles.textStyleBold16.copyWith(
                                    color: white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Text(
                                  "|",
                                  style: TextStyles.textStyleBold28.copyWith(
                                    color: orangeBold,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  teacher.name ?? "",
                                  style: TextStyles.textStyleBold16.copyWith(
                                    color: white.withOpacity(0.85),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.width / 13,
                            vertical: context.height / 28,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _bookingLabel(
                                context,
                                tr("choose_days"),
                                Icons.calendar_month_outlined,
                              ),
                              const SizedBox(height: 10),
                              _bookingInput(
                                context: context,
                                hintText: tr("choose_days"),
                                text: selectedDate == null
                                    ? null
                                    : DateFormat(
                                        'yyyy/MM/dd',
                                      ).format(selectedDate!),
                                icon: Icons.calendar_month_outlined,
                                onTap: () async {
                                  final pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: selectedDate ?? DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now().add(
                                      const Duration(days: 365),
                                    ),
                                    locale: context.locale,
                                  );

                                  if (pickedDate != null) {
                                    setModalState(() {
                                      selectedDate = pickedDate;
                                    });
                                  }
                                },
                              ),
                              SizedBox(height: context.height / 34),
                              _bookingLabel(
                                context,
                                tr("hours_count"),
                                Icons.access_time,
                              ),
                              const SizedBox(height: 10),
                              _bookingTextField(
                                context: context,
                                controller: _hoursController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  final parsedHours = int.tryParse(value);
                                  setModalState(() {
                                    hoursCount =
                                        parsedHours != null && parsedHours > 0
                                        ? parsedHours
                                        : 1;
                                  });
                                },
                              ),
                              SizedBox(height: context.height / 34),
                              _bookingLabel(
                                context,
                                tr("phone_number"),
                                Icons.phone_outlined,
                              ),
                              const SizedBox(height: 10),
                              _phoneField(context),
                              SizedBox(height: context.height / 34),
                              _bookingLabel(
                                context,
                                tr("additional_notes"),
                                Icons.note_alt_outlined,
                              ),
                              const SizedBox(height: 10),
                              _bookingTextField(
                                context: context,
                                controller: _notesController,
                                maxLines: 4,
                                minHeight: context.height / 7,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(height: context.height / 36),
                              _totalPriceCard(
                                context,
                                hourlyPrice: teacher.hourlyPrice ?? 0,
                                totalPrice: totalPrice,
                              ),
                              SizedBox(height: context.height / 32),
                              GestureDetector(
                                onTap: () => _confirmBooking(context, teacher),
                                child: Container(
                                  width: double.infinity,
                                  height: context.height / 13,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: orangeBold,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: orangeBold.withOpacity(0.25),
                                        blurRadius: 12,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    tr("confirm_booking"),
                                    style: TextStyles.textStyleBold20.copyWith(
                                      color: white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _bookingLabel(BuildContext context, String title, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(title, style: TextStyles.textStyleBold16.copyWith(color: primary)),
        const SizedBox(width: 10),
        Icon(icon, color: orangeBold, size: 24),
      ],
    );
  }

  Widget _bookingInput({
    required BuildContext context,
    required String hintText,
    required IconData icon,
    String? text,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: context.height / 13.5,
        padding: EdgeInsets.symmetric(horizontal: context.width / 18),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: black.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: orangeBold, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text ?? hintText,
                style: TextStyles.textStyleBold18.copyWith(
                  color: text == null ? grey1 : black,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bookingTextField({
    required BuildContext context,
    required TextEditingController controller,
    TextInputType? keyboardType,
    TextAlign textAlign = TextAlign.start,
    ValueChanged<String>? onChanged,
    int maxLines = 1,
    double? minHeight,
  }) {
    return Container(
      constraints: BoxConstraints(
        minHeight: minHeight ?? context.height / 13.5,
      ),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: black.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        textAlign: textAlign,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyles.textStyleBold18.copyWith(color: black),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: context.width / 18,
            vertical: context.height / 45,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _phoneField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: black.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntlPhoneField(
        controller: _phoneController,
        initialCountryCode: 'SA',
        style: TextStyles.textStyleBold18.copyWith(color: black),
        dropdownTextStyle: TextStyles.textStyleBold18.copyWith(color: black),
        dropdownDecoration: const BoxDecoration(color: white),
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: context.width / 18,
            vertical: context.height / 44,
          ),
        ),
        onChanged: (phone) {
          _phoneNumber = phone.number;
          countryCode = phone.countryCode;
          countrySymbol = phone.countryISOCode;
        },
      ),
    );
  }

  Widget _totalPriceCard(
    BuildContext context, {
    required double hourlyPrice,
    required double totalPrice,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.width / 16,
        vertical: context.height / 45,
      ),
      decoration: BoxDecoration(
        color: greyLight,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  tr("total_price"),
                  style: TextStyles.textStyleBold14.copyWith(color: grey1),
                ),
                const SizedBox(height: 6),
                Text(
                  "${hourlyPrice.toStringAsFixed(1)}\$ × $hoursCount ${tr("hours_count")}",
                  style: TextStyles.textStyleBold12.copyWith(color: grey1),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Directionality(
              textDirection: ui.TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      "${totalPrice.toStringAsFixed(1)}",
                      style: TextStyles.textStyleBold20.copyWith(
                        color: primary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      "ر.س",
                      style: TextStyles.textStyleBold16.copyWith(
                        color: orangeBold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmBooking(BuildContext context, TeacherDetail teacher) {
    if (selectedDate == null) {
      _showBookingValidation(context, tr("booking_validation_day"));
      return;
    }

    if (_phoneController.text.trim().isEmpty ||
        (_phoneNumber ?? "").trim().isEmpty) {
      _showBookingValidation(context, tr("booking_validation_phone"));
      return;
    }

    final parsedHours = int.tryParse(_hoursController.text);
    if (parsedHours == null || parsedHours < 1) {
      hoursCount = 1;
      _hoursController.text = '1';
    } else {
      hoursCount = parsedHours;
    }

    Navigator.pop(context);
    _openWhatsAppBooking(
      teacher,
      bookingDate: selectedDate!,
      hours: hoursCount,
      studentPhone: "$countryCode${_phoneNumber ?? ""}",
      notes: _notesController.text.trim(),
    );
  }

  void _showBookingValidation(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyles.textStyleBold14.copyWith(color: white),
        ),
        backgroundColor: primary,
      ),
    );
  }

  void _openWhatsAppBooking(
    TeacherDetail teacher, {
    required DateTime bookingDate,
    required int hours,
    required String studentPhone,
    String? notes,
  }) async {
    const phoneNumber = '2001022370181';
    final totalPrice = (teacher.hourlyPrice ?? 0) * hours;
    final subjectsText =
        teacher.subjects != null && teacher.subjects!.isNotEmpty
        ? teacher.subjects!.map((subject) => subject.name ?? '').join('، ')
        : '';

    final message = StringBuffer();
    message.writeln('السلام عليكم');
    message.writeln('أرغب في حجز جلسة مع المدرس:');
    message.writeln('');
    message.writeln('الاسم: ${teacher.name ?? ''}');
    if (teacher.specializationTitle != null &&
        teacher.specializationTitle!.isNotEmpty) {
      message.writeln('التخصص: ${teacher.specializationTitle}');
    }
    if (subjectsText.isNotEmpty) {
      message.writeln('المواد: $subjectsText');
    }
    message.writeln(
      'تاريخ الحجز: ${DateFormat('yyyy/MM/dd').format(bookingDate)}',
    );
    message.writeln('عدد الساعات: $hours');
    message.writeln('رقم الهاتف: $studentPhone');
    if (notes != null && notes.isNotEmpty) {
      message.writeln('ملاحظات: $notes');
    }
    message.writeln('سعر الساعة: \$${teacher.hourlyPrice ?? 0}');
    message.writeln('إجمالي السعر: \$${totalPrice.toStringAsFixed(1)}');
    if (teacher.experienceYears != null) {
      message.writeln('سنوات الخبرة: ${teacher.experienceYears}');
    }
    message.writeln('');
    message.writeln('أرجو تأكيد الحجز. شكرا لكم!');

    final url = Uri.parse(
      'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message.toString())}',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}
