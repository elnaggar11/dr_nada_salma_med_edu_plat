import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/repositories/home_repositories.dart';

class RequestCourseBookingUseCase {
  final HomeRepositories homeRepositories;

  RequestCourseBookingUseCase(this.homeRepositories);

  Future<Either<Failure, dynamic>> call({
    required List<int> courseIds,
    String? couponCode,
  }) async {
    return await homeRepositories.requestCourseBooking(
      courseIds: courseIds,
      couponCode: couponCode,
    );
  }
}
