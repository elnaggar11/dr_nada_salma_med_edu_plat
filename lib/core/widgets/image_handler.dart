import 'package:flutter/cupertino.dart';

class ImageHandler extends StatelessWidget {
  final String image;
  final double width;
  final double height;

  const ImageHandler({super.key, required this.image, required this.width, required this.height});
  @override
  Widget build(BuildContext context) {
    return Image.asset(image,width: width,height: height
      ,alignment: Alignment.center,fit: BoxFit.cover,);
  }

}