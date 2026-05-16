import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/notifications/domain/entities/notifications_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/notifications/domain/repositories/notifications_repositories.dart';

class NotificationsUseCase extends UseCase<NotificationsResponse,NoParams>{
  final NotificationsRepositories notificationsRepositories;

  NotificationsUseCase(this.notificationsRepositories);

  @override
  Future<Either<Failure, NotificationsResponse>> call(NoParams params) async{
    return await notificationsRepositories.getNotifications();
  }

}