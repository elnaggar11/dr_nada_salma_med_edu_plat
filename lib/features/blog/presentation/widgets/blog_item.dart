import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/network_image_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/entities/blog_details/blog_details_params.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class BlogItem extends StatelessWidget {
  final String img;
  final String title;
  final String description;
  final String metaDescription;
  final double width;
  final double height;
  final String slug;


  BlogItem({required this.img,required this.width,required this.height,
    required this.title, required this.description, required this.metaDescription,
    required this.slug});

  @override
  Widget build(BuildContext context) {
  return InkWell(
    onTap: (){
      context.pushNamed(name: blogDetails,args: BlogDetailsParams(slug: slug,title: title));
    },
    child: Container(
      margin: EdgeInsets.all(9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: NetWorkImageHandler(image: img, width: width, height: height),),
          SizedBox(width: context.width/40,),
          Flexible(
            fit: FlexFit.loose,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,style: TextStyles.textStyleNormal10.copyWith
                  (fontWeight: FontWeight.w600,color: primary),textScaler: TextScaler.linear(1),),
                SizedBox(height: context.height/80,),
                Text(parse(description).documentElement!.text,
                  style: TextStyles.textStyleBold12
                      .copyWith(fontWeight: FontWeight.w800,color: primary)
                  ,textScaler: TextScaler.linear(1),),
                SizedBox(height: context.height/60,),
                Text("“ $metaDescription"
                  ,style: TextStyles.textStyleNormal10
                      .copyWith(fontWeight: FontWeight.w500,color: primary),
                textScaler: TextScaler.linear(1),)
            ],),
          )
        ],
      ),
    ),
  );
  }

}