import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/entities/blogs/categories_with_blog_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/presentation/widgets/blog_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogList extends StatelessWidget {
  final List<Blogs>? blogList;


  BlogList({required this.blogList,});

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
          itemCount: blogList!.length,
          padding: EdgeInsets.only(top: 0,left: context.width/38,right: context.width/38),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          addAutomaticKeepAlives: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context,index)=> BlogItem(img: blogList![index].image
              , width: context.width/4, height: context.width/4, title:  blogList![index].title
            , description:  blogList![index].description
            , metaDescription:  blogList![index].metaDescription, slug: blogList![index].slug.toString())
    );
  }

}