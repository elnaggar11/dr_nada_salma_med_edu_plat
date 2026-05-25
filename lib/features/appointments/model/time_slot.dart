class TimeSlot {
  final int id;
  final int teacherId;
  final DateTime date;
  final String startTime;
  final String endTime;
  final bool isBooked;

  TimeSlot({
    required this.id,
    required this.teacherId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.isBooked,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      id: json['id'],
      teacherId: json['teacher_id'],
      date: DateTime.parse(json['date']),
      startTime: json['start_time'],
      endTime: json['end_time'],
      isBooked: json['is_booked'] == true || json['is_booked'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teacher_id': teacherId,
      'date': date.toIso8601String(),
      'start_time': startTime,
      'end_time': endTime,
      'is_booked': isBooked,
    };
  }
}
