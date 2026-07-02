import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class CertificateItem extends StatelessWidget {
  final String title;
  final String date;
  final String? imageCertificate;
  final String? studentName;

  const CertificateItem({
    super.key,
    required this.title,
    required this.date,
    this.imageCertificate,
    this.studentName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: context.width / 60,
        left: context.width / 30,
        right: context.width / 30,
      ),
      padding: EdgeInsets.all(context.width / 20),
      decoration: BoxDecoration(
        color: accent,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        shape: BoxShape.rectangle,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: context.width / 25,
                  bottom: context.width / 25,
                  left: context.width / 32,
                  right: context.width / 32,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  color: white,
                  shape: BoxShape.rectangle,
                ),
                child: Text(
                  tr("completed"),
                  style: TextStyles.textStyleNormal10.copyWith(
                    fontWeight: FontWeight.w600,
                    color: primary,
                  ),
                  textScaler: TextScaler.linear(1),
                ),
              ),
              Spacer(),
              Container(
                alignment: Alignment.center,
                child: customSvg(name: share),
              ),
            ],
          ),
          SizedBox(height: context.height / 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                  top: context.width / 20,
                  bottom: context.width / 20,
                  left: context.width / 20,
                  right: context.width / 20,
                ),
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  shape: BoxShape.rectangle,
                ),
                child: customSvg(name: certificate, color: white),
              ),
              SizedBox(width: context.width / 40),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.toString(),
                      style: TextStyles.textStyleBold18.copyWith(
                        color: primary,
                        fontWeight: FontWeight.w800,
                      ),
                      textScaler: TextScaler.linear(1),
                    ),
                    SizedBox(height: context.height / 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          date.toString() == "null"
                              ? ""
                              : DateFormat(
                                  'd MMMM yyyy',
                                ).format(DateTime.parse(date.toString())),
                          style: TextStyles.textStyleNormal14.copyWith(
                            fontWeight: FontWeight.w500,
                            color: grey1,
                          ),
                          textScaler: TextScaler.linear(1),
                        ),
                        SizedBox(width: context.width / 50),
                        customSvg(name: elipse, color: white),
                        SizedBox(width: context.width / 50),
                        Text(
                          date.toString() == "null"
                              ? ""
                              : DateFormat(
                                  'hh:mm a',
                                ).format(DateTime.parse(date.toString())),
                          style: TextStyles.textStyleNormal14.copyWith(
                            fontWeight: FontWeight.w500,
                            color: grey1,
                          ),
                          textScaler: TextScaler.linear(1),
                        ),
                      ],
                    ),
                    // if (imageCertificate != null &&
                    //     imageCertificate!.isNotEmpty) ...[
                    //   SizedBox(height: context.height / 50),
                    //   ClipRRect(
                    //     borderRadius: BorderRadius.circular(12),
                    //     child: Stack(
                    //       alignment: Alignment.center,
                    //       children: [
                    //         NetWorkImageHandler(
                    //           image: imageCertificate!,
                    //           width: double.infinity,
                    //           height: context.height / 4,
                    //         ),
                    //         if (studentName != null && studentName!.isNotEmpty)
                    //           Positioned(
                    //             left: 0,
                    //             right: 0,
                    //             child: Text(
                    //               studentName!,
                    //               style: TextStyles.textStyleBold20.copyWith(
                    //                 color: primary,
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //               textAlign: TextAlign.center,
                    //             ),
                    //           ),
                    //       ],
                    //     ),
                    //   ),
                    // ],
                    SizedBox(height: context.height / 30),
                    InkWell(
                      onTap: () async {
                        if (imageCertificate != null &&
                            imageCertificate!.isNotEmpty) {
                          try {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(tr("loading"))),
                            );

                            final tempDir = await getTemporaryDirectory();
                            String ext = imageCertificate!.split('.').last;
                            if (ext.length > 4 ||
                                !ext.contains(RegExp(r'^[a-zA-Z]+$'))) {
                              ext = 'pdf';
                            }
                            final filePath =
                                '${tempDir.path}/certificate_${DateTime.now().millisecondsSinceEpoch}.$ext';

                            await Dio().download(imageCertificate!, filePath);

                            await Share.shareXFiles([
                              XFile(filePath),
                            ], text: tr("certificates"));
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Error downloading certificate"),
                              ),
                            );
                          }
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(context.width / 27),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          color: white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Download Certificate PDF",
                              style: TextStyles.textStyleNormal12.copyWith(
                                fontWeight: FontWeight.w600,
                                color: orangeBold,
                              ),
                              textScaler: TextScaler.linear(1),
                            ),
                            SizedBox(width: context.width / 40),
                            Container(
                              alignment: Alignment.center,
                              child: customSvg(name: upload3, color: primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
