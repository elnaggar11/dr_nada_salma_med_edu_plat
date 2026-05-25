import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/fonts.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/model/time_slot.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/presentation/cubit/appointments_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/presentation/cubit/appointments_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    context.read<AppointmentsCubit>().fetchTimeSlots();
  }

  @override
  void dispose() {
    _headerScrollController.dispose();
    _gridScrollController.dispose();
    super.dispose();
  }

  TimeSlot? _findMatchingSlot(AppointmentsState state, DateTime cellDate, int hour) {
    for (var slot in state.timeSlots) {
      final localDate = slot.date.toLocal();
      if (localDate.year == cellDate.year &&
          localDate.month == cellDate.month &&
          localDate.day == cellDate.day &&
          int.parse(slot.startTime.split(':')[0]) == hour) {
        return slot;
      }
    }
    return null;
  }

  void _showEditSlotDialog(BuildContext context, TimeSlot slot) {
    final cubit = context.read<AppointmentsCubit>();
    String selectedStart = slot.startTime.substring(0, 5);
    String selectedEnd = slot.endTime.substring(0, 5);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text(
                tr("edit_availability"),
                style: TextStyles.textStyleBold16.copyWith(color: primary),
                textAlign: TextAlign.center,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(tr("from_hour"), style: TextStyles.textStyleBold13.copyWith(color: black)),
                      DropdownButton<String>(
                        dropdownColor: white,
                        value: selectedStart,
                        items: List.generate(13, (index) => 8 + index).map((h) {
                          final label = "${h.toString().padLeft(2, '0')}:00";
                          return DropdownMenuItem(value: label, child: Text(label, style: const TextStyle(fontFamily: poppins)));
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              selectedStart = val;
                              int h = int.parse(val.split(':')[0]);
                              selectedEnd = "${(h + 1).toString().padLeft(2, '0')}:00";
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(tr("to_hour"), style: TextStyles.textStyleBold13.copyWith(color: black)),
                      DropdownButton<String>(
                        dropdownColor: white,
                        value: selectedEnd,
                        items: List.generate(13, (index) => 9 + index).map((h) {
                          final label = "${h.toString().padLeft(2, '0')}:00";
                          return DropdownMenuItem(value: label, child: Text(label, style: const TextStyle(fontFamily: poppins)));
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              selectedEnd = val;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(tr("no"), style: const TextStyle(color: grey2)),
                ),
                MaterialButton(
                  color: primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  onPressed: () {
                    Navigator.pop(context);
                    final formattedDate = DateFormat('yyyy-MM-dd').format(slot.date);
                    cubit.updateTimeSlot(
                      id: slot.id,
                      date: formattedDate,
                      startTime: "$selectedStart:00",
                      endTime: "$selectedEnd:00",
                    );
                  },
                  child: Text(tr("save"), style: const TextStyle(color: white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double columnWidth = context.width / 3.2;
    final double timeLabelWidth = context.width / 6.5;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(
        title: tr("my_schedule"),
        context: context,
        status: true,
        appBarInd: 0,
        widget: const SizedBox.shrink(),
      ),
      body: BlocBuilder<AppointmentsCubit, AppointmentsState>(
        builder: (context, state) {
          if (state.weekDays.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              _buildStickyHeader(context, state, timeLabelWidth, columnWidth),
              Expanded(
                child: state.state == RequestState.loading
                    ? const Center(child: CircularProgressIndicator())
                    : _buildScrollableArea(
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
    final days = [
      tr("saturday"),
      tr("sunday"),
      tr("monday"),
      tr("tuesday"),
      tr("wednesday"),
      tr("thursday"),
      tr("friday"),
    ];
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
            days[index],
            style: TextStyles.textStyleBold14.copyWith(
              color: isToday ? orangeBold : primary,
            ),
          ),
          Text(
            DateFormat('MMM d').format(date),
            style: TextStyles.textStyleBold12.copyWith(
              color: grey1,
              fontSize: 10,
              fontFamily: poppins,
            ),
          ),
        ],
      ),
    );
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
                          .map((hour) => _buildCell(context, state, dayIndex, hour))
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
    return Column(
      children: times.map((hour) {
        return Container(
          width: width,
          height: context.height / 12.5,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: context.height / 160),
          child: Text(
            "${hour.toString().padLeft(2, '0')}:00",
            style: TextStyles.textStyleBold12.copyWith(
              color: grey1,
              fontSize: 11,
              fontFamily: poppins,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCell(BuildContext context, AppointmentsState state, int dayIndex, int hour) {
    bool isHoliday = dayIndex == 6; // Friday
    final cellDate = state.weekDays[dayIndex];
    final matchingSlot = _findMatchingSlot(state, cellDate, hour);
    final cubit = context.read<AppointmentsCubit>();

    if (isHoliday && hour == 13) {
      return Container(
        height: context.height / 12.5,
        decoration: BoxDecoration(
          border: Border.all(color: greyLight.withOpacity(0.5), width: 0.5),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.access_time, color: grey1, size: 16),
              Text(
                tr("not_available") + "\n" + "يوم إجازة",
                textAlign: TextAlign.center,
                style: const TextStyle(color: grey1, fontSize: 10),
              ),
            ],
          ),
        ),
      );
    }

    if (matchingSlot != null) {
      final isReserved = matchingSlot.isBooked;

      if (isReserved) {
        return Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(6),
          height: context.height / 12.5 - 8,
          decoration: BoxDecoration(
            color: orangeBold.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: orangeBold.withOpacity(0.2)),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${matchingSlot.startTime.substring(0, 5)} - ${matchingSlot.endTime.substring(0, 5)}",
                    style: const TextStyle(
                      color: orangeBold,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      fontFamily: poppins,
                    ),
                  ),
                  Text(
                    tr("reserved_appointment"),
                    style: const TextStyle(color: grey1, fontSize: 9.5),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Positioned(
                top: -6,
                right: -6,
                child: IconButton(
                  icon: const Icon(Icons.close, color: orangeBold, size: 16),
                  onPressed: () => cubit.deleteTimeSlot(matchingSlot.id),
                ),
              ),
            ],
          ),
        );
      } else {
        // Available Slot (Green)
        return GestureDetector(
          onTap: () => _showEditSlotDialog(context, matchingSlot),
          child: Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(6),
            height: context.height / 12.5 - 8,
            decoration: BoxDecoration(
              color: greenLight.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: greenLight.withOpacity(0.2)),
            ),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${matchingSlot.startTime.substring(0, 5)} - ${matchingSlot.endTime.substring(0, 5)}",
                        style: const TextStyle(
                          color: greenLight,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          fontFamily: poppins,
                        ),
                      ),
                      Text(
                        tr("available_time"),
                        style: const TextStyle(color: greenLight, fontSize: 9.5),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -8,
                  right: -8,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.red, size: 18),
                    onPressed: () => cubit.deleteTimeSlot(matchingSlot.id),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }

    // Empty Cell with Green "+" button to interactively add slot
    return GestureDetector(
      onTap: () {
        final String formattedDate = DateFormat('yyyy-MM-dd').format(cellDate);
        final String start = "${hour.toString().padLeft(2, '0')}:00";
        final String end = "${(hour + 1).toString().padLeft(2, '0')}:00";
        cubit.addTimeSlot(
          date: formattedDate,
          startTime: start,
          endTime: end,
        );
      },
      child: Container(
        height: context.height / 12.5,
        decoration: BoxDecoration(
          border: Border.all(color: greyLight.withOpacity(0.5), width: 0.5),
        ),
        child: const Center(
          child: Icon(
            Icons.add_circle_outline,
            color: greenLight,
            size: 20,
          ),
        ),
      ),
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
        Text(label, style: const TextStyle(fontSize: 10, color: primary)),
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
