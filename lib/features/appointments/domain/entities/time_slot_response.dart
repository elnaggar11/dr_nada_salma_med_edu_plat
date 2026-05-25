class TimeSlotResponse {
  bool? status;
  String? message;
  List<TimeSlot>? data;

  TimeSlotResponse({this.status, this.message, this.data});

  TimeSlotResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TimeSlot>[];
      json['data'].forEach((v) {
        data!.add(TimeSlot.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeSlot {
  int? id;
  int? teacherId;
  DateTime? date;
  String? startTime;
  String? endTime;
  bool? isBooked;
  String? createdAt;
  String? updatedAt;

  TimeSlot({
    this.id,
    this.teacherId,
    this.date,
    this.startTime,
    this.endTime,
    this.isBooked,
    this.createdAt,
    this.updatedAt,
  });

  TimeSlot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherId = json['teacher_id'];
    date = json['date'] != null ? DateTime.parse(json['date']) : null;
    startTime = json['start_time'];
    endTime = json['end_time'];
    isBooked = json['is_booked'] == 1 || json['is_booked'] == true;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['teacher_id'] = this.teacherId;
    if (this.date != null) {
      data['date'] = this.date!.toIso8601String();
    }
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['is_booked'] = this.isBooked;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
