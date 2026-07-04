import 'dart:ui' as ui;

import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/const.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/target_user.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/teacher/teacher_detail_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/cubit/teacher_detail/teacher_detail_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/in_person_training_info_card.dart';
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
  TeacherTimeSlot? selectedTimeSlot;
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
      body: SafeArea(
        child: BlocBuilder<TeacherDetailCubit, TeacherDetailState>(
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
                        if (isTargetUser(context)) ...[
                          const SizedBox(height: 16),
                          const InPersonTrainingInfoCard(),
                        ],
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
                        if (state.timeSlots.isNotEmpty)
                          TeacherTimeSlotsSection(
                            timeSlots: state.timeSlots,
                            selectedSlot: selectedTimeSlot,
                            onSlotSelected: (slot) {
                              setState(() {
                                selectedTimeSlot = slot;
                                selectedDate = slot.date;
                              });
                            },
                          )
                        else if (teacher.availability != null &&
                            teacher.availability!.isNotEmpty)
                          AvailabilitySection(
                            availability: teacher.availability!,
                          ),
                        if (state.reviews.isNotEmpty)
                          TeacherRatingsList(
                            overallRating: teacher.rating ?? 0.0,
                            reviews: state.reviews,
                          ),
                        if (!Const.isTeacher)
                          TeacherBookingFooter(
                            price: teacher.hourlyPrice ?? 0.0,
                            priceAfterDiscount: teacher.hourlyRateAfterDiscount,
                            bookingPolicyHint: teacher.bookingPolicyHint,
                            onBookNow: () => _showBookingSheet(
                              context,
                              teacher,
                              state.timeSlots,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 25,
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
      ),
    );
  }

  void _showBookingSheet(
    BuildContext context,
    TeacherDetail teacher,
    List<TeacherTimeSlot> timeSlots,
  ) {
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
            final basePrice =
                teacher.hourlyRateAfterDiscount ?? teacher.hourlyPrice ?? 0;
            final totalPrice = basePrice * hoursCount;

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
                                tr("available_times"),
                                Icons.calendar_month_outlined,
                              ),
                              const SizedBox(height: 10),
                              _bookingInput(
                                context: context,
                                hintText: tr("available_times"),
                                text: selectedTimeSlot == null
                                    ? (selectedDate == null
                                          ? null
                                          : DateFormat(
                                              'yyyy/MM/dd',
                                            ).format(selectedDate!))
                                    : _formatTimeSlot(selectedTimeSlot!),
                                icon: Icons.calendar_month_outlined,
                                onTap: () async {
                                  if (timeSlots.isNotEmpty) {
                                    final pickedSlot =
                                        await _showTimeSlotsPicker(
                                          context,
                                          timeSlots,
                                        );

                                    if (pickedSlot != null) {
                                      setModalState(() {
                                        selectedTimeSlot = pickedSlot;
                                        selectedDate = pickedSlot.date;
                                      });
                                    }
                                    return;
                                  }

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
                              if (!isTargetUser(context)) ...[
                                SizedBox(height: context.height / 36),
                                _totalPriceCard(
                                  context,
                                  hourlyPrice:
                                      teacher.hourlyRateAfterDiscount ??
                                      teacher.hourlyPrice ??
                                      0,
                                  totalPrice: totalPrice,
                                  originalHourlyPrice:
                                      teacher.hourlyRateAfterDiscount != null
                                      ? teacher.hourlyPrice
                                      : null,
                                  originalTotalPrice:
                                      teacher.hourlyRateAfterDiscount != null
                                      ? (teacher.hourlyPrice ?? 0) * hoursCount
                                      : null,
                                ),
                                SizedBox(height: context.height / 32),
                              ] else ...[
                                SizedBox(height: context.height / 36),
                              ],
                              GestureDetector(
                                onTap: () => _confirmBooking(
                                  context,
                                  teacher,
                                  timeSlots.isNotEmpty,
                                ),
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

  Future<TeacherTimeSlot?> _showTimeSlotsPicker(
    BuildContext context,
    List<TeacherTimeSlot> timeSlots,
  ) {
    return showModalBottomSheet<TeacherTimeSlot>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Directionality(
          textDirection: ui.TextDirection.rtl,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: context.width / 25),
            constraints: BoxConstraints(maxHeight: context.height * 0.65),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(24),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width / 16,
                    vertical: context.height / 45,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        tr("available_times"),
                        style: TextStyles.textStyleBold18.copyWith(
                          color: primary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(Icons.access_time, color: orangeBold, size: 24),
                    ],
                  ),
                ),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.fromLTRB(
                      context.width / 16,
                      0,
                      context.width / 16,
                      context.height / 35,
                    ),
                    itemCount: timeSlots.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final slot = timeSlots[index];
                      final isSelected = selectedTimeSlot?.id == slot.id;

                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => Navigator.pop(context, slot),
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? orangeBold.withOpacity(0.08)
                                  : greyLight,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected
                                    ? orangeBold
                                    : black.withOpacity(0.05),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isSelected
                                      ? Icons.check_circle
                                      : Icons.radio_button_unchecked,
                                  color: isSelected ? orangeBold : grey1,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    _formatTimeSlot(slot),
                                    style: TextStyles.textStyleBold16.copyWith(
                                      color: primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatTimeSlot(TeacherTimeSlot slot) {
    final dateText = slot.date == null
        ? ""
        : DateFormat('yyyy/MM/dd').format(slot.date!);
    final startTime = slot.startTime ?? "";
    final endTime = slot.endTime ?? "";
    final timeText = "$startTime - $endTime";

    if (dateText.isEmpty) return timeText;
    if (startTime.isEmpty && endTime.isEmpty) return dateText;
    return "$dateText | $timeText";
  }

  Widget _totalPriceCard(
    BuildContext context, {
    required double hourlyPrice,
    required double totalPrice,
    double? originalHourlyPrice,
    double? originalTotalPrice,
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
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${hourlyPrice.toStringAsFixed(1)}\$ × $hoursCount ${tr("hours_count")}",
                        style: TextStyles.textStyleBold12.copyWith(
                          color: grey1,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (originalHourlyPrice != null &&
                          originalHourlyPrice > hourlyPrice) ...[
                        const SizedBox(width: 6),
                        Text(
                          "${originalHourlyPrice.toStringAsFixed(1)}\$",
                          style: TextStyles.textStyleBold12.copyWith(
                            color: grey1.withOpacity(0.5),
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
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
                  if (originalTotalPrice != null &&
                      originalTotalPrice > totalPrice) ...[
                    const SizedBox(width: 6),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text(
                          "${originalTotalPrice.toStringAsFixed(1)}",
                          style: TextStyles.textStyleBold14.copyWith(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
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

  void _confirmBooking(
    BuildContext context,
    TeacherDetail teacher,
    bool hasTimeSlots,
  ) async {
    if (selectedDate == null) {
      _showBookingValidation(context, tr("booking_validation_day"));
      return;
    }

    if (hasTimeSlots && selectedTimeSlot == null) {
      _showBookingValidation(context, tr("booking_validation_time"));
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

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) =>
          const Center(child: CircularProgressIndicator(color: orangeBold)),
    );

    // Call the Cubit booking API
    final cubit = this.context.read<TeacherDetailCubit>();
    final isSuccess = await cubit.bookTeacher(
      teacherId: widget.teacherId,
      subjectId: widget.subjectId,
      timeSlotId: selectedTimeSlot?.id,
      totalHours: hoursCount,
      notes: _notesController.text.trim(),
    );

    // Dismiss loading indicator dialog
    if (context.mounted) {
      Navigator.of(context).pop();
    }

    if (isSuccess) {
      // Dismiss booking bottom sheet
      if (context.mounted) {
        Navigator.of(context).pop();
      }
      _openWhatsAppBooking(teacher);
    } else {
      // Show error message
      if (context.mounted) {
        _showBookingValidation(
          context,
          cubit.state.bookingMessage ?? "Failed to book session",
        );
      }
    }
  }

  void _showBookingValidation(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: ui.TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          backgroundColor: white,
          title: Row(
            children: [
              const Icon(Icons.info_outline, color: orangeBold, size: 28),
              const SizedBox(width: 10),
              Text(
                "تنبيه",
                style: TextStyles.textStyleBold18.copyWith(color: primary),
              ),
            ],
          ),
          content: Text(
            message,
            style: TextStyles.textStyleBold14.copyWith(color: black),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                "موافق",
                style: TextStyles.textStyleBold16.copyWith(color: orangeBold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openWhatsAppBooking(TeacherDetail teacher) async {
    const phoneNumber = '+966556000986';
    final bookingDate = selectedDate!;
    final hours = hoursCount;
    final studentPhone = "$countryCode${_phoneNumber ?? ""}";
    final notes = _notesController.text.trim();
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
    if (selectedTimeSlot != null) {
      message.writeln(
        'وقت الحجز: ${selectedTimeSlot!.startTime ?? ''} - ${selectedTimeSlot!.endTime ?? ''}',
      );
    }
    message.writeln('عدد الساعات: $hours');
    message.writeln('رقم الهاتف: $studentPhone');
    if (notes.isNotEmpty) {
      message.writeln('ملاحظات: $notes');
    }
    if (!isTargetUser(context)) {
      message.writeln('سعر الساعة: \$${teacher.hourlyPrice ?? 0}');
      message.writeln('إجمالي السعر: \$${totalPrice.toStringAsFixed(1)}');
    }
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
