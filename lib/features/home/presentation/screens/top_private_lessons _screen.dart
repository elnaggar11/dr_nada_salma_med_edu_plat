import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/empty_course_widget.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/private_lessons_cubit/private_lessons_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/public_courses/public_courses_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/widgets/top_private_lessons_item_vertical.dart';
import 'package:dr_nada_salma_med_edu_plat/features/shimmer/courses/courses_shimmer_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/public_courses_response.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TopPrivateLessonsScreen extends StatefulWidget {


  @override
  State<TopPrivateLessonsScreen> createState() => _TopPrivateLessonsScreenState();


}

class _TopPrivateLessonsScreenState extends State<TopPrivateLessonsScreen> {
  static const int _pageSize = 8;

  late final PagingController<int, Data> pagingController;

  @override
  void initState() {
    super.initState();
    pagingController = PagingController<int,Data>(firstPageKey: 1);
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
  }
  Future<void> fetchPage(int pageKey) async {
    final cubit = context.read<PrivateLessonsCubit>();
    final params = CoursesParams(
      page: pageKey,
      limit: _pageSize,
      categoryId: "1",
      courseName: "",
      topRated: "0",
    );

    try {
      final newItems = await cubit.getPaginatedCourses(
        page: pageKey,
        limit: _pageSize,
        params: params,
      );

      final isLastPage = newItems.length < _pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: customAppBar(
          appBarInd: 0,
          title: tr("top_private_lessons"),status: true
          ,context: context, widget: InkWell(onTap: (){},child: Container(
              alignment: Alignment.center,
              child: customSvg(name: share)),)),
      body: SizedBox(
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              SizedBox(width: context.width/30,),
              Expanded(child:  MediaQuery(
                data: MediaQueryData(textScaler: TextScaler.linear(1)),
                child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: greyLight,
                      hintText: tr("search_course"),
                      contentPadding: EdgeInsets.only(top: 13,bottom: 13),
                      hintStyle: TextStyles.textStyleNormal12.copyWith(color: black),
                      prefixIcon: IntrinsicHeight(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                width: context.width/8.5,
                                alignment: Alignment.center,
                                child: customSvg(name: search)),
                            SizedBox(width: context.width/90,),
                            VerticalDivider(thickness: 1,color: black.withOpacity(.1),indent: 15,endIndent: 15,)

                          ],
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: searchBg),
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: searchBg),
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: searchBg),
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: searchBg),
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: searchBg),
                          borderRadius: BorderRadius.all(Radius.circular(40))),

                    )),
              )),
              SizedBox(width: context.width/50,),
              InkWell(
                onTap: (){
                  context.pushNamed(name: filterSc,args: "Filter Private lessons");
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: orangeBold,),
                  child: customSvg(name: filter),),
              ),
              SizedBox(width: context.width/30,),],),

            SizedBox(height: context.height/200,),
            Expanded(
                child: RefreshIndicator(
                  onRefresh: ()async{
                    pagingController.refresh();
                  },
                  child: PagedListView<int, Data>(
                    pagingController: pagingController,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,

                    builderDelegate: PagedChildBuilderDelegate<Data>(
                      animateTransitions: true,
                      firstPageProgressIndicatorBuilder:  (val){
                        return CoursesShimmerList();
                      },
                      newPageProgressIndicatorBuilder: (val){
                        return CoursesShimmerList();
                      },
                      firstPageErrorIndicatorBuilder: (val){
                        return EmptyCourseWidget();
                      },
                      itemBuilder: (_, item, index) =>  TopPrivateLessonsItemVertical(typeInd: 2
                        , data: context.read<PrivateLessonsCubit>().publicCoursesResponse!.data![index],),
                    ),),
                )
            ),
          ],
        ),
      ),
    );
  }
}