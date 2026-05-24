import 'dart:io';

void main() async {
  final directories = [
    Directory('lib/features/courses/presentation/screens'),
    Directory('lib/features/courses/presentation/widgets/teacher'),
  ];

  final filePaths = [
    'lib/features/courses/presentation/screens/teacher_detail_view.dart',
    'lib/features/courses/presentation/widgets/teacher/teacher_booking_footer.dart',
    'lib/features/courses/presentation/widgets/teacher/teacher_info_sections.dart',
    'lib/features/courses/presentation/widgets/teacher/teacher_profile_header.dart',
    'lib/features/courses/presentation/widgets/teacher/teacher_ratings_list.dart',
    'lib/features/courses/presentation/widgets/teacher/teacher_stat_cards.dart',
    'lib/features/courses/presentation/widgets/teacher/teacher_video_player.dart',
  ];

  for (var path in filePaths) {
    final file = File(path);
    if (!await file.exists()) continue;

    String content = await file.readAsString();
    
    // Remove import
    content = content.replaceAll("import 'package:flutter_screenutil/flutter_screenutil.dart';", "");

    // Replace Spaces
    // 16.h.verticalSpace -> const SizedBox(height: 16)
    content = content.replaceAllMapped(RegExp(r'(\d+(?:\.\d+)?)\.h\.verticalSpace'), (m) => 'const SizedBox(height: ${m[1]})');
    content = content.replaceAllMapped(RegExp(r'(\d+(?:\.\d+)?)\.w\.horizontalSpace'), (m) => 'const SizedBox(width: ${m[1]})');
    content = content.replaceAllMapped(RegExp(r'(\d+(?:\.\d+)?)\.verticalSpace'), (m) => 'const SizedBox(height: ${m[1]})');
    content = content.replaceAllMapped(RegExp(r'(\d+(?:\.\d+)?)\.horizontalSpace'), (m) => 'const SizedBox(width: ${m[1]})');
    
    // For variables or dynamic values like `size.h.verticalSpace` it's trickier, but typically it's hardcoded numbers.
    // Replace .h, .w, .sp, .r
    content = content.replaceAllMapped(RegExp(r'(\w+)\.h\b'), (m) => m[1]!);
    content = content.replaceAllMapped(RegExp(r'(\w+)\.w\b'), (m) => m[1]!);
    content = content.replaceAllMapped(RegExp(r'(\w+)\.sp\b'), (m) => m[1]!);
    content = content.replaceAllMapped(RegExp(r'(\w+)\.r\b'), (m) => m[1]!);
    // .sw, .sh
    content = content.replaceAllMapped(RegExp(r'(\w+)\.sw\b'), (m) => 'MediaQuery.of(context).size.width');
    content = content.replaceAllMapped(RegExp(r'(\w+)\.sh\b'), (m) => 'MediaQuery.of(context).size.height');

    await file.writeAsString(content);
    print('Processed $path');
  }
}
