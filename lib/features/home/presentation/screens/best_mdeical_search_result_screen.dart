import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/categories_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/public_courses_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/public_courses/public_courses_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/widgets/best_medical_vertical_item.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BestMedicalSearchResultScreen extends StatefulWidget {
  final CoursesParams coursesParams;

  BestMedicalSearchResultScreen({required this.coursesParams});

  @override
  State<BestMedicalSearchResultScreen> createState() => _BestMedicalSearchResultScreenState();

}

class _BestMedicalSearchResultScreenState extends State<BestMedicalSearchResultScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    context.read<PublicCoursesCubit>().getPublicCourses(categoryId:  widget.coursesParams.categoryId.toString()
        ,name: searchController.text,topRated: "1",type: 'filter');

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: customAppBar(
        index: 0,
        title: tr("best_medical_course"),status: true
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
                  onChanged: (val){
                  searchController.text = val;
                  context.read<PublicCoursesCubit>().getPublicCourses(
                      topRated: widget.coursesParams.topRated.toString(),type: 'filter'
                      , name:  searchController.text, categoryId: widget.coursesParams.categoryId);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: greyLight,
                    hintText: tr("search_course_here"),
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
            child: BlocBuilder<PublicCoursesCubit, PublicCoursesState>(
              builder: (context, state) {
                return context.read<PublicCoursesCubit>().loading == true ?
                     Center(child: SpinKitPulse(color: primary,size: 50,)) :
                context.read<PublicCoursesCubit>().publicCoursesResponse == null ?
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          alignment : Alignment.center,
                          child: customSvg(name: course,width:
                          context.width/8,height: context.width/8)),
                      Text(tr("no_courses"),
                        style: TextStyles.textStyleBold15
                            .copyWith(color: primary)
                        ,textScaler: TextScaler.linear(1),)
                    ],
                  ),
                ) : context.read<PublicCoursesCubit>().publicCoursesResponse!.data!.isEmpty ?
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
                ) :

                  ListView.builder(
                itemCount: context.read<PublicCoursesCubit>().publicCoursesResponse!.data!.length,
                padding: EdgeInsets.only(left: context.width/45,right: context.width/45),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context,index)=> BestMedicalVerticalItem(typeIndex: 1
                  , data: context.read<PublicCoursesCubit>().publicCoursesResponse!.data![index],));
  },
),
          ),
        ],
      ),
    );
  }
}