import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/fonts.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/presentation/cubit/category_with_blog/category_with_blog_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/presentation/widgets/blog_list.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/widgets/description_head_title_item.dart';
import 'package:dr_nada_salma_med_edu_plat/features/shimmer/blog/blog_shimmer_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BlogScreens extends StatefulWidget {

  final int appBarInd;



  const BlogScreens({super.key, required this.appBarInd});

  @override
  State<BlogScreens> createState() => _BlogScreensState();
}

class _BlogScreensState extends State<BlogScreens> {

  @override
  void initState() {
   context.read<CategoryWithBlogCubit>().getCategoriesWithBlog();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: customAppBar(
          widget: SizedBox(), title: tr("blog"), status: false,
          context: context,appBarInd: widget.appBarInd),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.height / 20,),
            Center(
              child: Container(
                alignment: Alignment.center,
                width: context.width / 3.5,
                padding: EdgeInsets.only(
                    top: 8, bottom: 8, left: 5, right: 10),
                decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.all(
                        Radius.circular(38))),
                child: Row(children: [
                  Container(
                      alignment: Alignment.center,
                      child: customSvg(name: edit)),
                  SizedBox(width: context.width / 50,),
                  Text(tr("blogs"),
                    style: TextStyles.textStyleBold10.copyWith(
                        fontWeight: FontWeight.w600
                        , color: white),
                    textScaler: TextScaler.linear(1.0),)
                ],),),
            ),
            SizedBox(height: context.height / 20,),
            Container(
              margin: EdgeInsets.only(
                  left: context.width / 20, right: context.width / 20),
              child: Text(
                tr("blog_des"),
                style: TextStyles.textStyleBold18
                    .copyWith(color: orangeBold),
                textScaler: TextScaler.linear(1),),
            ),
            SizedBox(height: context.height / 40,),
            Container(
              margin: EdgeInsets.only(
                  left: context.width / 20, right: context.width / 20),
              child: Text(
                tr("discover_blog")
                , style: TextStyles.textStyleNormal12
                  .copyWith(color: black
                  , fontWeight: FontWeight.w500),
                textScaler: TextScaler.linear(1),),
            ),
            SizedBox(height: context.height / 35,),
            Container(
              margin: EdgeInsets.only(
                  left: context.width / 20, right: context.width / 20),
              decoration: BoxDecoration(
                border: Border.all(color: orangeBold.withOpacity(.1),
                    width: 1,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.all(
                    Radius.circular(5.0)),),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: context.width / 20,),
                    Container(
                        alignment: Alignment.center,
                        child: customSvg(name: mail)),
                    SizedBox(width: context.width / 20,),
                    VerticalDivider(color: black.withOpacity(.1),
                      width: 2.0,
                      indent: 8,
                      endIndent: 8,),
                    SizedBox(width: context.width / 20,),
                    Text(tr("email"), style: TextStyles.textStyleNormal12
                        .copyWith
                      (fontWeight: FontWeight.w600,),
                      textScaler: TextScaler.linear(1.0),),
                    Spacer(),
                    MaterialButton(
                      color: orangeBold,
                      elevation: 1,
                      padding: EdgeInsets.only(
                          top: 8.5, bottom: 8.5, left: 10, right: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(5.0))),
                      onPressed: () {},
                      child: Text(tr("subscribe"),
                        style: TextStyles.textStyleBold12.copyWith(
                            color: white)
                        , textScaler: TextScaler.linear(1),),
                    )
                  ],),),),
            SizedBox(height: context.height/20,),
            BlocBuilder<CategoryWithBlogCubit,CategoryWithBlogState>(
              builder: (context, state) {
                return context.read<CategoryWithBlogCubit>().loading == true ?

                    BlogShimmerList():

                context.read<CategoryWithBlogCubit>().categoriesWithBlogResponse == null ?
                    SizedBox():

                Column(
                    mainAxisSize: MainAxisSize.min,
                    children: context.read<CategoryWithBlogCubit>().categoriesWithBlogResponse
                    !.data!.map((e)=>Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
              DescriptionHeadTitle(title: e.description),
              SizedBox(height: context.height/70,),
              BlogList(blogList: e.blogs),
              SizedBox(height: context.height/30,),
            ],)).toList(),);
  },
)
          ],
        ),
      ),

    );
  }
}