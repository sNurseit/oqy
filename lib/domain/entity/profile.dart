
import 'package:equatable/equatable.dart';
import 'package:oqy/domain/entity/course.dart';

class Profile extends Equatable{
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
    print (json);
    return Profile(
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      dateOfBirth: json['dateOfBirth'] != null ? DateTime.parse(json['dateOfBirth']) : null,
      picture: json['picture'],
      courses: (json['courses'] as List).map((courseJson) => Course.fromJson(courseJson)).toList(),
    );
  }
  
  @override
  List<Object?> get props => [firstname, lastname,email,dateOfBirth,picture,courses];
  
}