import 'package:dr_nada_salma_med_edu_plat/features/appointments/model/time_slot.dart';
import 'package:equatable/equatable.dart';

enum RequestState { initial, loading, loaded, error }

class AppointmentsState extends Equatable {
  final RequestState state;
  final List<DateTime> weekDays;
  final DateTime selectedDate;
  final List<TimeSlot> timeSlots;
  final String message;

  const AppointmentsState({
    this.state = RequestState.initial,
    this.weekDays = const [],
    required this.selectedDate,
    this.timeSlots = const [],
    this.message = '',
  });

  AppointmentsState copyWith({
    RequestState? state,
    List<DateTime>? weekDays,
    DateTime? selectedDate,
    List<TimeSlot>? timeSlots,
    String? message,
  }) {
    return AppointmentsState(
      state: state ?? this.state,
      weekDays: weekDays ?? this.weekDays,
      selectedDate: selectedDate ?? this.selectedDate,
      timeSlots: timeSlots ?? this.timeSlots,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [state, weekDays, selectedDate, timeSlots, message];
}
