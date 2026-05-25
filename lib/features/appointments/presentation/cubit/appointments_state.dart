import 'package:equatable/equatable.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/domain/entities/time_slot_response.dart';

enum RequestState { initial, loading, loaded, error }

class AppointmentsState extends Equatable {
  final RequestState state;
  final RequestState deleteState;
  final RequestState addState;
  final RequestState updateState;
  final List<DateTime> weekDays;
  final DateTime selectedDate;
  final List<TimeSlot> timeSlots;
  final String message;

  const AppointmentsState({
    this.state = RequestState.initial,
    this.deleteState = RequestState.initial,
    this.addState = RequestState.initial,
    this.updateState = RequestState.initial,
    this.weekDays = const [],
    required this.selectedDate,
    this.timeSlots = const [],
    this.message = '',
  });

  AppointmentsState copyWith({
    RequestState? state,
    RequestState? deleteState,
    RequestState? addState,
    RequestState? updateState,
    List<DateTime>? weekDays,
    DateTime? selectedDate,
    List<TimeSlot>? timeSlots,
    String? message,
  }) {
    return AppointmentsState(
      state: state ?? this.state,
      deleteState: deleteState ?? this.deleteState,
      addState: addState ?? this.addState,
      updateState: updateState ?? this.updateState,
      weekDays: weekDays ?? this.weekDays,
      selectedDate: selectedDate ?? this.selectedDate,
      timeSlots: timeSlots ?? this.timeSlots,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        state,
        deleteState,
        addState,
        updateState,
        weekDays,
        selectedDate,
        timeSlots,
        message,
      ];
}


