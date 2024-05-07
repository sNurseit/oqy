import 'dart:convert';

import 'package:oqy/domain/entity/course.dart';

class Profile {
  String? firstname;
  String? lastname;
  String? email;
  DateTime? dateOfBirth;
  String? picture;
  List<Course>? courses;

  Profile({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.dateOfBirth,
    required this.picture,
    required this.courses,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      picture: json['picture'],
      courses: (json['courses'] as List).map((courseJson) => Course.fromJson(courseJson)).toList(),
    );
  }
}