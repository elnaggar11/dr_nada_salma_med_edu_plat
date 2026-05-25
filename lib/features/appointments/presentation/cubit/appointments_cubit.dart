import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/domain/usecases/add_time_slot_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/domain/usecases/delete_time_slot_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/domain/usecases/fetch_time_slots_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/domain/usecases/update_time_slot_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/model/time_slot.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'appointments_state.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  final FetchTimeSlotsUseCase fetchTimeSlotsUseCase;
  final AddTimeSlotUseCase addTimeSlotUseCase;
  final UpdateTimeSlotUseCase updateTimeSlotUseCase;
  final DeleteTimeSlotUseCase deleteTimeSlotUseCase;

  AppointmentsCubit({
    required this.fetchTimeSlotsUseCase,
    required this.addTimeSlotUseCase,
    required this.updateTimeSlotUseCase,
    required this.deleteTimeSlotUseCase,
  }) : super(AppointmentsState(selectedDate: DateTime.now())) {
    getWeekDays();
    fetchTimeSlots();
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

  Future<void> fetchTimeSlots() async {
    emit(state.copyWith(state: RequestState.loading));
    final failOrSlots = await fetchTimeSlotsUseCase(NoParams());
    failOrSlots.fold(
      (failure) {
        emit(state.copyWith(state: RequestState.error, message: failure.message));
      },
      (slots) {
        emit(state.copyWith(state: RequestState.loaded, timeSlots: slots));
      },
    );
  }

  Future<void> addTimeSlot({
    required String date,
    required String startTime,
    required String endTime,
  }) async {
    emit(state.copyWith(state: RequestState.loading));
    final params = AddTimeSlotParams(date: date, startTime: startTime, endTime: endTime);
    final failOrSlot = await addTimeSlotUseCase(params);
    failOrSlot.fold(
      (failure) {
        emit(state.copyWith(state: RequestState.error, message: failure.message));
        msgKey.currentState?.showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
              failure.message,
              style: TextStyles.textStyleNormal13.copyWith(color: white),
            ),
          ),
        );
      },
      (newSlot) {
        final updatedSlots = List<TimeSlot>.from(state.timeSlots)..add(newSlot);
        emit(state.copyWith(state: RequestState.loaded, timeSlots: updatedSlots));

        msgKey.currentState?.showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
              "Time slot added successfully.",
              style: TextStyles.textStyleNormal13.copyWith(color: white),
            ),
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
    emit(state.copyWith(state: RequestState.loading));
    final params = UpdateTimeSlotParams(id: id, date: date, startTime: startTime, endTime: endTime);
    final failOrSlot = await updateTimeSlotUseCase(params);
    failOrSlot.fold(
      (failure) {
        emit(state.copyWith(state: RequestState.error, message: failure.message));
        msgKey.currentState?.showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
              failure.message,
              style: TextStyles.textStyleNormal13.copyWith(color: white),
            ),
          ),
        );
      },
      (updatedSlot) {
        final updatedSlots = state.timeSlots.map((slot) {
          return slot.id == id ? updatedSlot : slot;
        }).toList();
        emit(state.copyWith(state: RequestState.loaded, timeSlots: updatedSlots));

        msgKey.currentState?.showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
              "Time slot updated successfully.",
              style: TextStyles.textStyleNormal13.copyWith(color: white),
            ),
          ),
        );
      },
    );
  }

  Future<void> deleteTimeSlot(int id) async {
    emit(state.copyWith(state: RequestState.loading));
    final failOrVoid = await deleteTimeSlotUseCase(id);
    failOrVoid.fold(
      (failure) {
        emit(state.copyWith(state: RequestState.error, message: failure.message));
        msgKey.currentState?.showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
              failure.message,
              style: TextStyles.textStyleNormal13.copyWith(color: white),
            ),
          ),
        );
      },
      (_) {
        final updatedSlots = state.timeSlots.where((slot) => slot.id != id).toList();
        emit(state.copyWith(state: RequestState.loaded, timeSlots: updatedSlots));

        msgKey.currentState?.showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
              "Time slot deleted successfully.",
              style: TextStyles.textStyleNormal13.copyWith(color: white),
            ),
          ),
        );
      },
    );
  }
}
