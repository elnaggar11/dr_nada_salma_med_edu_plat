import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/fonts.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/image_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/network_image_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/success_stories_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SuccessStoriesItem extends StatelessWidget {
  const SuccessStoriesItem({super.key,required this.data});

  final Data data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width/1.1,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(left: context.width/35,right: context.width/35
          ,top: context.width/60,bottom: context.width/60),
      decoration: BoxDecoration(
        color: greyLight,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        shape: BoxShape.rectangle),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: NetWorkImageHandler(image: data.user!.image,
                    width: context.width/8, height: context.width/8),),
              SizedBox(width: context.width/50,),
             Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(data.user!.fullName,style: TextStyles.textStyleBold10
                      .copyWith(color: primary,fontWeight: FontWeight.bold)
                      ,textScaler: TextScaler.linear(1),),
                  SizedBox(height: context.height/180,),
                    Text(data.courseName.toString(),style: TextStyles.textStyleNormal8
                        .copyWith(color: orange),textScaler: TextScaler.linear(1),),],),),


            Text(data.rating.toString(),style: TextStyles.textStyleBold12.copyWith(fontFamily: poppins
                  ,fontWeight: FontWeight.w600,color: primary),textScaler: TextScaler.linear(1),),
              SizedBox(width: context.width/60,),
              RatingBarIndicator(
                  rating: double.parse(data.rating),
                  itemSize: 15,
                  itemCount: 5,
                  itemBuilder: (context,index)=>customSvg(name: star
                      ,color: gold)),
              SizedBox(width: context.width/50,),
              Text("(${""})",style: TextStyles.textStyleNormal12.copyWith
                (color: grey1,fontWeight: FontWeight.w300)
                ,overflow: TextOverflow.ellipsis,textScaler: TextScaler.linear(1),)

            ],),

          SizedBox(height: context.height/60,),
          Text(data.courseName.toString(),style: TextStyles.textStyleBold14
              .copyWith(color: orangeBold),textScaler: TextScaler.linear(1),),
          SizedBox(height: context.height/150,),
          Text("${data.createdAt}",style: TextStyles.textStyleBold14
              .copyWith(color: orangeBold),textScaler: TextScaler.linear(1),),
          SizedBox(height: context.height/80,),
          Text("“${data.content}”",
            style: TextStyles.textStyleNormal12
              .copyWith(color: primary,fontWeight: FontWeight.w500),textScaler: TextScaler.linear(1),),
          SizedBox(height: context.height/30,),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${data.createdAt}",
                  style: TextStyles.textStyleNormal12
                      .copyWith(color: grey1,fontWeight: FontWeight.w500)
                  ,textScaler: TextScaler.linear(1),),
                Spacer(),
                customSvg(name: xsocial,width: context.width/20,height: context.width/20)
               ],),

        ],
      ),
    );
  }

}