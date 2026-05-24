import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/widgets/teacher_card.dart';
import 'package:flutter/material.dart';

class TeachersListScreen extends StatelessWidget {
  final String categoryName;

  const TeachersListScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: customAppBar(
        appBarInd: 0,
        title: categoryName,
        context: context,
        status: false,
        widget: const SizedBox(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "اختر التخصص المفضل لديك", // Choose your preferred specialty
              style: TextStyles.textStyleBold18.copyWith(color: primary),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      1, // Using 1 for full width cards as per Image 2
                  childAspectRatio: 0.85,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: 4, // Mock count
                itemBuilder: (context, index) {
                  return TeacherCard(
                    name: "د. أحمد كمال",
                    specialty: "جراحة القلب والصدر",
                    image:
                        "https://via.placeholder.com/150", // Replace with real image
                    rating: 4.9,
                    experience: "10+ سنة خبرة",
                    studentCount: 500,
                    price: "150",
                    slug: "dr-ahmed-kamal",
                    onBookPressed: () {
                      // Navigate to booking or details
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
