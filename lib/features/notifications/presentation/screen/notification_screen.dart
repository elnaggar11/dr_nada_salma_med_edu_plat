import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/notifications/domain/entities/notifications_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/notifications/presentation/widgets/notification_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late final PagingController<int,Datum> pagingController;
  static const int _pageSize = 8;

  @override
  void initState() {
    pagingController = PagingController<int, Datum>(firstPageKey: 1);
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
    super.initState();
  }
  Future<void> fetchPage(int pageKey) async {
    final cubit = context.read<NotificationsCubit>();


    try {
      final newItems = await cubit.getPaginatedCourses(
        page: pageKey,
        limit: _pageSize,
      );

      final isLastPage = newItems.length < _pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      //pagingController.error = error;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: customAppBar(
        appBarInd: 0,
          title: tr("notifications"),status: true,
          context: context,
          widget:Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              alignment: Alignment.center,
              child: customSvg(name: delete)),
          SizedBox(width: context.width/30,),
          Text(tr("clear_all"),style:
          TextStyles.textStyleNormal12.copyWith
            (fontWeight: FontWeight.w500,color: red)
            ,textScaler: TextScaler.linear(1),)],)),
      body: SizedBox(
        child: RefreshIndicator(
          onRefresh: ()async{
            pagingController.refresh();
          },
          child: PagedListView<int, Datum>(
            pagingController: pagingController,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,

            builderDelegate: PagedChildBuilderDelegate<Datum>(
              animateTransitions: true,
              firstPageProgressIndicatorBuilder:  (val){
                return SpinKitPulse(color: primary,size: 40,);
              },
              newPageProgressIndicatorBuilder: (val){
                return SpinKitPulse(color: primary,size: 40,);
              },
              firstPageErrorIndicatorBuilder: (val){
                return SpinKitPulse(color: primary,size: 40,);
              },
              itemBuilder: (_, item, index) =>NotificationItem(data: item),
            ),),
        )
      ),
    );
  }
}