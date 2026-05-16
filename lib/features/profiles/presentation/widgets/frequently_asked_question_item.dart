import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/faqs_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/frequently_cubit/frequently_asked_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FrequentlyAskedQuestionItem extends StatelessWidget {
  const FrequentlyAskedQuestionItem({super.key, required this.controller, required this.index
    , required this.faqsData});
  final ExpansibleController controller;
  final int index;
  final Data faqsData;

  @override
  Widget build(BuildContext context) {
    return   Container(
      margin: EdgeInsets.only(left: context.width/20,right: context.width/20
          ,top: context.width/80,bottom: context.width/80),
      child: ExpansionTile(
              backgroundColor: greyLight,
              collapsedBackgroundColor: greyLight,
              controller: controller,
              showTrailingIcon: false,
              collapsedShape: OutlineInputBorder(borderSide: BorderSide(color: white),borderRadius: BorderRadius
                  .all(Radius.circular(40))),
              dense: true,
              maintainState: true,
              shape: OutlineInputBorder(borderSide: BorderSide(color: white),borderRadius: BorderRadius
                  .all(Radius.circular(40))),
              expandedAlignment: Alignment.bottomCenter,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.center,
                      child: customSvg(name: plus)),
                  SizedBox(width: context.width/20,),
                  Expanded(
                    child: Text(faqsData.question!,style: TextStyles.textStyleNormal14
                        .copyWith(color: primary,fontWeight: FontWeight.w600)
                      ,textScaler: TextScaler.linear(1),),
                  ),
                  InkWell(
                    onTap: (){
                     context.read<FrequentlyAskedCubit>().updateExpand(ind: index,controller: controller);
                    },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(context.width/26),
                    decoration: BoxDecoration(
                        color: controller.isExpanded ? orange : orangeBold,shape: BoxShape.circle),
                    child: controller.isExpanded ?
                    customSvg(name: arrowUp,color: white) :
                    customSvg(name: down,color: white),
                  ),)
                ],
              ),

              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      top: context.width/28,
                      bottom: context.width/20,
                      left: context.width/14,right: context.width/14),
                  child: Text(faqsData.answer!
                  ,style: TextStyles.textStyleNormal14.copyWith(color: orangeBold)
                    ,textScaler: TextScaler.linear(1),),
                )
              ],
            ),
    );
  }

}