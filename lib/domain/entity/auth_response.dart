class AuthResponse {
   String token;
   int userId;

  AuthResponse({
    required this.token,
    required this.userId,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'] as String,
      userId: json['userId'] as int,
    );
  }
}
