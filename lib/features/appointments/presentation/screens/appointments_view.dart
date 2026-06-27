import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/fonts.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/image_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/presentation/cubit/appointments_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/const.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/presentation/cubit/appointments_state.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/domain/entities/time_slot_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AppointmentsView extends StatefulWidget {
  const AppointmentsView({super.key});

  @override
  State<AppointmentsView> createState() => _AppointmentsViewState();
}

class _AppointmentsViewState extends State<AppointmentsView> {
  late ScrollController _headerScrollController;
  late ScrollController _gridScrollController;
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _headerScrollController = ScrollController();
    _gridScrollController = ScrollController();

    _headerScrollController.addListener(() {
      if (_isUpdating) return;
      _isUpdating = true;
      if (_gridScrollController.hasClients &&
          _gridScrollController.offset != _headerScrollController.offset) {
        _gridScrollController.jumpTo(_headerScrollController.offset);
      }
      _isUpdating = false;
    });

    _gridScrollController.addListener(() {
      if (_isUpdating) return;
      _isUpdating = true;
      if (_headerScrollController.hasClients &&
          _headerScrollController.offset != _gridScrollController.offset) {
        _headerScrollController.jumpTo(_gridScrollController.offset);
      }
      _isUpdating = false;
    });
  }

  @override
  void dispose() {
    _headerScrollController.dispose();
    _gridScrollController.dispose();
    super.dispose();
  }

  int _getHourFromTime(String? timeStr) {
    if (timeStr == null) return 0;
    final parts = timeStr.split(':');
    if (parts.isNotEmpty) {
      return int.tryParse(parts[0]) ?? 0;
    }
    return 0;
  }

  TimeSlot? _getSlotForCell(List<TimeSlot> slots, DateTime dayDate, int hour) {
    for (final slot in slots) {
      if (slot.date != null) {
        if (slot.date!.year == dayDate.year &&
            slot.date!.month == dayDate.month &&
            slot.date!.day == dayDate.day) {
          final startHour = _getHourFromTime(slot.startTime);
          if (startHour == hour) {
            return slot;
          }
        }
      }
    }
    return null;
  }

  DateTime _cellStartDateTime(DateTime date, int hour) {
    return DateTime(date.year, date.month, date.day, hour);
  }

  bool _isPastCell(DateTime date, int hour) {
    return !_cellStartDateTime(date, hour).isAfter(DateTime.now());
  }

  bool _isPastSelectedStart(String dateStr, String startTimeStr) {
    final date = DateTime.tryParse(dateStr);
    final timeParts = startTimeStr.split(':');
    if (date == null || timeParts.length < 2) return true;

    final hour = int.tryParse(timeParts[0]);
    final minute = int.tryParse(timeParts[1]);
    if (hour == null || minute == null) return true;

    final selectedStart = DateTime(
      date.year,
      date.month,
      date.day,
      hour,
      minute,
    );
    return !selectedStart.isAfter(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final double columnWidth = context.width / 3.2;
    final double timeLabelWidth = context.width / 5.5;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(
        title: tr("my_schedule"),
        context: context,
        status: true,
        appBarInd: 0,
        widget: const SizedBox.shrink(),
      ),
      body: BlocListener<AppointmentsCubit, AppointmentsState>(
        listenWhen: (previous, current) =>
            previous.deleteState != current.deleteState ||
            previous.addState != current.addState ||
            previous.updateState != current.updateState,
        listener: (context, state) {
          if (state.deleteState == RequestState.loaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(tr("time_slot_deleted_success")),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state.deleteState == RequestState.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state.addState == RequestState.loaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(tr("time_slot_created_success")),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state.addState == RequestState.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state.updateState == RequestState.loaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(tr("time_slot_updated_success")),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state.updateState == RequestState.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },

        child: BlocBuilder<AppointmentsCubit, AppointmentsState>(
          builder: (context, state) {
            if (state.state == RequestState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == RequestState.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: TextStyles.textStyleBold14.copyWith(color: red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AppointmentsCubit>().getTimeSlots();
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: primary),
                      child: Text(
                        tr("retry"),
                        style: const TextStyle(color: white),
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state.weekDays.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                _buildStickyHeader(context, state, timeLabelWidth, columnWidth),
                Expanded(
                  child: _buildScrollableArea(
                    context,
                    state,
                    timeLabelWidth,
                    columnWidth,
                  ),
                ),
                _buildLegend(context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStickyHeader(
    BuildContext context,
    AppointmentsState state,
    double labelWidth,
    double colWidth,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: labelWidth),
          Expanded(
            child: SingleChildScrollView(
              controller: _headerScrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(7, (index) {
                  return SizedBox(
                    width: colWidth,
                    child: _buildHeaderCell(state, index),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(AppointmentsState state, int index) {
    final date = state.weekDays[index];
    final isToday =
        DateTime.now().day == date.day &&
        DateTime.now().month == date.month &&
        DateTime.now().year == date.year;

    return Container(
      padding: EdgeInsets.symmetric(vertical: context.height / 80),
      child: Column(
        children: [
          Text(
            _weekdayLabel(date),
            style: TextStyles.textStyleBold14.copyWith(
              color: isToday ? orangeBold : primary,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            DateFormat('MMM d').format(date),
            style: TextStyles.textStyleBold12.copyWith(
              color: grey1,
              fontSize: 11,
              fontFamily: poppins,
            ),
          ),
        ],
      ),
    );
  }

  String _weekdayLabel(DateTime date) {
    switch (date.weekday) {
      case DateTime.saturday:
        return tr("saturday");
      case DateTime.sunday:
        return tr("sunday");
      case DateTime.monday:
        return tr("monday");
      case DateTime.tuesday:
        return tr("tuesday");
      case DateTime.wednesday:
        return tr("wednesday");
      case DateTime.thursday:
        return tr("thursday");
      case DateTime.friday:
        return tr("friday");
    }
    return "";
  }

  Widget _buildScrollableArea(
    BuildContext context,
    AppointmentsState state,
    double labelWidth,
    double colWidth,
  ) {
    final times = List.generate(13, (index) => 8 + index);

    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTimeLabels(context, times, labelWidth),
          Expanded(
            child: SingleChildScrollView(
              controller: _gridScrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(7, (dayIndex) {
                  return SizedBox(
                    width: colWidth,
                    child: Column(
                      children: times
                          .map(
                            (hour) => _buildCell(
                              context,
                              dayIndex,
                              hour,
                              state.timeSlots,
                            ),
                          )
                          .toList(),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeLabels(BuildContext context, List<int> times, double width) {
    final double cellHeight = 140.0;
    return Column(
      children: times.map((hour) {
        return Container(
          width: width,
          height: cellHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: greyLight.withOpacity(0.5), width: 0.5),
              right: BorderSide(color: greyLight.withOpacity(0.5), width: 0.5),
              left: BorderSide(color: greyLight.withOpacity(0.5), width: 0.5),
            ),
          ),
          child: Text(
            "${hour.toString().padLeft(2, '0')}:00",
            style: TextStyles.textStyleBold12.copyWith(
              color: grey1,
              fontSize: 12,
              fontFamily: poppins,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCell(
    BuildContext context,
    int dayIndex,
    int hour,
    List<TimeSlot> slots,
  ) {
    final double cellHeight = 140.0;
    final dayDate = context.read<AppointmentsCubit>().state.weekDays[dayIndex];
    final slot = _getSlotForCell(slots, dayDate, hour);
    final isPastCell = _isPastCell(dayDate, hour);

    if (dayDate.weekday == DateTime.friday) {
      return Container(
        height: cellHeight,
        decoration: BoxDecoration(
          color: greyLight.withOpacity(0.5),
          border: Border.all(color: greyLight.withOpacity(0.5), width: 0.5),
        ),
      );
    }

    if (slot == null) {
      if (isPastCell) {
        return Container(
          height: cellHeight,
          decoration: BoxDecoration(
            color: greyLight.withOpacity(0.35),
            border: Border.all(color: greyLight.withOpacity(0.5), width: 0.5),
          ),
        );
      }

      if (!Const.isTeacher) {
        return Container(
          height: cellHeight,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: greyLight.withOpacity(0.5), width: 0.5),
          ),
        );
      }

      return GestureDetector(
        onTap: () {
          _showAddSlotDialog(context, dayDate, hour);
        },
        child: Container(
          height: cellHeight,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: greyLight.withOpacity(0.5), width: 0.5),
          ),
          child: const Center(
            child: Icon(Icons.add, color: Colors.grey, size: 16),
          ),
        ),
      );
    }

    final isBooked = slot.isBooked == true;
    final booking = slot.booking;

    Color bgColor = isBooked
        ? orangeBold.withOpacity(0.1)
        : greenLight.withOpacity(0.05);
    Color borderColor = isBooked
        ? orangeBold.withOpacity(0.2)
        : greenLight.withOpacity(0.2);
    Color textColor = isBooked ? orangeBold : Colors.green[800]!;

    if (isBooked && booking != null) {
      if (booking.status == 'confirmed') {
        bgColor = Colors.green.withOpacity(0.1);
        borderColor = Colors.green.withOpacity(0.3);
        textColor = Colors.green[800]!;
      } else if (booking.status == 'completed') {
        bgColor = Colors.blue.withOpacity(0.1);
        borderColor = Colors.blue.withOpacity(0.3);
        textColor = Colors.blue[800]!;
      }
    }

    final targetUser = Const.isTeacher ? booking?.student : booking?.teacher;
    final targetName =
        targetUser?.fullName ??
        (Const.isTeacher ? slot.studentName : slot.teacherName);
    final targetPhone = targetUser?.phoneNumber;
    final formattedPhone = targetPhone != null && targetPhone.isNotEmpty
        ? (targetPhone.startsWith('+')
              ? targetPhone
              : targetPhone.startsWith('966')
              ? "+$targetPhone"
              : "+966 $targetPhone")
        : "";
    final targetImage = targetUser?.image;

    String statusText = '';
    if (isBooked && booking != null) {
      if (booking.status == 'pending') {
        statusText = 'قيد الانتظار';
      } else if (booking.status == 'confirmed') {
        statusText = 'مؤكد';
      } else if (booking.status == 'completed') {
        statusText = 'مكتمل';
      }
    }

    return Container(
      height: cellHeight,
      decoration: BoxDecoration(
        border: Border.all(color: greyLight.withOpacity(0.5), width: 0.5),
      ),
      child: GestureDetector(
        onTap: () {
          if (Const.isTeacher && !isBooked) {
            _showEditSlotDialog(context, slot);
          }
        },
        child: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${slot.startTime?.substring(0, 5) ?? ''} - ${slot.endTime?.substring(0, 5) ?? ''}",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        fontFamily: poppins,
                      ),
                    ),
                    const SizedBox(height: 2),
                    if (isBooked) ...[
                      if (targetImage != null && targetImage.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: targetImage,
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(strokeWidth: 2),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.person, size: 24),
                          ),
                        ),
                        const SizedBox(height: 2),
                      ],
                      if (targetName != null && targetName.isNotEmpty)
                        Text(
                          Const.isTeacher ? "$targetName" : "مع: $targetName",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      if (statusText.isNotEmpty)
                        Text(
                          statusText,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (targetPhone != null && targetPhone.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        GestureDetector(
                          onTap: () async {
                            final uri = Uri.parse(
                              "tel:${formattedPhone.replaceAll(' ', '')}",
                            );
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri);
                            }
                          },
                          child: Text(
                            formattedPhone,
                            textDirection: ui.TextDirection.ltr,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: textColor,
                            ),
                          ),
                        ),
                      ],
                    ] else ...[
                      Text(
                        tr("available_time"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (Const.isTeacher && !isBooked)
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      _showDeleteConfirmationDialog(context, slot);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 11,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, TimeSlot slot) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            tr("confirm_delete_time_slot"),
            style: TextStyles.textStyleBold14.copyWith(color: primary),
          ),
          content: Text(
            tr("delete_time_slot_prompt"),
            style: TextStyles.textStyleBold12.copyWith(color: black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text(
                tr("cancel"),
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.read<AppointmentsCubit>().deleteTimeSlot(slot.id!);
              },
              child: Text(
                tr("delete"),
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAddSlotDialog(BuildContext context, DateTime dayDate, int hour) {
    final String initialDateStr = DateFormat('yyyy-MM-dd').format(dayDate);
    final String initialStartStr = "${hour.toString().padLeft(2, '0')}:00";
    final String initialEndStr = "${(hour + 1).toString().padLeft(2, '0')}:00";

    String selectedDateStr = initialDateStr;
    String selectedStartStr = initialStartStr;
    String selectedEndStr = initialEndStr;

    bool isSubmitting = false;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (stContext, setState) {
            final startHour = int.tryParse(selectedStartStr.split(':')[0]) ?? 0;
            final startMin = int.tryParse(selectedStartStr.split(':')[1]) ?? 0;
            final endHour = int.tryParse(selectedEndStr.split(':')[0]) ?? 0;
            final endMin = int.tryParse(selectedEndStr.split(':')[1]) ?? 0;

            final bool isValid =
                (endHour > startHour) ||
                (endHour == startHour && endMin > startMin);
            final bool isFutureStart = !_isPastSelectedStart(
              selectedDateStr,
              selectedStartStr,
            );

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Row(
                children: [
                  const Icon(Icons.add_alarm, color: primary, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    tr("add_time_slot"),
                    style: TextStyles.textStyleBold14.copyWith(
                      color: primary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr("select_date"),
                    style: TextStyles.textStyleBold12.copyWith(color: grey1),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: greyLight,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: grey3, width: 0.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedDateStr,
                          style: TextStyles.textStyleBold12.copyWith(
                            color: black,
                            fontFamily: poppins,
                          ),
                        ),
                        const Icon(
                          Icons.calendar_today,
                          color: grey1,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr("start_time"),
                              style: TextStyles.textStyleBold12.copyWith(
                                color: grey1,
                              ),
                            ),
                            const SizedBox(height: 6),
                            InkWell(
                              onTap: () async {
                                final time = await showTimePicker(
                                  context: stContext,
                                  initialTime: TimeOfDay(hour: hour, minute: 0),
                                );
                                if (time != null) {
                                  setState(() {
                                    selectedStartStr =
                                        "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
                                    selectedEndStr =
                                        "${((time.hour + 1) % 24).toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: grey3, width: 1),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      selectedStartStr,
                                      style: TextStyles.textStyleBold12
                                          .copyWith(
                                            color: black,
                                            fontFamily: poppins,
                                          ),
                                    ),
                                    const Icon(
                                      Icons.access_time,
                                      color: primary,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr("end_time"),
                              style: TextStyles.textStyleBold12.copyWith(
                                color: grey1,
                              ),
                            ),
                            const SizedBox(height: 6),
                            InkWell(
                              onTap: () async {
                                final initialEndHour = (hour + 1) % 24;
                                final time = await showTimePicker(
                                  context: stContext,
                                  initialTime: TimeOfDay(
                                    hour: initialEndHour,
                                    minute: 0,
                                  ),
                                );
                                if (time != null) {
                                  setState(() {
                                    selectedEndStr =
                                        "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: grey3, width: 1),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      selectedEndStr,
                                      style: TextStyles.textStyleBold12
                                          .copyWith(
                                            color: black,
                                            fontFamily: poppins,
                                          ),
                                    ),
                                    const Icon(
                                      Icons.access_time,
                                      color: primary,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (!isValid) ...[
                    const SizedBox(height: 12),
                    Text(
                      tr("invalid_time_range"),
                      style: TextStyles.textStyleBold12.copyWith(
                        color: red,
                        fontSize: 11,
                      ),
                    ),
                  ],
                  if (!isFutureStart) ...[
                    const SizedBox(height: 12),
                    Text(
                      tr("time_slot_must_be_future"),
                      style: TextStyles.textStyleBold12.copyWith(
                        color: red,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ],
              ),
              actions: [
                TextButton(
                  onPressed: isSubmitting
                      ? null
                      : () {
                          Navigator.of(dialogContext).pop();
                        },
                  child: Text(
                    tr("cancel"),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                ElevatedButton(
                  onPressed: (!isValid || !isFutureStart || isSubmitting)
                      ? null
                      : () async {
                          setState(() {
                            isSubmitting = true;
                          });
                          await context.read<AppointmentsCubit>().addTimeSlot(
                            date: selectedDateStr,
                            startTime: selectedStartStr,
                            endTime: selectedEndStr,
                          );
                          Navigator.of(dialogContext).pop();
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: isSubmitting
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: white,
                          ),
                        )
                      : Text(
                          tr("save"),
                          style: const TextStyle(
                            color: white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showEditSlotDialog(BuildContext context, TimeSlot slot) {
    final String initialDateStr = slot.date != null
        ? DateFormat('yyyy-MM-dd').format(slot.date!)
        : '';
    final String initialStartStr = slot.startTime?.substring(0, 5) ?? '08:00';
    final String initialEndStr = slot.endTime?.substring(0, 5) ?? '09:00';

    String selectedDateStr = initialDateStr;
    String selectedStartStr = initialStartStr;
    String selectedEndStr = initialEndStr;

    bool isSubmitting = false;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (stContext, setState) {
            final startHour = int.tryParse(selectedStartStr.split(':')[0]) ?? 0;
            final startMin = int.tryParse(selectedStartStr.split(':')[1]) ?? 0;
            final endHour = int.tryParse(selectedEndStr.split(':')[0]) ?? 0;
            final endMin = int.tryParse(selectedEndStr.split(':')[1]) ?? 0;

            final bool isValid =
                (endHour > startHour) ||
                (endHour == startHour && endMin > startMin);
            final bool isFutureStart = !_isPastSelectedStart(
              selectedDateStr,
              selectedStartStr,
            );

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Row(
                children: [
                  const Icon(Icons.edit_calendar, color: primary, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    tr("edit_time_slot"),
                    style: TextStyles.textStyleBold14.copyWith(
                      color: primary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr("select_date"),
                    style: TextStyles.textStyleBold12.copyWith(color: grey1),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: greyLight,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: grey3, width: 0.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedDateStr,
                          style: TextStyles.textStyleBold12.copyWith(
                            color: black,
                            fontFamily: poppins,
                          ),
                        ),
                        const Icon(
                          Icons.calendar_today,
                          color: grey1,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr("start_time"),
                              style: TextStyles.textStyleBold12.copyWith(
                                color: grey1,
                              ),
                            ),
                            const SizedBox(height: 6),
                            InkWell(
                              onTap: () async {
                                final initialStartHour =
                                    int.tryParse(
                                      initialStartStr.split(':')[0],
                                    ) ??
                                    8;
                                final initialStartMin =
                                    int.tryParse(
                                      initialStartStr.split(':')[1],
                                    ) ??
                                    0;
                                final time = await showTimePicker(
                                  context: stContext,
                                  initialTime: TimeOfDay(
                                    hour: initialStartHour,
                                    minute: initialStartMin,
                                  ),
                                );
                                if (time != null) {
                                  setState(() {
                                    selectedStartStr =
                                        "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
                                    selectedEndStr =
                                        "${((time.hour + 1) % 24).toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: grey3, width: 1),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      selectedStartStr,
                                      style: TextStyles.textStyleBold12
                                          .copyWith(
                                            color: black,
                                            fontFamily: poppins,
                                          ),
                                    ),
                                    const Icon(
                                      Icons.access_time,
                                      color: primary,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr("end_time"),
                              style: TextStyles.textStyleBold12.copyWith(
                                color: grey1,
                              ),
                            ),
                            const SizedBox(height: 6),
                            InkWell(
                              onTap: () async {
                                final initialEndHour =
                                    int.tryParse(initialEndStr.split(':')[0]) ??
                                    9;
                                final initialEndMin =
                                    int.tryParse(initialEndStr.split(':')[1]) ??
                                    0;
                                final time = await showTimePicker(
                                  context: stContext,
                                  initialTime: TimeOfDay(
                                    hour: initialEndHour,
                                    minute: initialEndMin,
                                  ),
                                );
                                if (time != null) {
                                  setState(() {
                                    selectedEndStr =
                                        "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: grey3, width: 1),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      selectedEndStr,
                                      style: TextStyles.textStyleBold12
                                          .copyWith(
                                            color: black,
                                            fontFamily: poppins,
                                          ),
                                    ),
                                    const Icon(
                                      Icons.access_time,
                                      color: primary,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (!isValid) ...[
                    const SizedBox(height: 12),
                    Text(
                      tr("invalid_time_range"),
                      style: TextStyles.textStyleBold12.copyWith(
                        color: red,
                        fontSize: 11,
                      ),
                    ),
                  ],
                  if (!isFutureStart) ...[
                    const SizedBox(height: 12),
                    Text(
                      tr("time_slot_must_be_future"),
                      style: TextStyles.textStyleBold12.copyWith(
                        color: red,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ],
              ),
              actions: [
                TextButton(
                  onPressed: isSubmitting
                      ? null
                      : () {
                          Navigator.of(dialogContext).pop();
                        },
                  child: Text(
                    tr("cancel"),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                ElevatedButton(
                  onPressed: (!isValid || !isFutureStart || isSubmitting)
                      ? null
                      : () async {
                          setState(() {
                            isSubmitting = true;
                          });
                          await context
                              .read<AppointmentsCubit>()
                              .updateTimeSlot(
                                id: slot.id!,
                                date: selectedDateStr,
                                startTime: selectedStartStr,
                                endTime: selectedEndStr,
                              );
                          Navigator.of(dialogContext).pop();
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: isSubmitting
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: white,
                          ),
                        )
                      : Text(
                          tr("save"),
                          style: const TextStyle(
                            color: white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildLegend(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.height / 50),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: greyLight)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _legendItem(tr("available_time"), greenLight),
          SizedBox(width: context.width / 25),
          _legendItem(tr("reserved_appointment"), orangeBold),
          SizedBox(width: context.width / 25),
          _legendItem(tr("not_available"), grey1),
        ],
      ),
    );
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: primary)),
        const SizedBox(width: 5),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ],
    );
  }
}
