import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/fonts.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/presentation/cubit/appointments_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/presentation/cubit/appointments_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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

  @override
  Widget build(BuildContext context) {
    final double columnWidth = context.width / 3.5;
    final double timeLabelWidth = context.width / 6;

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
              fontSize: 8,
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
                          .map((hour) => _buildCell(context, dayIndex, hour))
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
          height: context.height / 13,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: context.height / 160),
          child: Text(
            "${hour.toString().padLeft(2, '0')}:00",
            style: TextStyles.textStyleBold12.copyWith(
              color: grey1,
              fontSize: 10,
              fontFamily: poppins,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCell(BuildContext context, int dayIndex, int hour) {
    bool isHoliday = dayIndex == 6; // Friday
    bool isReserved =
        (dayIndex == 1 && hour == 9) ||
        (dayIndex == 3 && hour == 14) ||
        (dayIndex == 2 && hour == 16) ||
        (dayIndex == 1 && hour == 16);

    bool isAvailable =
        (dayIndex == 0 && hour == 8) ||
        (dayIndex == 4 && hour == 8) ||
        (dayIndex == 3 && hour == 9) ||
        (dayIndex == 2 && hour == 10) ||
        (dayIndex == 5 && hour == 15) ||
        (dayIndex == 0 && hour == 13) ||
        (dayIndex == 0 && hour == 18) ||
        (dayIndex == 5 && hour == 18);

    if (isHoliday && hour == 13) {
      return Container(
        height: context.height / 13,
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
                style: TextStyle(color: grey1, fontSize: 8),
              ),
            ],
          ),
        ),
      );
    }

    if (isReserved) {
      return Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(4),
        height: context.height / 15,
        decoration: BoxDecoration(
          color: orangeBold.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: orangeBold.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Text(
              "${hour}:00 - ${hour + 2}:00",
              style: const TextStyle(
                color: orangeBold,
                fontSize: 7,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              tr("reserved_appointment"),
              style: const TextStyle(color: grey1, fontSize: 6),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "طالب: محمد علي",
              style: const TextStyle(
                color: primary,
                fontSize: 6,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
    }

    if (isAvailable) {
      return Container(
        margin: const EdgeInsets.all(4),
        height: context.height / 15,
        decoration: BoxDecoration(
          color: greenLight.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: greenLight.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${hour}:00 - ${hour + 2}:00",
              style: const TextStyle(
                color: greenLight,
                fontSize: 7,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(Icons.add, color: greenLight, size: 14),
          ],
        ),
      );
    }

    return Container(
      height: context.height / 13,
      decoration: BoxDecoration(
        border: Border.all(color: greyLight.withOpacity(0.5), width: 0.5),
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
