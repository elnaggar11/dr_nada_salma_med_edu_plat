import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/notifications/domain/entities/notifications_response.dart';

abstract class NotificationsRepositories {
  Future<Either<Failure, NotificationsResponse>> getNotifications();
}
