import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/domain/repositories/appointments_repository.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/domain/entities/time_slot_response.dart';
import 'appointments_state.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  final AppointmentsRepository repository;

  AppointmentsCubit(this.repository)
    : super(AppointmentsState(selectedDate: DateTime.now())) {
    getWeekDays();
    getTimeSlots();
  }

  void getWeekDays() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    List<DateTime> days = [];
    for (int i = 0; i < 7; i++) {
      days.add(today.add(Duration(days: i)));
    }

    emit(state.copyWith(weekDays: days));
  }

  void selectDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  Future<void> getTimeSlots() async {
    emit(state.copyWith(state: RequestState.loading));
    final result = await repository.getTimeSlots();
    result.fold(
      (failure) {
        String msg = 'Something went wrong';
        if (failure is ServerFailure) {
          msg = failure.message;
        } else if (failure is AuthFailure) {
          msg = failure.message;
        } else if (failure is StatusFailure) {
          msg = failure.message;
        }
        emit(state.copyWith(state: RequestState.error, message: msg));
      },
      (response) {
        emit(
          state.copyWith(
            state: RequestState.loaded,
            timeSlots: response.data ?? [],
          ),
        );
      },
    );
  }

  Future<void> deleteTimeSlot(int id) async {
    emit(state.copyWith(deleteState: RequestState.loading));
    final result = await repository.deleteTimeSlot(id);
    result.fold(
      (failure) {
        String msg = 'Something went wrong';
        if (failure is ServerFailure) {
          msg = failure.message;
        } else if (failure is AuthFailure) {
          msg = failure.message;
        } else if (failure is StatusFailure) {
          msg = failure.message;
        }
        emit(state.copyWith(deleteState: RequestState.error, message: msg));
      },
      (response) {
        final updatedSlots = List<TimeSlot>.from(state.timeSlots)
          ..removeWhere((slot) => slot.id == id);
        emit(
          state.copyWith(
            deleteState: RequestState.loaded,
            timeSlots: updatedSlots,
            message: response['message'] ?? 'Deleted successfully',
          ),
        );
      },
    );
  }

  Future<void> addTimeSlot({
    required String date,
    required String startTime,
    required String endTime,
  }) async {
    emit(state.copyWith(addState: RequestState.loading));
    final result = await repository.addTimeSlot(
      date: date,
      startTime: startTime,
      endTime: endTime,
    );
    result.fold(
      (failure) {
        String msg = 'Something went wrong';
        if (failure is ServerFailure) {
          msg = failure.message;
        } else if (failure is AuthFailure) {
          msg = failure.message;
        } else if (failure is StatusFailure) {
          msg = failure.message;
        }
        emit(state.copyWith(addState: RequestState.error, message: msg));
      },
      (newSlot) {
        final displaySlot = TimeSlot(
          id: newSlot.id,
          teacherId: newSlot.teacherId,
          date: DateTime.tryParse(date),
          startTime: startTime,
          endTime: endTime,
          isBooked: newSlot.isBooked ?? false,
          createdAt: newSlot.createdAt,
          updatedAt: newSlot.updatedAt,
        );
        final updatedSlots = List<TimeSlot>.from(state.timeSlots)
          ..add(displaySlot);
        emit(
          state.copyWith(
            addState: RequestState.loaded,
            timeSlots: updatedSlots,
            message: 'Time slot created successfully',
          ),
        );
      },
    );
  }

  Future<void> updateTimeSlot({
    required int id,
    required String date,
    required String startTime,
    required String endTime,
  }) async {
    emit(state.copyWith(updateState: RequestState.loading));
    final result = await repository.updateTimeSlot(
      id: id,
      date: date,
      startTime: startTime,
      endTime: endTime,
    );
    result.fold(
      (failure) {
        String msg = 'Something went wrong';
        if (failure is ServerFailure) {
          msg = failure.message;
        } else if (failure is AuthFailure) {
          msg = failure.message;
        } else if (failure is StatusFailure) {
          msg = failure.message;
        }
        emit(state.copyWith(updateState: RequestState.error, message: msg));
      },
      (updatedSlot) {
        final displaySlot = TimeSlot(
          id: updatedSlot.id ?? id,
          teacherId: updatedSlot.teacherId,
          date: DateTime.tryParse(date),
          startTime: startTime,
          endTime: endTime,
          isBooked: updatedSlot.isBooked ?? false,
          createdAt: updatedSlot.createdAt,
          updatedAt: updatedSlot.updatedAt,
        );
        final updatedSlots = List<TimeSlot>.from(state.timeSlots);
        final index = updatedSlots.indexWhere((slot) => slot.id == id);
        if (index != -1) {
          updatedSlots[index] = displaySlot;
        }
        emit(
          state.copyWith(
            updateState: RequestState.loaded,
            timeSlots: updatedSlots,
            message: 'Time slot updated successfully',
          ),
        );
      },
    );
  }
}
