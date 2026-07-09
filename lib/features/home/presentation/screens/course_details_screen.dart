import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/target_user.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/network_image_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/in_person_training_info_card.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_details_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/courses_details_cubit/courses_details_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/widgets/course_content_item.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/widgets/description_content_item.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/widgets/description_head_title_item.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/widgets/reviews_item.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/screens/pdf_viewer_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_details_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/widgets/course_booking_footer.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/widgets/course_booking_sheet.dart';

class CourseDetailsScreen extends StatefulWidget {
  const CourseDetailsScreen({super.key, required this.params});
  final CoursesDetailsParams params;

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  final box = navKey.currentContext!.findRenderObject() as RenderBox?;

  @override
  void initState() {
    context.read<CoursesDetailsCubit>().getCoursesDetails(
      params: CoursesDetailsParams(slug: widget.params.slug),
    );
    super.initState();
  }

  void _openWhatsAppCourseBooking(Data course) async {
    const phoneNumber = '+966556000986';

    final message = StringBuffer();
    message.writeln('السلام عليكم');
    message.writeln('أرغب في تأكيد حجز الكورس التالي بعد إتمام الدفع:');
    message.writeln('');
    message.writeln('اسم الكورس: ${course.title ?? ''}');
    message.writeln('السعر: ${course.price ?? ''} ${tr('sar')}');

    final whatsappUrl =
        "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message.toString())}";

    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(
        Uri.parse(whatsappUrl),
        mode: LaunchMode.externalApplication,
      );
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(tr("cannot_open_whatsapp"))));
      }
    }
  }

  void _showCourseBookingSheet(Data course) {
    final cubit = context.read<CoursesDetailsCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: CourseBookingSheet(
          course: course,
          onConfirmBooking: (String? couponCode) {
            Navigator.pop(context);
            if (course.courseStatus == 'pending') {
              _openWhatsAppCourseBooking(course);
            } else {
              cubit.requestCourseBooking(
                courseIds: [course.id!],
                couponCode: couponCode,
              );
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: customAppBar(
        appBarInd: 0,
        title: tr("course_details"),
        widget: InkWell(
          onTap: () {},
          child: InkWell(
            onTap: () async {
              await SharePlus.instance.share(
                ShareParams(
                  text: "share",
                  sharePositionOrigin:
                      box!.localToGlobal(Offset.zero) & box!.size,
                ),
              );
            },
            child: customSvg(name: share),
          ),
        ),
        status: true,
        context: context,
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: white,
        child: SingleChildScrollView(
          child: BlocConsumer<CoursesDetailsCubit, CoursesDetailsState>(
            listener: (context, state) {
              if (state is CourseBookingSuccessState) {
                msgKey.currentState?.showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                      style: TextStyles.textStyleNormal13.copyWith(
                        color: white,
                      ),
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
                final course = context
                    .read<CoursesDetailsCubit>()
                    .coursesDetailsResponse
                    ?.data;
                if (course != null) {
                  _openWhatsAppCourseBooking(course);
                }
              } else if (state is CourseBookingErrorState) {
                if (state.message.toLowerCase().contains("pending") || state.message.toLowerCase().contains("already requested")) {
                  final course = context.read<CoursesDetailsCubit>().coursesDetailsResponse?.data;
                  if (course != null) {
                    _openWhatsAppCourseBooking(course);
                  }
                } else {
                  msgKey.currentState?.showSnackBar(
                    SnackBar(
                      content: Text(
                        state.message,
                        style: TextStyles.textStyleNormal13.copyWith(
                          color: white,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            builder: (context, state) {
              final cubit = context.read<CoursesDetailsCubit>();
              if (cubit.coursesDetailsResponse == null ||
                  state is CoursesDetailsLoadingState ||
                  state is CoursesDetailsInitial) {
                if (state is CoursesDetailsErrorState) {
                  return Container(
                    width: context.width,
                    height: context.height,
                    color: white,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 60,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.message,
                          style: TextStyles.textStyleBold16.copyWith(
                            color: black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            context
                                .read<CoursesDetailsCubit>()
                                .getCoursesDetails(
                                  params: CoursesDetailsParams(
                                    slug: widget.params.slug,
                                  ),
                                );
                          },
                          child: Text(
                            tr("retry"),
                            style: TextStyles.textStyleBold14.copyWith(
                              color: white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container(
                  width: context.width,
                  height: context.height,
                  color: white,
                  child: SpinKitPulse(color: primary, size: 90),
                );
              }
              return Container(
                color: white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.height / 70),

                    Container(
                      margin: EdgeInsets.only(
                        left: context.width / 20,
                        right: context.width / 20,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        child: NetWorkImageHandler(
                          image: context
                              .read<CoursesDetailsCubit>()
                              .coursesDetailsResponse!
                              .data!
                              .image
                              .toString(),
                          width: double.infinity,
                          height: context.height / 3.5,
                        ),
                      ),
                    ),

                    SizedBox(height: context.height / 45),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: context.width / 20),
                          Container(
                            padding: EdgeInsets.only(
                              top: 8,
                              bottom: 8,
                              left: 5,
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                              color: accent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(38),
                              ),
                            ),
                            child: Row(
                              children: [
                                customSvg(name: pathology),
                                SizedBox(width: context.width / 50),

                                Text(
                                  "${context.read<CoursesDetailsCubit>().coursesDetailsResponse!.data!.categoryName}",
                                  style: TextStyles.textStyleBold10.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: primary,
                                  ),
                                  textScaler: TextScaler.linear(1.0),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: context.width / 40),
                          Container(
                            padding: EdgeInsets.only(
                              top: 8,
                              bottom: 8,
                              left: 5,
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                              color: accent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(38),
                              ),
                            ),
                            child: Row(
                              children: [
                                customSvg(name: time),
                                SizedBox(width: context.width / 50),
                                Text(
                                  "${context.read<CoursesDetailsCubit>().coursesDetailsResponse!.data!.totalHours}",
                                  style: TextStyles.textStyleBold10.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: primary,
                                  ),
                                  textScaler: TextScaler.linear(1.0),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: context.width / 20),
                        ],
                      ),
                    ),
                    if (isTargetUser(context)) ...[
                      SizedBox(height: context.height / 40),
                      const InPersonTrainingInfoCard(),
                    ],
                    SizedBox(height: context.height / 40),
                    Container(
                      margin: EdgeInsets.only(
                        left: context.width / 20,
                        right: context.width / 20,
                      ),
                      child: Text(
                        "${context.read<CoursesDetailsCubit>().coursesDetailsResponse!.data!.title} ",
                        style: TextStyles.textStyleBold24.copyWith(
                          color: orangeBold,
                          fontWeight: FontWeight.bold,
                        ),
                        textScaler: TextScaler.linear(1.0),
                      ),
                    ),
                    SizedBox(height: context.height / 80),

                    Container(
                      margin: EdgeInsets.only(
                        left: context.width / 20,
                        right: context.width / 20,
                      ),
                      child: Text(
                        "– ${context.read<CoursesDetailsCubit>().coursesDetailsResponse!.data!.totalHours} Hours",
                        style: TextStyles.textStyleBold24.copyWith(
                          color: orangeBold,
                          fontWeight: FontWeight.bold,
                        ),
                        textScaler: TextScaler.linear(1.0),
                      ),
                    ),
                    if (context
                                .read<CoursesDetailsCubit>()
                                .coursesDetailsResponse
                                ?.data
                                ?.courseLectureStartsAt !=
                            null &&
                        context
                                .read<CoursesDetailsCubit>()
                                .coursesDetailsResponse
                                ?.data
                                ?.lecturesAreOpen ==
                            false) ...[
                      SizedBox(height: context.height / 50),
                      Container(
                        margin: EdgeInsets.only(
                          left: context.width / 20,
                          right: context.width / 20,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: orangeBold.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: orangeBold),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: orangeBold,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "يبدأ في: ${context.read<CoursesDetailsCubit>().coursesDetailsResponse!.data!.courseLectureStartsAt}",
                              style: TextStyles.textStyleBold14.copyWith(
                                color: orangeBold,
                                fontWeight: FontWeight.bold,
                              ),
                              textScaler: TextScaler.linear(1.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                    SizedBox(height: context.height / 50),

                    Container(
                      margin: EdgeInsets.only(
                        left: context.width / 20,
                        right: context.width / 20,
                      ),
                      child: Text(
                        context
                            .read<CoursesDetailsCubit>()
                            .coursesDetailsResponse!
                            .data!
                            .semiDescription!,
                        style: TextStyles.textStyleNormal12.copyWith(
                          color: black,
                          fontWeight: FontWeight.w500,
                        ),
                        textScaler: TextScaler.linear(1.0),
                      ),
                    ),
                    SizedBox(height: context.height / 40),
                    Container(
                      margin: EdgeInsets.only(
                        left: context.width / 30,
                        right: context.width / 30,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${context.read<CoursesDetailsCubit>().coursesDetailsResponse!.data!.averageRating}",
                            style: TextStyles.textStyleBold16.copyWith(
                              fontWeight: FontWeight.w800,
                              color: primary,
                            ),
                            textScaler: TextScaler.linear(1),
                          ),
                          SizedBox(width: context.width / 40),
                          RatingBarIndicator(
                            itemCount: 5,
                            rating:
                                double.tryParse(
                                  context
                                          .read<CoursesDetailsCubit>()
                                          .coursesDetailsResponse!
                                          .data!
                                          .averageRating
                                          ?.toString() ??
                                      '0.0',
                                ) ??
                                0.0,
                            itemPadding: EdgeInsets.only(left: 3, right: 3),
                            itemSize: 15,
                            itemBuilder: (context, index) =>
                                customSvg(name: star, color: gold),
                          ),
                          SizedBox(width: context.width / 40),
                          Text(
                            "${context.read<CoursesDetailsCubit>().coursesDetailsResponse!.data!.reviewsCount ?? 0} students",
                            style: TextStyles.textStyleBold14.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                            textScaler: TextScaler.linear(1),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.height / 60),
                    Container(
                      margin: EdgeInsets.only(
                        left: context.width / 30,
                        right: context.width / 30,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /*   Text("\$${context.read<CoursesDetailsCubit>().coursesDetailsResponse!.data!.priceAfterDiscount??""}"
                        ,style: TextStyles.textStyleBold24
                          .copyWith(fontWeight: FontWeight.w800,color: orangeBold)
                        ,textScaler: TextScaler.linear(1),),
                      SizedBox(width: context.width/30,),
                      Text("\$${context.read<CoursesDetailsCubit>().coursesDetailsResponse!.data!.price??""}"
                        ,style: TextStyles.textStyleNormal12
                          .copyWith(fontWeight: FontWeight.w500,color: grey1)
                        ,textScaler: TextScaler.linear(1),)*/
                        ],
                      ),
                    ),

                    SizedBox(height: context.height / 20),
                    Container(
                      margin: EdgeInsets.only(
                        left: context.width / 30,
                        right: context.width / 30,
                      ),
                      child: Text(
                        tr("course_content"),
                        style: TextStyles.textStyleBold32.copyWith(
                          color: orangeBold,
                        ),
                        textScaler: TextScaler.linear(1),
                      ),
                    ),
                    SizedBox(height: context.height / 35),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        left: context.width / 30,
                        right: context.width / 30,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              " ${tr("sections")}",
                              style: TextStyles.textStyleBold14.copyWith(
                                fontWeight: FontWeight.w600,
                                color: primary,
                              ),
                              textScaler: TextScaler.linear(1),
                            ),
                            SizedBox(width: context.width / 30),
                            customSvg(name: elipse),
                            SizedBox(width: context.width / 30),
                            Text(
                              "${context.read<CoursesDetailsCubit>().coursesDetailsResponse!.data!.contents!.length} ${tr("lectures")}",
                              style: TextStyles.textStyleBold14.copyWith(
                                fontWeight: FontWeight.w600,
                                color: primary,
                              ),
                              textScaler: TextScaler.linear(1),
                            ),
                            SizedBox(width: context.width / 30),
                            customSvg(name: elipse),
                            SizedBox(width: context.width / 30),
                            Text(
                              "${context.read<CoursesDetailsCubit>().totalTime} ${tr("minutes")}",
                              style: TextStyles.textStyleBold14.copyWith(
                                fontWeight: FontWeight.w600,
                                color: primary,
                              ),
                              textScaler: TextScaler.linear(1),
                            ),
                            SizedBox(width: context.width / 30),
                            customSvg(name: elipse),
                            SizedBox(width: context.width / 30),
                            InkWell(
                              onTap: () {
                                final isBooked = context
                                        .read<CoursesDetailsCubit>()
                                        .coursesDetailsResponse
                                        ?.data
                                        ?.isBooked ==
                                    true;

                                if (!isBooked) {
                                  msgKey.currentState?.showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(40),
                                        ),
                                      ),
                                      content: Text(
                                        "يجب الاشتراك في الكورس أولاً",
                                        style: TextStyles.textStyleNormal13
                                            .copyWith(color: white),
                                        textScaler: TextScaler.linear(1),
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }

                                final hasPdf =
                                    context
                                        .read<CoursesDetailsCubit>()
                                        .coursesDetailsResponse
                                        ?.data
                                        ?.hasPdf ==
                                    true;
                                final pdfUrl = context
                                    .read<CoursesDetailsCubit>()
                                    .coursesDetailsResponse
                                    ?.data
                                    ?.pdf;

                                if (!hasPdf ||
                                    pdfUrl == null ||
                                    pdfUrl.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        tr("pdf_not_available"),
                                        style: TextStyles.textStyleNormal13
                                            .copyWith(color: white),
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PdfViewerScreen(
                                      pdfUrl: pdfUrl,
                                      title: tr("course_content"),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.width / 40,
                                  vertical: context.height / 150,
                                ),
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: primary.withValues(alpha: .2),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.picture_as_pdf,
                                      color: Colors.red,
                                      size: 16,
                                    ),
                                    SizedBox(width: context.width / 80),
                                    Text(
                                      tr("course_content"),
                                      style: TextStyles.textStyleNormal12
                                          .copyWith(
                                            color: primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: context.height / 25),
                    SizedBox(
                      child: ListView.builder(
                        itemCount: context
                            .read<CoursesDetailsCubit>()
                            .coursesDetailsResponse!
                            .data!
                            .contents!
                            .length,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                          left: context.width / 80,
                          right: context.width / 80,
                        ),
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => CourseContentItem(
                          title: context
                              .read<CoursesDetailsCubit>()
                              .coursesDetailsResponse!
                              .data!
                              .contents![index]
                              .title!,
                          lecture: context
                              .read<CoursesDetailsCubit>()
                              .coursesDetailsResponse!
                              .data!
                              .contents![index]
                              .lectures!,
                          time: context
                              .read<CoursesDetailsCubit>()
                              .coursesDetailsResponse!
                              .data!
                              .contents![index]
                              .totalTime!,
                          courseId: context
                              .read<CoursesDetailsCubit>()
                              .coursesDetailsResponse!
                              .data!
                              .id
                              .toString(),
                          canWatch:
                              context
                                  .read<CoursesDetailsCubit>()
                                  .coursesDetailsResponse!
                                  .data!
                                  .canWatchCourse ??
                              false,
                          lecturesAreOpen:
                              context
                                  .read<CoursesDetailsCubit>()
                                  .coursesDetailsResponse!
                                  .data!
                                  .lecturesAreOpen ??
                              false,
                          isBooked:
                              context
                                  .read<CoursesDetailsCubit>()
                                  .coursesDetailsResponse!
                                  .data!
                                  .isBooked ==
                              true,
                          courseLectureStartsAt:
                              context
                                  .read<CoursesDetailsCubit>()
                                  .coursesDetailsResponse!
                                  .data!
                                  .courseLectureStartsAt,
                        ),
                      ),
                    ),
                    SizedBox(height: context.height / 40),
                    Container(
                      margin: EdgeInsets.only(
                        left: context.width / 22,
                        right: context.width / 22,
                      ),
                      child: Text(
                        tr("description"),
                        style: TextStyles.textStyleBold32.copyWith(
                          color: orangeBold,
                        ),
                        textScaler: TextScaler.linear(1),
                      ),
                    ),

                    SizedBox(height: context.height / 20),
                    DescriptionHeadTitle(
                      title: context
                          .read<CoursesDetailsCubit>()
                          .coursesDetailsResponse!
                          .data!
                          .semiDescription!,
                    ),
                    SizedBox(height: context.height / 60),

                    DescriptionContentItem(
                      content: context
                          .read<CoursesDetailsCubit>()
                          .coursesDetailsResponse!
                          .data!
                          .longDescription!,
                    ),

                    SizedBox(height: context.height / 20),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(color: orange),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: context.height / 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: context.width / 20),
                              Text(
                                tr("reviews_student"),
                                style: TextStyles.textStyleBold20.copyWith(
                                  color: white,
                                  fontWeight: FontWeight.w800,
                                ),
                                textScaler: TextScaler.linear(1),
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Text(
                                    tr("view_all"),
                                    style: TextStyles.textStyleNormal12
                                        .copyWith(
                                          color: white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                    textScaler: TextScaler.linear(1),
                                  ),
                                  SizedBox(width: context.width / 50),
                                  customSvg(
                                    name: arrow,
                                    color: greyLight,
                                    width: context.width / 40,
                                    height: context.width / 40,
                                  ),
                                ],
                              ),
                              SizedBox(width: context.width / 20),
                            ],
                          ),
                          SizedBox(height: context.height / 20),

                          context
                                      .read<CoursesDetailsCubit>()
                                      .coursesDetailsResponse!
                                      .data!
                                      .reviews ==
                                  null
                              ? Container(
                                  color: Colors.transparent,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      customSvg(name: review, color: white),
                                      SizedBox(height: context.height / 60),
                                      Text(
                                        tr("no_reviews"),
                                        style: TextStyles.textStyleBold13
                                            .copyWith(color: white),
                                        textScaler: TextScaler.linear(1),
                                      ),
                                      SizedBox(height: context.height / 5),
                                    ],
                                  ),
                                )
                              : context
                                    .read<CoursesDetailsCubit>()
                                    .coursesDetailsResponse!
                                    .data!
                                    .reviews!
                                    .isEmpty
                              ? Container(
                                  color: Colors.transparent,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      customSvg(name: review, color: white),
                                      SizedBox(height: context.height / 60),
                                      Text(
                                        tr("no_reviews"),
                                        style: TextStyles.textStyleBold13
                                            .copyWith(color: white),
                                        textScaler: TextScaler.linear(1),
                                      ),
                                      SizedBox(height: context.height / 5),
                                    ],
                                  ),
                                )
                              : SizedBox(
                                  child: ListView.builder(
                                    itemCount: context
                                        .read<CoursesDetailsCubit>()
                                        .coursesDetailsResponse!
                                        .data!
                                        .reviews!
                                        .length,
                                    padding: EdgeInsets.only(top: 0),
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) =>
                                        ReviewsItem(
                                          image: context
                                              .read<CoursesDetailsCubit>()
                                              .coursesDetailsResponse!
                                              .data!
                                              .reviews![index]
                                              .user!
                                              .image,
                                          description:
                                              context
                                                  .read<CoursesDetailsCubit>()
                                                  .coursesDetailsResponse!
                                                  .data!
                                                  .reviews![index]
                                                  .content ??
                                              "No content found",
                                          name: context
                                              .read<CoursesDetailsCubit>()
                                              .coursesDetailsResponse!
                                              .data!
                                              .reviews![index]
                                              .user!
                                              .fullName
                                              .toString(),
                                          specialist: "",
                                          rating: context
                                              .read<CoursesDetailsCubit>()
                                              .coursesDetailsResponse!
                                              .data!
                                              .reviews![index]
                                              .rating,
                                        ),
                                  ),
                                ),
                          SizedBox(height: context.height / 6),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      // bottomSheet:/* BlocBuilder<CoursesDetailsCubit, CoursesDetailsState>(
      /*   builder: (context, state) {
    return context.read<CoursesDetailsCubit>().loading == true ?
    Container(
        color: white,
        width: double.infinity,
        height: double.infinity,
        child: SpinKitPulse(color: primary,size: 100,)) :

      Container(
        color: white,
        padding: EdgeInsets.only(top: context.width/40,bottom: context.width/40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            context.read<CoursesDetailsCubit>().loading == true ?
                Container(
                    alignment: Alignment.center,
                    child: SpinKitPulse(color: primary,size: 100,)) :
            context.read<CoursesDetailsCubit>().coursesDetailsResponse!.data!.buttonActions!.addToCart == true ?
           BlocBuilder<CartCubit, CartState>(
             builder: (context, state) {
                      .addToCart(params:
                  AddToCartParams(courseId: context.read<CoursesDetailsCubit>().courseId));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Text(tr("add_to_cart"),style: TextStyles.textStyleBold12
                      .copyWith(color: black,fontWeight: FontWeight.w700)
                    ,textScaler: TextScaler.linear(1),),
                  Spacer(),
                  (context.read<CartCubit>().addCartLoading == true &&  context.read<CartCubit>().cartInd == 1) ?
                      SpinKitFadingCircle(color: white,size: 20,) :
                  Container(
                    padding: EdgeInsets.all(context.width/40),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: white,
                      shape: BoxShape.circle,),
                    child: customSvg(name: card1),
                  )
                ],),),
            );},) : SizedBox(),
            Container(
              padding: EdgeInsets.only(top: 20,bottom: 20),
              color: white,
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: context.width/20,),
                  Expanded(
                    child:
                    context.read<CoursesDetailsCubit>().loading == true ?
                    SpinKitPulse(color: primary,size: 20,) :
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${context.read<CoursesDetailsCubit>().coursesDetailsResponse!.data!.price} ${tr('sar')}"
                          ,style: TextStyles.textStyleBold22
                            .copyWith(color: orangeBold,
                            fontWeight: FontWeight.w800),textScaler: TextScaler.linear(1),),
                        context.read<CoursesDetailsCubit>().coursesDetailsResponse!
                            .data!.priceAfterDiscount == null? SizedBox() :
                        Text("${context.read<CoursesDetailsCubit>().coursesDetailsResponse!
                            .data!.priceAfterDiscount ?? ""} ${tr('sar')}",style: TextStyles.textStyleNormal12.copyWith(color: grey1
                            ,fontWeight: FontWeight.w500),textScaler: TextScaler.linear(1),)],),
                  ),
                  SizedBox(width: context.width/20,),

            context.read<CoursesDetailsCubit>().coursesDetailsResponse!.data!.buttonActions!.enrollNow == true ?
            BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      return Expanded(
                        child: MaterialButton(
            padding: EdgeInsets.only(top: 18.5,bottom: 18.5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius
                .all(Radius.circular(40))),
            color: primary,
            onPressed: (){
              context.read<CartCubit>().setCartIndex(ind: 0);
              context.read<CartCubit>()
                  .addToCart(params:
              AddToCartParams(courseId:  context.read<CoursesDetailsCubit>().courseId)).then((val){

                context.read<CartCubit>().getSummary().then((val){
                  context.pushNamed(name: paymentSc,args: OrderParams(
                      totalPricePoints:  context.read<CartCubit>().summaryResponse!
                          .data!.totalPricePoints.toString(),
                      totalItems: context.read<CartCubit>().summaryResponse!
                          .data!.totalItem.toString(),
                      serviceFees:  context.read<CartCubit>().summaryResponse!
                          .data!.serviceFees.toString(),
                      userPoints:  context.read<CartCubit>().summaryResponse!
                          .data!.userMyPoints.toString(),
                      total:  context.read<CartCubit>().summaryResponse!
                          .data!.total.toString(),
                      tax:  context.read<CartCubit>().summaryResponse!
                          .data!.tax.toString(),
                      courseId: [CoursesIds(courseId:  context.read<CoursesDetailsCubit>()
                          .coursesDetailsResponse!.data!.id)],
                      winPoints: context.read<CartCubit>().summaryResponse!
                          .data!.winPoints.toString()));
                });
              });




            },
            child: (context.read<CartCubit>().addCartLoading == true && context.read<CartCubit>().cartInd == 0 ) ?
            SpinKitFadingCircle(color: white,size: 20,) :
            Text(tr("buy_now"),style: TextStyles.textStyleBold14
                .copyWith(color: white),textScaler: TextScaler.linear(1),),),
        );},) : SizedBox(),
                  SizedBox(width: context.width/20,)
                ],
              ),
            ),
          ],),);
  },
)*/
      bottomNavigationBar:
          BlocBuilder<CoursesDetailsCubit, CoursesDetailsState>(
            builder: (context, state) {
              final cubit = context.read<CoursesDetailsCubit>();
              final response = cubit.coursesDetailsResponse;

              if (response == null ||
                  cubit.loading == true ||
                  state is CoursesDetailsLoadingState ||
                  state is CoursesDetailsInitial) {
                return const SizedBox.shrink();
              }

              final courseData = response.data;
              if (courseData == null) return const SizedBox.shrink();

              final isEnded =
                  courseData.isEnded == true ||
                  courseData.courseStatus == 'ended';
              final canEnroll =
                  (courseData.buttonActions?.enrollNow == true || courseData.courseStatus == 'pending') && !isEnded;

              if (!canEnroll) {
                return const SizedBox.shrink();
              }

              return CourseBookingFooter(
                price: courseData.price?.toString() ?? "0",
                priceAfterDiscount: courseData.priceAfterDiscount?.toString(),
                onBookPressed: () => _showCourseBookingSheet(courseData),
              );
            },
          ),
    );
  }
}
