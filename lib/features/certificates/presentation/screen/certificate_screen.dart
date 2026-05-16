import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/certificates/presentation/widgets/certificate_item.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/certificates/certificates_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CertificateScreen extends StatefulWidget {
  const CertificateScreen({super.key});



  @override
  State<CertificateScreen> createState() => _CertificateScreenState();

}

class _CertificateScreenState extends State<CertificateScreen> {
  @override
  void initState() {
    context.read<CertificatesCubit>().getCertificates();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: customAppBar(
          appBarInd: 0,
          widget: SizedBox(),status: false,title: tr("certificates"),context: context,),
      body: SizedBox(
        child: BlocBuilder<CertificatesCubit,CertificatesState>(
  builder: (context, state) {
    return context.read<CertificatesCubit>().loading == true ?
        SpinKitPulse(color: primary,size: 50,) :
    context.read<CertificatesCubit>().certificateResponse!.data!.isEmpty ?
        Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  alignment: Alignment.center,
                  child: customSvg(name: certificate,color: primary
                      ,width: context.width/5,height: context.width/5)),
              SizedBox(height: context.height/60,),
              Text(tr("no_certificates"),style: TextStyles
                  .textStyleBold15.copyWith(color: primary,),textScaler: TextScaler.linear(1),)
            ],
          ),
        ):
      ListView.builder(
            itemCount: context.read<CertificatesCubit>().certificateResponse!.data!.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context,index)=>CertificateItem(
              title: context.read<CertificatesCubit>().certificateResponse!.data![index].title??""
              , date: context.read<CertificatesCubit>().certificateResponse!.data![index].issuedAt.toString(),));
  },
),
      ),
    );
  }
}