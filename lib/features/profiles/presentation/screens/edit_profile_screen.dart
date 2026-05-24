import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_text_field.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/network_image_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/update_profile_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/profile/profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/const.dart';

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
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController alternativeController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  
  // Teacher controllers
  final TextEditingController shortBioController = TextEditingController();

  int? selectedSpecialtyId;
  int? selectedDegreeId;

  String? selectedSpecialty = "Nursing";
  String? selectedDegree = "Bachelor";

  bool isSpecialtyOpen = false;
  bool isDegreeOpen = false;

  final List<String> specialtiesList = ["Nursing", "Biology", "Chemistry"];
  final List<String> degreesList = ["Bachelor", "Master", "PhD"];

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    final data = widget.profileCubit.profileResponse?.data;
    fullNameController.text = data?.fullName?.toString() ?? "";
    phoneNumberController.text = data?.phoneNumber?.toString() ?? "";
    mailController.text = data?.email?.toString() ?? "";
    passwordController.text = "";

    if (Const.isTeacher) {
      whatsappController.text = ""; // Need WhatsApp from API if available
      alternativeController.text =
          data?.countryCode?.toString() ?? ""; // Placeholder or check API
      bioController.text = data?.shortBio?.toString() ?? ""; // Need Bio from API if available
      
      shortBioController.text = data?.shortBio?.toString() ?? "";
      
      if (data?.specializationTitle != null) {
        selectedSpecialty = data?.specializationTitle?.toString();
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF9F9F9,
      ), // Light background from screenshot
      resizeToAvoidBottomInset: true,
      appBar: customAppBar(
        appBarInd: 0,
        widget: SizedBox(),
        title: tr("edit_profile_data"),
        status: false,
        context: context,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: context.width / 25),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: context.height / 40),

              // 1. Profile Header Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Details Column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tr("personal_data"),
                                style: TextStyles.textStyleBold16.copyWith(
                                  color: orangeBold,
                                ),
                              ),
                              Text(
                                tr("personal_data_desc"),
                                style: TextStyles.textStyleNormal11.copyWith(
                                  color: grey2,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                fullNameController.text.isNotEmpty
                                    ? fullNameController.text
                                    : tr("full_name"),
                                style: TextStyles.textStyleBold18.copyWith(
                                  color: primary,
                                ),
                              ),
                              Text(
                                Const.isTeacher
                                    ? (selectedDegreeId != null
                                          ? "Bachelor"
                                          : tr("academic_instructor"))
                                    : tr("academic_student"),
                                style: TextStyles.textStyleBold13.copyWith(
                                  color: orangeBold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                tr("max_size_allowed_desc"),
                                style: TextStyles.textStyleNormal10.copyWith(
                                  color: grey2,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Profile Image with border
                        BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, state) {
                            return Container(
                              width: 80,
                              height: 80,
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: orangeBold, width: 2),
                              ),
                              child: ClipOval(
                                child: context.read<ProfileCubit>().img != null
                                    ? Image.file(
                                        context.read<ProfileCubit>().img!,
                                        fit: BoxFit.cover,
                                      )
                                    : NetWorkImageHandler(
                                        image:
                                            widget
                                                .profileCubit
                                                .profileResponse
                                                ?.data
                                                ?.image ??
                                            "",
                                        height: 80,
                                        width: 80,
                                      ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () =>
                                context.read<ProfileCubit>().pickImage(),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cloud_upload_outlined,
                                    color: white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    tr("change_image"),
                                    style: TextStyles.textStyleBold12.copyWith(
                                      color: white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr("basic_data"),
                      style: TextStyles.textStyleBold16.copyWith(
                        color: orangeBold,
                      ),
                    ),
                    SizedBox(height: 16),

                    CustomTextField(
                      controller: fullNameController,
                      labelColor: primary,
                      obscure: false,
                      validation: (val) =>
                          val!.isEmpty ? tr("this_field_required") : null,
                      suffixIcon: _buildFieldIcon(Icons.person_outline),
                      labelTxt: tr("full_name"),
                      hintText: tr("full_name"),
                    ),
                    SizedBox(height: 16),

                    CustomTextField(
                      controller: phoneNumberController,
                      labelColor: primary,
                      obscure: false,
                      validation: (val) =>
                          val!.isEmpty ? tr("this_field_required") : null,
                      suffixIcon: _buildFieldIcon(Icons.phone_outlined),
                      labelTxt: tr("phone_number"),
                      hintText: "966500000000+",
                    ),
                    SizedBox(height: 16),

                    CustomTextField(
                      controller: mailController,
                      labelColor: primary,
                      obscure: false,
                      validation: (val) =>
                          val!.isEmpty ? tr("this_field_required") : null,
                      suffixIcon: _buildFieldIcon(Icons.email_outlined),
                      labelTxt: tr("email"),
                      hintText: tr("enter_email"),
                    ),

                    if (Const.isTeacher) ...[
                      SizedBox(height: 16),
                      CustomTextField(
                        controller: whatsappController,
                        labelColor: primary,
                        obscure: false,
                        validation: (val) =>
                            val!.isEmpty ? tr("this_field_required") : null,
                        labelTxt: tr("whatsapp_required"),
                        hintText: "966500000000+",
                      ),
                    ],
                  ],
                ),
              ),

              SizedBox(height: 20),

              if (Const.isTeacher) ...[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        controller: alternativeController,
                        labelColor: primary,
                        obscure: false,
                        labelTxt: tr("alternative_contact"),
                        hintText: "01112345678",
                      ),
                      SizedBox(height: 16),
                      BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          return CustomTextField(
                            controller: passwordController,
                            labelColor: primary,
                            obscure: context.read<ProfileCubit>().visibility,
                            suffixIcon: InkWell(
                              onTap: () =>
                                  context.read<ProfileCubit>().updateVisibility(
                                    visible: context
                                        .read<ProfileCubit>()
                                        .visibility,
                                  ),
                              child: Icon(
                                context.read<ProfileCubit>().visibility
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: primary,
                                size: 20,
                              ),
                            ),
                            labelTxt: tr("password"),
                            hintText: tr("enter_password_edit"),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Specialty
                      _buildDropdownField(
                        label: tr("speciality"),
                        value: selectedSpecialty ?? "Nursing",
                        isOpen: isSpecialtyOpen,
                        items: specialtiesList,
                        isRequired: true,
                        onToggle: () {
                          setState(() {
                            isSpecialtyOpen = !isSpecialtyOpen;
                            isDegreeOpen = false;
                          });
                        },
                        onSelect: (val) {
                          setState(() {
                            selectedSpecialty = val;
                            isSpecialtyOpen = false;
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      // Academic Degree
                      _buildDropdownField(
                        label: tr("academic_degree"),
                        value: selectedDegree ?? "Bachelor",
                        isOpen: isDegreeOpen,
                        items: degreesList,
                        isRequired: true,
                        onToggle: () {
                          setState(() {
                            isDegreeOpen = !isDegreeOpen;
                            isSpecialtyOpen = false;
                          });
                        },
                        onSelect: (val) {
                          setState(() {
                            selectedDegree = val;
                            isDegreeOpen = false;
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      _buildTextArea(
                        controller: shortBioController,
                        label: tr("short_bio"),
                        isRequired: true,
                        hint: tr("short_bio_hint"),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),
              ],

              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<ProfileCubit>().updateProfile(
                            params: UpdateProfileParams(
                              fullName: fullNameController.text,
                              phoneNumber: phoneNumberController.text,
                              email: mailController.text,
                              password: passwordController.text,
                              img: context.read<ProfileCubit>().img,
                              shortBio: Const.isTeacher ? shortBioController.text : null,
                              specializationTitle: Const.isTeacher ? selectedSpecialty : null,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF00ADB5).withOpacity(0.3),
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tr("update_btn"),
                            style: TextStyles.textStyleBold16.copyWith(
                              color: primary,
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primary,
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: white,
                            ),
                          ),
                        ],
                      ),
                    ),
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

  Widget _buildFieldIcon(IconData icon) {
    return Container(
      width: context.width / 15,
      margin: EdgeInsets.symmetric(horizontal: context.width / 40),
      alignment: Alignment.center,
      child: Icon(icon, color: primary, size: 20),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required bool isOpen,
    required VoidCallback onToggle,
    required List<String> items,
    required Function(String) onSelect,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: label,
                style: TextStyles.textStyleBold13.copyWith(
                  color: primary,
                ), // Label color from screenshot
              ),
              if (isRequired)
                TextSpan(
                  text: " *",
                  style: TextStyles.textStyleBold13.copyWith(color: red),
                ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(isOpen ? 20 : 38),
            border: Border.all(color: black.withOpacity(0.1)),
          ),
          child: Column(
            children: [
              // Header
              InkWell(
                onTap: onToggle,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: orangeBold,
                        ),
                        child: Icon(
                          isOpen
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: white,
                          size: 18,
                        ),
                      ),
                      Text(
                        value,
                        style: TextStyles.textStyleBold14.copyWith(
                          color: black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Expanding List
              if (isOpen)
                Container(
                  constraints: BoxConstraints(maxHeight: 200),
                  child: Column(
                    children: items.map((item) {
                      final bool isSelected = value == item;
                      return InkWell(
                        onTap: () => onSelect(item),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          color: isSelected
                              ? const Color(0xFFF5F5F5)
                              : Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (isSelected)
                                Icon(
                                  Icons.check,
                                  size: 16,
                                  color: black.withOpacity(0.5),
                                )
                              else
                                SizedBox(width: 16),
                              Text(
                                item,
                                style: TextStyles.textStyleBold14.copyWith(
                                  color: isSelected ? black : primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextArea({
    required TextEditingController controller,
    required String label,
    bool isRequired = false,
    String? hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: label,
                style: TextStyles.textStyleBold13.copyWith(color: primary),
              ),
              if (isRequired)
                TextSpan(
                  text: " *",
                  style: TextStyles.textStyleBold13.copyWith(color: red),
                ),
            ],
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: hint ?? tr("bio_hint_text"),
            hintStyle: TextStyles.textStyleNormal12.copyWith(color: grey2),
            filled: true,
            fillColor: white,
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: black.withOpacity(0.1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: black.withOpacity(0.1)),
            ),
          ),
        ),
      ],
    );
  }
}
