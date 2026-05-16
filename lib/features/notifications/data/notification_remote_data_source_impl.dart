import 'package:dr_nada_salma_med_edu_plat/core/utils/api_base_helper.dart';
import 'package:dr_nada_salma_med_edu_plat/features/notifications/domain/entities/notifications_response.dart';

import '../../../core/errors/exceptions.dart';

const notificationsApi = "/notifications";

abstract class NotificationsRemoteDataSource {
  Future<NotificationsResponse>getNotifications();
}
class NotificationsRemoteDataSourceImpl implements NotificationsRemoteDataSource {
  final ApiBaseHelper helper;

  NotificationsRemoteDataSourceImpl(this.helper);

  @override
  Future<NotificationsResponse> getNotifications()async {
    try{
      final response = await helper.get(url: notificationsApi,);
      return NotificationsResponse.fromJson(response);
    }on ServerException catch(e){
      throw ServerException(message: e.message);
    }on UnAuthorizedException catch(e){
      throw UnAuthorizedException(message: e.message);
    }on UnprocessableContentException catch(e){
      throw UnprocessableContentException(message: e.message);
    }on ForbiddenException catch(e){
      throw ForbiddenException(message: e.message);
    }
  }

}