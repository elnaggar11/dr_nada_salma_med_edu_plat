import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/notifications/data/notification_remote_data_source_impl.dart';
import 'package:dr_nada_salma_med_edu_plat/features/notifications/domain/entities/notifications_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/notifications/domain/repositories/notifications_repositories.dart';

import '../../../core/errors/exceptions.dart';

class NotificationsRepositoryImpl implements NotificationsRepositories {
  final NotificationsRemoteDataSource notificationsRemoteDataSource;

  NotificationsRepositoryImpl(this.notificationsRemoteDataSource);

  @override
  Future<Either<Failure, NotificationsResponse>> getNotifications()async {
    try{
      final response = await notificationsRemoteDataSource.getNotifications();
      return Right(response);
    }on ServerException catch(e){
      return left(ServerFailure(message: e.message));
    }on UnAuthorizedException catch(e){
      return left(ServerFailure(message: e.message));
    }on UnprocessableContentException catch(e){
      return left(ServerFailure(message: e.message));
    }on ForbiddenException catch(e){
      return left(ServerFailure(message: e.message));
    }
  }

}