class AuthResponse {
  String token;
  int userId;
  List<String> roles;

  AuthResponse({
    required this.token,
    required this.userId,
    required this.roles,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    List<String> userRoles = [];
    if (json['roles'] != null) {
      userRoles = List<String>.from(json['roles'].map((role) => role['name'] as String));
    }
    return AuthResponse(
      token: json['token'] as String,
      userId: json['userId'] as int,
      roles: userRoles,
    );
  }

}
