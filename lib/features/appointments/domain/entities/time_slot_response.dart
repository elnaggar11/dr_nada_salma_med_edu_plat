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
  String? studentName;
  String? teacherName;
  String? subjectName;
  Booking? booking;

  TimeSlot({
    this.id,
    this.teacherId,
    this.date,
    this.startTime,
    this.endTime,
    this.isBooked,
    this.createdAt,
    this.updatedAt,
    this.studentName,
    this.teacherName,
    this.subjectName,
    this.booking,
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
    studentName = json['student_name'];
    teacherName = json['teacher_name'];
    subjectName = json['subject_name'];
    booking = json['booking'] != null ? Booking.fromJson(json['booking']) : null;
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
    data['student_name'] = this.studentName;
    data['teacher_name'] = this.teacherName;
    data['subject_name'] = this.subjectName;
    if (this.booking != null) {
      data['booking'] = this.booking!.toJson();
    }
    return data;
  }
}

class Booking {
  int? id;
  String? status;
  BookingUser? student;
  BookingUser? teacher;
  BookingSubject? subject;

  Booking({this.id, this.status, this.student, this.teacher, this.subject});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    student = json['student'] != null ? BookingUser.fromJson(json['student']) : null;
    teacher = json['teacher'] != null ? BookingUser.fromJson(json['teacher']) : null;
    subject = json['subject'] != null ? BookingSubject.fromJson(json['subject']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['status'] = this.status;
    if (this.student != null) {
      data['student'] = this.student!.toJson();
    }
    if (this.teacher != null) {
      data['teacher'] = this.teacher!.toJson();
    }
    if (this.subject != null) {
      data['subject'] = this.subject!.toJson();
    }
    return data;
  }
}

class BookingUser {
  int? id;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? image;

  BookingUser({this.id, this.fullName, this.email, this.phoneNumber, this.image});

  BookingUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['image'] = this.image;
    return data;
  }
}

class BookingSubject {
  int? id;
  String? name;

  BookingSubject({this.id, this.name});

  BookingSubject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
