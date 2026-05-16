import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/fonts.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SuccessfullDialogWidget extends StatelessWidget {
  const SuccessfullDialogWidget({super.key, required this.msg});
  final String msg;

  @override
  Widget build(BuildContext context) {
   return Center( // Centers the dialog on the screen
     child: SizedBox(
       width: context.width * 0.99,
       child: AlertDialog(
           backgroundColor: white,
           insetPadding: EdgeInsets.all(10),

           shape: RoundedRectangleBorder( // Use RoundedRectangleBorder for rounded corners
             borderRadius: BorderRadius.all(Radius.circular(58.0)), // Set your desired radius here
           ),
           alignment: Alignment.center,
           contentPadding: EdgeInsets.only(
               top: context.width/10,
               bottom: context.width/10,
               left: context.width/20
               ,right: context.width/20),
           content: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisSize: MainAxisSize.min,
             children: [
               Container(
                   alignment: Alignment.center,
                   child: customSvg(name: check)),
               SizedBox(height: context.height/40,),
               Text(tr("congrats_reset"),style: TextStyles
                   .textStyleBold22.copyWith(color: orangeBold
                   ,fontFamily: lamaSans,fontWeight: FontWeight.w800)
                 ,textScaler: TextScaler.linear(1),textAlign: TextAlign.center,),
               SizedBox(height: context.height/80,),
               Text(msg,style: TextStyles
                   .textStyleNormal14
                   .copyWith(color: primary,fontWeight: FontWeight.w600,fontFamily: lamaSans)
                 ,textScaler: TextScaler.linear(1),textAlign: TextAlign.center,),
               SizedBox(height: context.height/30,),
               MaterialButton(
                 color: orangeBold,
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
                   child: Text("Ok",style: TextStyles.textStyleBold14
                       .copyWith(color: white),textScaler: TextScaler.linear(1),softWrap: true,),
                   onPressed: (){
                     context.pushNamedAndRemoveUntil(name: loginSc);
                   })
             ],
           )
       ),
     ),
   );
  }

}