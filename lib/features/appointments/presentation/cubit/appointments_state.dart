import 'package:equatable/equatable.dart';

enum RequestState { initial, loading, loaded, error }

class AppointmentsState extends Equatable {
  final RequestState state;
  final List<DateTime> weekDays;
  final DateTime selectedDate;
  final String message;

  const AppointmentsState({
    this.state = RequestState.initial,
    this.weekDays = const [],
    required this.selectedDate,
    this.message = '',
  });

  AppointmentsState copyWith({
    RequestState? state,
    List<DateTime>? weekDays,
    DateTime? selectedDate,
    String? message,
  }) {
    return AppointmentsState(
      state: state ?? this.state,
      weekDays: weekDays ?? this.weekDays,
      selectedDate: selectedDate ?? this.selectedDate,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [state, weekDays, selectedDate, message];
}
