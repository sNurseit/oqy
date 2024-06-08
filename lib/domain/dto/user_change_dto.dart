import 'package:oqy/domain/entity/role.dart';

class UserChangeDto {
  int? id;
  String? firstname;
  String? lastname;
  String? email;
  DateTime? dateOfBirth;
  bool? enabled;
  String? picture;
  List<Role>? roles;

  UserChangeDto({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.dateOfBirth,
    this.enabled,
    this.picture,
    this.roles,
  });

  factory UserChangeDto.fromJson(Map<String, dynamic> json) {
    var rolesFromJson = json['roles'] as List;
    List<Role> rolesSet = rolesFromJson.map((role) => Role.fromJson(role)).toList();

    return UserChangeDto(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      enabled: json['enabled'],
      picture: json['picture'],
      roles: rolesSet,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'dateOfBirth':  dateOfBirth!=null? dateOfBirth!.toIso8601String() :'',
      'enabled': enabled,
      'picture': picture,
      'roles': roles != null ? roles!.map((role) => role.toJson()).toList() :[],
    };
  }
}