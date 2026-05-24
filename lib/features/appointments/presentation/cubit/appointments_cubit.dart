import 'package:flutter_bloc/flutter_bloc.dart';
import 'appointments_state.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  AppointmentsCubit() : super(AppointmentsState(selectedDate: DateTime.now())) {
    getWeekDays();
  }

  void getWeekDays() {
    DateTime now = DateTime.now();
    DateTime saturday;
    if (now.weekday == DateTime.saturday) {
      saturday = now;
    } else if (now.weekday == DateTime.sunday) {
      saturday = now.subtract(const Duration(days: 1));
    } else {
      saturday = now.subtract(Duration(days: now.weekday + 1));
    }

    List<DateTime> days = [];
    for (int i = 0; i < 7; i++) {
      days.add(saturday.add(Duration(days: i)));
    }

    emit(state.copyWith(weekDays: days));
  }

  void selectDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }
}
