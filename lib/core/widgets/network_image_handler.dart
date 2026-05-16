import 'package:cached_network_image/cached_network_image.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NetWorkImageHandler extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  const NetWorkImageHandler({super.key, required this.image, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      alignment: Alignment.center,
      width: width,
      height: height,
      errorListener: (val){
        debugPrint('Image load error: $val');
      },
      errorWidget: (context,string,object)=>Container(
        alignment: Alignment.center,
          padding: EdgeInsets.all(context.width/25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border:Border.all(color: primary)
          ),
          child: Icon(Icons.error_outline,color: primary,size: 60,)),
      placeholder: (context,s)=> SpinKitPulse(size: 50,color: primary,),
      imageUrl: image??"",fit: BoxFit.cover,);
  }

}