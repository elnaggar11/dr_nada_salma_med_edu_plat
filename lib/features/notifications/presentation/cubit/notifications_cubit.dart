import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/notifications/domain/entities/notifications_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/notifications/domain/usecase/notifications_use_case.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/failure.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this.notificationsUseCase) : super(NotificationsInitial());
  final NotificationsUseCase notificationsUseCase;
  NotificationsResponse? notificationsResponse;

  bool loading = false;
  bool success = false;
  bool error = false;

  Future<void> getNotifications() async {
    loading = true;
    error = false;
    success = false;
    emit(NotificationsLoadingState());
    try {
      final failOrResponse = await notificationsUseCase(NoParams());

      failOrResponse.fold(
        (fail) {
          if (fail is ServerFailure) {
            loading = false;
            error = true;
            success = false;
            emit(NotificationsErrorState(message: fail.message));
          }
        },
        (response) {
          loading = false;
          error = false;
          success = true;
          notificationsResponse = response;
          emit(NotificationsSuccessState(notificationsResponse: response));
        },
      );
    } catch (e) {
      loading = false;
      error = true;
      success = false;
      emit(NotificationsErrorState(message: e.toString()));
    }
  }

  /// --- Paginated version for infinite_scroll_pagination ---
  Future<List<Datum>> getPaginatedCourses({
    required int page,
    required int limit,
  }) async {
    try {
      // Copy current params and add page/limit

      final result = await notificationsUseCase(NoParams());

      return result.fold(
        (fail) {
          if (fail is ServerFailure) {
            emit(NotificationsErrorState(message: fail.message));
          }

          return [];
        },
        (response) {
          notificationsResponse = response;
          emit(NotificationsSuccessState(notificationsResponse: response));
          return response.data!.data! ?? [];
        },
      );
    } catch (e) {
      emit(NotificationsErrorState(message: e.toString()));
      return [];
    }
  }
}
