class TeacherApplicationParams {
  final String name;
  final String email;
  final String specialty;
  final String bio;
  final List<int> subjectIds;
  final String whatsapp;
  final String? alternativeContact;
  final List<String> availableDays;
  final String fromTime;
  final String toTime;

  static String _cleanNumbers(String val) {
    return val
        .replaceAll('٠', '0')
        .replaceAll('١', '1')
        .replaceAll('٢', '2')
        .replaceAll('٣', '3')
        .replaceAll('٤', '4')
        .replaceAll('٥', '5')
        .replaceAll('٦', '6')
        .replaceAll('٧', '7')
        .replaceAll('٨', '8')
        .replaceAll('٩', '9')
        .replaceAll('۰', '0')
        .replaceAll('۱', '1')
        .replaceAll('۲', '2')
        .replaceAll('۳', '3')
        .replaceAll('۴', '4')
        .replaceAll('۵', '5')
        .replaceAll('۶', '6')
        .replaceAll('۷', '7')
        .replaceAll('۸', '8')
        .replaceAll('۹', '9')
        .trim();
  }

  TeacherApplicationParams({
    required String name,
    required String email,
    required this.specialty,
    required String bio,
    required this.subjectIds,
    required String whatsapp,
    String? alternativeContact,
    required this.availableDays,
    required this.fromTime,
    required this.toTime,
  }) : name = _cleanNumbers(name),
       email = _cleanNumbers(email),
       bio = _cleanNumbers(bio),
       whatsapp = _cleanNumbers(whatsapp),
       alternativeContact = alternativeContact != null
           ? _cleanNumbers(alternativeContact)
           : null;

  Map<String, dynamic> toMap() {
    return {
      'fullName': name,
      'email': email,
      'specialty': specialty,
      'about': bio,
      'subjects': subjectIds,
      'whatsapp': whatsapp,
      if (alternativeContact != null && alternativeContact!.isNotEmpty)
        'otherPhone': alternativeContact,
      'days': availableDays,
      'days_count': availableDays.length,
      'daysCount': availableDays.length,
      'number_of_days': availableDays.length,
      'available_days_count': availableDays.length,
      'days_number': availableDays.length,
      'number_days': availableDays.length,
      'fromTime': _formatTo24Hour(fromTime),
      'toTime': _formatTo24Hour(toTime),
    };
  }

  String _formatTo24Hour(String timeStr) {
    if (timeStr.isEmpty) return timeStr;

    // Clean Arabic numbers if any
    String cleaned = _cleanNumbers(timeStr);

    // Check if it already matches standard HH:mm (e.g., 08:00 or 16:30)
    final reg24 = RegExp(r'^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
    if (reg24.hasMatch(cleaned)) {
      final parts = cleaned.split(':');
      final hour = parts[0].padLeft(2, '0');
      final minute = parts[1].padLeft(2, '0');
      return '$hour:$minute';
    }

    // Parse AM/PM
    bool isPm = cleaned.toLowerCase().contains('pm') || cleaned.contains('م');
    bool isAm = cleaned.toLowerCase().contains('am') || cleaned.contains('ص');

    // Remove non-digit characters except colon
    final digitsOnly = cleaned.replaceAll(RegExp(r'[^0-9:]'), '');
    final parts = digitsOnly.split(':');
    if (parts.length < 2) return cleaned;

    int hour = int.tryParse(parts[0]) ?? 0;
    int minute = int.tryParse(parts[1]) ?? 0;

    if (isPm && hour < 12) {
      hour += 12;
    } else if (isAm && hour == 12) {
      hour = 0;
    }

    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
  }
}
