class ConfirmationDto{
  String? id; 
  String? verificationCode;

  ConfirmationDto({
    required this.id,
    required this.verificationCode,
  });

  factory ConfirmationDto.fromJson(Map<String, dynamic> json) {
    return ConfirmationDto(
      id: json['id'],
      verificationCode: json['verificationCode'],
    );
  }

  Map<String,dynamic> toJson (){
    return {
      'id': id,
      'verificationCode': verificationCode,
    };
  }
}

