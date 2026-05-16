import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/public_courses_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/private_lessons_cubit/private_lessons_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/widgets/top_private_lessons_item_vertical.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PrivateLessonsSearchResultScreen extends StatefulWidget{
  final CoursesParams params;

  PrivateLessonsSearchResultScreen({required this.params});

  @override
  State<PrivateLessonsSearchResultScreen> createState() => _PrivateLessonsSearchResultScreenState();

}

class _PrivateLessonsSearchResultScreenState extends State<PrivateLessonsSearchResultScreen>{
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    context.read<PrivateLessonsCubit>().getPrivateLessons(params:
    CoursesParams(categoryId: widget.params.categoryId.toString()
        ,courseName: searchController.text,topRated: widget.params.topRated));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: white,
      appBar: customAppBar(
        appBarInd: 0,
        title: tr("my_private_lessons"),status: true
        ,context: context, widget: InkWell(onTap: (){},child: Container(
            alignment: Alignment.center,
            child: customSvg(name: share)),),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            SizedBox(width: context.width/30,),
            Expanded(child:  MediaQuery(
              data: MediaQueryData(textScaler: TextScaler.linear(1)),
              child: TextField(
                controller: searchController,
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
                /*  context.pushNamed(name: filterSc);*/
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
          SizedBox(height: context.height/50,),
          Container(
            margin: EdgeInsets.only(left: context.width/25,right: context.width/25),
            child: Text(tr("search_result"),style: TextStyles.textStyleNormal14
                .copyWith(fontWeight: FontWeight.w500,color: primary)
              ,textScaler: TextScaler.linear(1.0),),
          ),
          SizedBox(height: context.height/200,),
          Expanded(
            child: BlocBuilder<PrivateLessonsCubit, PrivateLessonsState>(
              builder: (context, state) {
    return  context.read<PrivateLessonsCubit>().loading == true ?
         SpinKitPulse(color: primary,size: 50,) :
    (context.read<PrivateLessonsCubit>().publicCoursesResponse == null ||
        context.read<PrivateLessonsCubit>().publicCoursesResponse!.data!.isEmpty)?
    SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              alignment : Alignment.center,
              child: customSvg(name: course,width:
              context.width/8,height: context.width/8)),
          SizedBox(height: context.height/80,),
          Text(tr("no_courses"),
            style: TextStyles.textStyleBold15
                .copyWith(color: primary)
            ,textScaler: TextScaler.linear(1),)
        ],
      ),
    ) : context.read<PrivateLessonsCubit>().publicCoursesResponse == null ?
    SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              alignment : Alignment.center,
              child: customSvg(name: course,width:
              context.width/8,height: context.width/8)),
          SizedBox(height: context.height/80,),
          Text("No courses found",
            style: TextStyles.textStyleBold15
                .copyWith(color: primary)
            ,textScaler: TextScaler.linear(1),)
        ],
      ),
    ) :
      ListView.builder(
                itemCount: context.read<PrivateLessonsCubit>().publicCoursesResponse!.data!.length,
                padding: EdgeInsets.only(left: context.width/45,right: context.width/45),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context,index)=> TopPrivateLessonsItemVertical(typeInd: 3
                  , data: context.read<PrivateLessonsCubit>().publicCoursesResponse!.data![index],));
  },
),
          ),
        ],
      ),
    );
  }
}