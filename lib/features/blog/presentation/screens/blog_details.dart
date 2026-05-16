import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/network_image_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/entities/blog_details/blog_details_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/presentation/cubit/blog_details_cubit/blog_details_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/widgets/description_content_item.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/widgets/description_head_title_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:html/parser.dart';

class BlogDetailsScreen extends StatefulWidget {
  final BlogDetailsParams blogDetailsParams;


  BlogDetailsScreen({super.key, required this.blogDetailsParams});



  @override
  State<BlogDetailsScreen> createState() => _BlogDetailsScreenState();

}

class _BlogDetailsScreenState extends State<BlogDetailsScreen> {

  @override
  void initState() {
    context.read<BlogDetailsCubit>().getBlogDetails(params: BlogDetailsParams(slug: widget.blogDetailsParams.slug));
    context.read<BlogDetailsCubit>().getSocial();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: customAppBar(widget: SizedBox(),status: false,context: context
          ,title: widget.blogDetailsParams.title,appBarInd: 0),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.height/80,),
            Container(
              width: context.width/2.5,
              margin: EdgeInsets.only(left: context.width/30,right: context.width /30),
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                  top: 5, bottom: 5, left: 5, right: 10),
              decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.all(
                      Radius.circular(38))),
              child: Row(children: [
                Container(

                    padding: EdgeInsets.only(
                        top: 13, bottom: 13, left: context.width/20, right: context.width/20),
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.all(Radius.circular(40))
                    ),
                    alignment: Alignment.center,
                    child: customSvg(name: heartFill,color: primary,width: context.width/20
                        ,height: context.width/20)),
                SizedBox(width: context.width / 50,),
                BlocBuilder<BlogDetailsCubit,BlogDetailsState>(
                  builder: (context, state) {
                    return context.read<BlogDetailsCubit>().loading == true ?
                    SpinKitPulse(color: primary,size: 30,) :

                      Text("${context.read<BlogDetailsCubit>().blogBySlugResponse!.data!.categoryName}",
                  style: TextStyles.textStyleBold12.copyWith(
                      fontWeight: FontWeight.w600
                      , color: white),
                  textScaler: TextScaler.linear(1.0),);
  },
)],),),
            SizedBox(height: context.height/40,),
            BlocBuilder<BlogDetailsCubit,BlogDetailsState>(
              builder: (context, state) {
                return context.read<BlogDetailsCubit>().loading == true ?
                    SpinKitPulse(color: primary,size: 30,) :
                  Container(
              margin: EdgeInsets.only(left: context.width/20,right: context.width/20),
              child: Text(context.read<BlogDetailsCubit>().blogBySlugResponse!.data!.title
                ,style:
              TextStyles.textStyleBold20.copyWith(color: primary,fontWeight: FontWeight.bold)
                ,textScaler: TextScaler.linear(1),),);
  },
),
            SizedBox(height: context.height/60,),
            BlocBuilder<BlogDetailsCubit,BlogDetailsState>(
  builder: (context, state) {
    return context.read<BlogDetailsCubit>().loading == true ?
    SpinKitPulse(color: primary,size: 30,) :
      
      Container(
              margin: EdgeInsets.only(left: context.width/30,right: context.width/30),
              child: Text(parse(context.read<BlogDetailsCubit>().blogBySlugResponse
                  !.data!.description).documentElement!.text,
                style: TextStyles.textStyleNormal12.copyWith(color: primary
                    ,fontWeight: FontWeight.w500),textScaler: TextScaler.linear(1),),);
  },
),
            SizedBox(height: context.height/20,),
            Container(
              margin: EdgeInsets.only(left: context.width/30,right: context.width/30),
              child: BlocBuilder<BlogDetailsCubit, BlogDetailsState>(
                builder: (context, state) {
                  return
                  context.read<BlogDetailsCubit>().loading == true ?
                      SpinKitPulse(color: primary,size: 30,) :
                    Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: NetWorkImageHandler(image: context.read<BlogDetailsCubit>().blogBySlugResponse
                    !.data!.authorImage.toString(), width: context.width/6
                        , height: context.width/6),),
                  SizedBox(width: context.width/30,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(context.read<BlogDetailsCubit>().blogBySlugResponse
                      !.data!.authorName,style: TextStyles.textStyleBold16
                          .copyWith(color: primary,fontWeight: FontWeight.bold,)
                        ,textScaler: TextScaler.linear(1),),
                      SizedBox(height: context.height/90,),
                      Text(context.read<BlogDetailsCubit>().blogBySlugResponse
                      !.data!.author ?? "",style: TextStyles.textStyleNormal14.copyWith(color: orangeBold,)
                        ,textScaler: TextScaler.linear(1),)],)],);
  },
),),
            SizedBox(height: context.height/30,),
            Container(
              margin: EdgeInsets.only(left: context.width/28,right: context.width/28),
              child: Text(tr("share"),style: TextStyles.textStyleBold16
                  .copyWith(color: primary,fontWeight: FontWeight.w600)
                ,textScaler: TextScaler.linear(1),),),
            SizedBox(height: context.height/50,),
            Container(
              margin: EdgeInsets.only(left: context.width/20,right: context.width/20),
              child: BlocBuilder<BlogDetailsCubit, BlogDetailsState>(
                builder: (context, state) {
    return context.read<BlogDetailsCubit>().socialLoading == true ?
         Center(child: SpinKitPulse(color: primary,size: 20,)) :

      Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap:(){
                     context.read<BlogDetailsCubit>()
                         .fetchUrl(url: context.read<BlogDetailsCubit>().socialMediaResponse!.data![6].url);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: orangeBold,
                          shape: BoxShape.circle),
                      child: customSvg(name: snap),),
                  ),
                  InkWell(
                    onTap:(){
                      context.read<BlogDetailsCubit>()
                          .fetchUrl(url: context.read<BlogDetailsCubit>().socialMediaResponse!.data![3].url);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: orangeBold,
                          shape: BoxShape.circle),
                      child: customSvg(name: linkdin),),
                  ),
                  InkWell(
                    onTap: (){
                      context.read<BlogDetailsCubit>()
                          .fetchUrl(url: context.read<BlogDetailsCubit>().socialMediaResponse!.data![5].url);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: orangeBold,
                          shape: BoxShape.circle),
                      child: customSvg(name: twitter),),
                  ),
                  InkWell(
                    onTap: (){
                     /* context.read<BlogDetailsCubit>()
                          .fetchUrl(url: context.read<BlogDetailsCubit>().socialMediaResponse!.data![3].url);*/
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: orangeBold,
                          shape: BoxShape.circle),
                      child: customSvg(name: tiktok),),
                  ),
                  InkWell(
                    onTap: (){
                      context.read<BlogDetailsCubit>()
                          .fetchUrl(url: context.read<BlogDetailsCubit>().socialMediaResponse!.data![2].url);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: orangeBold,
                          shape: BoxShape.circle),
                      child: customSvg(name: instagram),),
                  ),
                  InkWell(
                    onTap: (){
                      context.read<BlogDetailsCubit>()
                          .fetchUrl(url: context.read<BlogDetailsCubit>().socialMediaResponse!.data![0].url);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: orangeBold,
                          shape: BoxShape.circle),
                      child: customSvg(name: facebook),),
                  ),
                ],
              );
  },
),),
            SizedBox(height: context.height/18,),
            BlocBuilder<BlogDetailsCubit,BlogDetailsState>(
              builder: (context, state) {
                return context.read<BlogDetailsCubit>().loading == true ?
                     SpinKitPulse(color: primary,size: 30,) :
                  
                  DescriptionHeadTitle(title: "1. ${context.read<BlogDetailsCubit>()
                      .blogBySlugResponse!.data!.metaTitle}");
  },
),
            SizedBox(height: context.height/60,),
            BlocBuilder<BlogDetailsCubit,BlogDetailsState>(
              builder: (context, state) {
                return context.read<BlogDetailsCubit>().loading == true ?
                SpinKitPulse(color: primary,size: 30,) :

                  DescriptionContentItem(content: "${context.read<BlogDetailsCubit>()
                      .blogBySlugResponse!.data!.metaDescription}");
                },
),
            SizedBox(height: context.height/18,),
           
          /*  Container(
              margin: EdgeInsets.only(left: context.width/20,right: context.width/20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("You may also like !",style: TextStyles.textStyleBold20
                      .copyWith(color: primary,fontWeight: FontWeight.w800,overflow: TextOverflow.ellipsis)
                    ,textScaler: TextScaler.linear(1),maxLines: 1,),
                  Spacer(),
                  TextButton(
                    style: ButtonStyle(  padding: MaterialStateProperty.all<EdgeInsets>
                      (EdgeInsets.fromLTRB(0, 0, 0, 0)),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,),
                    onPressed: (){

                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("View All",style:
                        TextStyles.textStyleBold12.copyWith(color: grey1)
                          ,textScaler: TextScaler.linear(1),),

                        SizedBox(width: context.width/60,),
                        Container(
                            alignment: Alignment.center,
                            child: customSvg(name: raw))
                      ],),
                  )
                ],),),*/
            SizedBox(height: context.height/60,),
            //  BlogList(blogList: nursingArticlesList)




          ],
        ),
      ),
    );
  }
}