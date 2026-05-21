import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_text_field.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/fade_button.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/network_image_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/update_profile_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/profile/profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  final ProfileCubit profileCubit;

  const EditProfileScreen({super.key, required this.profileCubit});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    fullNameController.text =
        widget.profileCubit.profileResponse!.data!.fullName!;
    phoneNumberController.text =
        "${widget.profileCubit.profileResponse!.data!.phoneNumber ?? ""}";
    mailController.text = widget.profileCubit.profileResponse!.data!.email!;
    passwordController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      appBar: customAppBar(
        appBarInd: 0,
        widget: SizedBox(),
        title: tr("edit_profile_data"),
        status: false,
        context: context,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.height / 40),
              InkWell(
                onTap: () {
                  context.read<ProfileCubit>().pickImage();
                },
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    return Container(
                      margin: EdgeInsets.only(
                        left: context.width / 20,
                        right: context.width / 20,
                      ),
                      padding: EdgeInsets.all(context.width / 30),
                      decoration: BoxDecoration(
                        color: greyLight,
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        shape: BoxShape.rectangle,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          context.read<ProfileCubit>().img == null
                              ? Container(
                                  alignment: Alignment.center,
                                  child: ClipOval(
                                    child: NetWorkImageHandler(
                                      image: widget
                                          .profileCubit
                                          .profileResponse!
                                          .data!
                                          .image!,
                                      height: context.width / 4,
                                      width: context.width / 4,
                                    ),
                                  ),
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(context.width / 20),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipOval(
                                    child: Image.file(
                                      context.read<ProfileCubit>().img!,
                                      width: context.width / 4.4,
                                      height: context.width / 4.4,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                ),

                          SizedBox(height: context.height / 60),
                          Text(
                            tr("upload"),
                            style: TextStyles.textStyleNormal10.copyWith(
                              color: orangeBold,
                            ),
                            textScaler: TextScaler.linear(1),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: context.height / 60),
                          Text(
                            "Maximum size: 1MB. Supported formats: JPG, GIF, or PNG.",
                            style: TextStyles.textStyleNormal10.copyWith(
                              fontWeight: FontWeight.w500,
                              color: primary,
                            ),
                            textScaler: TextScaler.linear(1),
                          ),
                          SizedBox(height: context.height / 30),
                          Container(
                            alignment: Alignment.center,
                            child: customSvg(
                              name: upload2,
                              width: context.width / 6,
                              height: context.width / 6,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: context.height / 30),
              CustomTextField(
                controller: fullNameController,
                labelColor: black,
                obscure: false,
                validation: (String? val) {
                  if (val!.isEmpty) {
                    return "this field is required";
                  } else {
                    return null;
                  }
                },
                suffixIcon: Container(
                  width: context.width / 15,
                  margin: EdgeInsets.only(
                    left: context.width / 20,
                    right: context.width / 20,
                  ),
                  alignment: Alignment.center,
                  child: customSvg(
                    name: user,
                    width: context.width / 20,
                    height: context.width / 20,
                  ),
                ),
                prefixIcon: SizedBox(width: 0),
                labelTxt: tr("full_name"),
                hintText: tr("full_name"),
              ),
              SizedBox(height: context.height / 30),
              /*  Container(
                margin: EdgeInsets.only(left: context.width/30,right: context.width/30),
                child: IntlPhoneField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    prefix: VerticalDivider(
                        thickness: 1,
                        color:Colors.black

                    ),
                    label: RichText(
                        textScaler: TextScaler.linear(1.0),
                        textAlign: TextAlign.start,
                        text: TextSpan(children: [
                          TextSpan(text: tr( "phone_number"),style: TextStyles.textStyleBold12
                              .copyWith(color: black,fontWeight: FontWeight.w500)),
                          TextSpan(text: " *",style: TextStyles.textStyleBold13.copyWith(color: red)),
                        ])),
                    labelStyle: TextStyles.textStyleNormal13.copyWith(color: black),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(38)),
                      borderSide: BorderSide(color: black.withOpacity(.1)),),
                    errorStyle: TextStyles.textStyleNormal11.copyWith(color: grey1),
                    suffixIcon: Container(
                      width: context.width/25,
                      alignment: Alignment.center,
                      child: customSvg(name: call),),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(38)),
                      borderSide: BorderSide(color: black.withOpacity(.1)),),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(38)),
                      borderSide: BorderSide(color: black.withOpacity(.1)),),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(38)),
                      borderSide: BorderSide(color: black.withOpacity(.1)),),
                    focusedBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(38)),
                      borderSide: BorderSide(color: black.withOpacity(.1)),),
                    focusedErrorBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(38)),
                      borderSide: BorderSide(color: black.withOpacity(.1)),),

                  ),
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                ),),
              SizedBox(height: context.height/30,),*/
              CustomTextField(
                controller: mailController,
                validation: (String? val) {
                  if (val!.isEmpty) {
                    return tr("this_field_required");
                  } else {
                    return null;
                  }
                },
                labelColor: black,
                obscure: false,
                suffixIcon: Container(
                  width: context.width / 15,
                  margin: EdgeInsets.only(
                    left: context.width / 20,
                    right: context.width / 20,
                  ),
                  alignment: Alignment.center,
                  child: customSvg(
                    name: mail,
                    width: context.width / 20,
                    height: context.width / 20,
                  ),
                ),
                prefixIcon: SizedBox(width: 0),
                labelTxt: tr("email"),
                hintText: tr("enter_email"),
              ),
              SizedBox(height: context.height / 30),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return CustomTextField(
                    controller: passwordController,
                    labelColor: black,
                    obscure: context.read<ProfileCubit>().visibility,
                    suffixIcon: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () {
                        context.read<ProfileCubit>().updateVisibility(
                          visible: context.read<ProfileCubit>().visibility,
                        );
                      },
                      child: Container(
                        width: context.width / 15,
                        margin: EdgeInsets.only(
                          left: context.width / 20,
                          right: context.width / 20,
                        ),
                        alignment: Alignment.center,
                        child: context.read<ProfileCubit>().visibility == true
                            ? Icon(
                                Icons.visibility_off_outlined,
                                color: primary,
                                size: 20,
                              )
                            : Container(
                                alignment: Alignment.center,
                                child: customSvg(
                                  name: visible,
                                  width: context.width / 20,
                                  height: context.width / 20,
                                ),
                              ),
                      ),
                    ),
                    prefixIcon: SizedBox(width: 0),
                    labelTxt: tr("password"),
                    hintText: tr("enter_password"),
                  );
                },
              ),
              SizedBox(height: context.height / 15),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return FadeColorButton(
                    isLoading: context.read<ProfileCubit>().loading,
                    btnTitle: tr("save"),
                    buttonColor: primary,
                    onButtonPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<ProfileCubit>().updateProfile(
                          params: UpdateProfileParams(
                            fullName: fullNameController.text,
                            phoneNumber: phoneNumberController.text,
                            email: mailController.text,
                            password: passwordController.text,
                            img: context.read<ProfileCubit>().img,
                          ),
                        );
                      }
                    },
                    isPressed: false,
                  );
                },
              ),
              SizedBox(height: context.height / 30),
            ],
          ),
        ),
      ),
    );
  }
}
