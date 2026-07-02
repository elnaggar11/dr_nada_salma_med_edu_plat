class TimeSlotResponse {
  bool? status;
  String? message;
  List<TimeSlot>? data;

  TimeSlotResponse({this.status, this.message, this.data});

  TimeSlotResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = <TimeSlot>[];
    if (json['data'] != null) {
      if (json['data'] is List) {
        for (var v in json['data']) {
          data!.add(TimeSlot.fromJson(v));
        }
      } else if (json['data'] is Map) {
        if (json['data']['data'] is List) {
          for (var v in json['data']['data']) {
            data!.add(TimeSlot.fromJson(v));
          }
        } else if (json['data']['slots'] is List) {
          for (var v in json['data']['slots']) {
            data!.add(TimeSlot.fromJson(v));
          }
        }
      }
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
    if ((json.containsKey('time_slot') && json['time_slot'] != null && json['time_slot'] is Map) ||
        (json.containsKey('session') && json['session'] != null && json['session'] is Map)) {
      final ts = (json['time_slot'] is Map ? json['time_slot'] : null) ?? (json['session'] is Map ? json['session'] : null) ?? {};
      id = ts['id'] ?? json['id'];
      teacherId = ts['teacher_id'] ?? json['teacher_id'] ?? (json['teacher'] is Map ? json['teacher']['id'] : null);
      date = _parseDate(ts['date']) ?? _parseDate(json['date']);
      startTime = ts['start_time'] ?? json['start_time'];
      endTime = ts['end_time'] ?? json['end_time'];
      isBooked = true;
      createdAt = ts['created_at'] ?? json['created_at'];
      updatedAt = ts['updated_at'] ?? json['updated_at'];
      booking = json['booking'] != null 
          ? Booking.fromJson(json['booking']) 
          : ((json['teacher'] != null || json['student'] != null) ? Booking.fromJson(json) : null);
      studentName = booking?.student?.fullName ?? _extractName(json['student']) ?? json['student_name'];
      teacherName = booking?.teacher?.fullName ?? _extractName(json['teacher']) ?? json['teacher_name'];
      subjectName = booking?.subject?.name ?? _extractName(json['subject']) ?? json['subject_name'];
    } else {
      id = json['id'];
      teacherId = json['teacher_id'] ?? (json['teacher'] is Map ? json['teacher']['id'] : null);
      date = _parseDate(json['date']);
      startTime = json['start_time'] ?? json['time'];
      endTime = json['end_time'];
      isBooked = json['is_booked'] == 1 || json['is_booked'] == true || json['is_booked'] == '1';
      createdAt = json['created_at'];
      updatedAt = json['updated_at'];
      booking = json['booking'] != null 
          ? Booking.fromJson(json['booking']) 
          : ((json['teacher'] != null || json['student'] != null) ? Booking.fromJson(json) : null);
      studentName = json['student_name'] ?? booking?.student?.fullName ?? _extractName(json['student']);
      teacherName = json['teacher_name'] ?? booking?.teacher?.fullName ?? _extractName(json['teacher']);
      subjectName = json['subject_name'] ?? booking?.subject?.name ?? _extractName(json['subject']);
    }
  }

  static DateTime? _parseDate(dynamic dateValue) {
    if (dateValue == null) return null;
    final str = dateValue.toString();
    var parsed = DateTime.tryParse(str);
    if (parsed != null) return parsed;
    if (str.contains('/')) {
      final parts = str.split('/');
      if (parts.length == 3) {
        if (parts[2].length == 4) {
           return DateTime.tryParse('${parts[2]}-${parts[1].padLeft(2, '0')}-${parts[0].padLeft(2, '0')}');
        } else if (parts[0].length == 4) {
           return DateTime.tryParse('${parts[0]}-${parts[1].padLeft(2, '0')}-${parts[2].padLeft(2, '0')}');
        }
      }
    }
    return null;
  }

  static String? _extractName(dynamic obj) {
    if (obj is Map) {
      return obj['full_name'] ?? obj['name'];
    }
    return null;
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
    student = (json['student'] != null && json['student'] is Map) 
        ? BookingUser.fromJson(json['student']) 
        : (json['student'] is String ? BookingUser(
            fullName: json['student'],
            image: json['student_image'] ?? json['image'],
            phoneNumber: json['student_phone'] ?? json['phone'] ?? json['phone_number']
          ) : null);
    teacher = (json['teacher'] != null && json['teacher'] is Map) 
        ? BookingUser.fromJson(json['teacher']) 
        : (json['teacher'] is String ? BookingUser(
            fullName: json['teacher'],
            image: json['teacher_image'] ?? json['image'],
            phoneNumber: json['teacher_phone'] ?? json['phone'] ?? json['phone_number']
          ) : null);
    subject = (json['subject'] != null && json['subject'] is Map) 
        ? BookingSubject.fromJson(json['subject']) 
        : (json['subject'] is String ? BookingSubject(name: json['subject']) : null);
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
