import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/fade_button.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/cubit/categories/categories_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/widgets/filter_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, required this.title});
  final String title;



  @override
  State<FilterScreen> createState() => _FilterScreenState();

}

class _FilterScreenState extends State<FilterScreen> {

  @override
  void initState() {
    context.read<CategoriesCubit>().getCategories();



    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: customAppBar(title: widget.title,widget: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        onTap: (){},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                alignment: Alignment.center,
                child: customSvg(name: delete)),
            SizedBox(width: context.width/30,),
            Text(tr("clear_filter"),style:
            TextStyles.textStyleNormal12.copyWith
              (fontWeight: FontWeight.w500,color: red)
              ,textScaler: TextScaler.linear(1),)],),),
          status: true,context: context,appBarInd: 0,),

      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: context.height/80,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: context.width/25,),
                  Text(tr("courses"),style: TextStyles.textStyleBold18.copyWith(color: primary)
                    ,textScaler: TextScaler.linear(1),),
                  Spacer(),
                  Container(
                      alignment: Alignment.center,
                      child: customSvg(name: dropdown)),
                  SizedBox(width: context.width/20,),],),
              SizedBox(height: context.height/80,),
              BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  return context.read<CategoriesCubit>().loading == true ?
                       SpinKitPulse(color: primary,size: 50,) :
                    ListView.builder(
                    shrinkWrap: true,
                    itemCount:  context.read<CategoriesCubit>().categoriesResponse!.data!.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return FilterItem(data: context.read<CategoriesCubit>().categoriesResponse!.data![index]
                        , index: index,type: "rate",);
                    },
                  );},),
              //  SizedBox(height: context.height/40,),
              /*   Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: context.width/25,),
                  Text("Tutoring",style: TextStyles.textStyleBold18.copyWith(color: primary)
                    ,textScaler: TextScaler.linear(1),),
                  Spacer(),
                  Container(
                      alignment: Alignment.center,
                      child: customSvg(name: dropdown)),
                  SizedBox(width: context.width/20,),],),
              SizedBox(height: context.height/80,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: context.width/25,),
                  Text("Ratings",style: TextStyles.textStyleBold18.copyWith(color: primary)
                    ,textScaler: TextScaler.linear(1),),
                  Spacer(),
                  Container(
                      alignment: Alignment.center,
                      child: customSvg(name: dropdown)),
                  SizedBox(width: context.width/20,),],),
              SizedBox(height: context.height/80,),
              BlocBuilder<FilterCubit, FilterState>(
                builder: (context, state) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount:  context.read<FilterCubit>().ratedItems.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return FilterItem(item: context.read<FilterCubit>().ratedItems[index]
                        , index: index,type: "rate",);
                    },
                  );},),*/
              SizedBox(height: context.height/30,),
              BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  return FadeColorButton(btnTitle: tr("apply"),buttonColor: primary,isPressed: false
                ,onButtonPressed: (){
                    CoursesParams params = CoursesParams(categoryId:
                    context.read<CategoriesCubit>().categoryId.toString()
                        ,courseName: "",topRated: "0");
                  widget.title == "Filter Private lessons" ?
                  context.pushNamed(name: privateLessonsSearchResultSc,args: params) :
                  context.pushNamed(name: bestMedicalSearchResultSc,args: params);
                },);
  },
),
              SizedBox(height: context.height/20,)

            ],
          ),
        ),
      ),
    );
  }
}