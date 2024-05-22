
import 'package:equatable/equatable.dart';

class Register extends Equatable{
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  DateTime? dateOfBirth;

  Register({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.dateOfBirth,
  });

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      password: json['password'],
      dateOfBirth: json['dateOfBirth'] != null ? DateTime.parse(json['dateOfBirth']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
    };
  }
  
  @override
  List<Object?> get props => [firstname, lastname,email,dateOfBirth,password];
  
}