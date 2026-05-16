import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/widgets/reviews_student_list.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/widgets/success_stories_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewsScreen extends StatefulWidget {


  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
  
}

class _ReviewsScreenState extends State<ReviewsScreen> with SingleTickerProviderStateMixin{
  TabController? tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(widget: SizedBox(),title: "Our reviews",status: false,context: context),
      backgroundColor: white,
      body: Column(
        children: [
          TabBar(
            controller: tabController,
              labelPadding: EdgeInsets.zero,
              textScaler: TextScaler.linear(1),
              padding: EdgeInsets.only(left: context.width/50,right: context.width/50),
              labelStyle: TextStyles.textStyleBold12.copyWith(color: primary,fontWeight: FontWeight.w600),
              indicatorColor: primary,
              unselectedLabelStyle: TextStyles.textStyleBold12.copyWith(color: gre4,fontWeight: FontWeight.w600),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorAnimation: TabIndicatorAnimation.linear,
              physics: ClampingScrollPhysics(),
              tabs: [
                Tab(text: "Reviews Students",),
                Tab(text: "Success Stories",)]),
          Expanded(child: TabBarView(
              controller: tabController,
              children: [
                ReviewsStudentList(),
                SuccessStoriesList(),

              ]))
        ],
      ),
    );
  }
}