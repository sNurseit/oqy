class ResetPasswordDto{
  String? oldPassword;
  String? newPassword1;
  String? newPassword2;

  ResetPasswordDto({
    required this.oldPassword,
    required this.newPassword1,
    required this.newPassword2,
  });


  bool _checkNewPassword(){
    if((newPassword1!.isNotEmpty && newPassword2!.isNotEmpty) && (newPassword1 == newPassword2)){
      return true;
    }
    return false;
  }
  bool _checkOldPassword(){
    if(oldPassword!.isNotEmpty ){
      return true;
    }
    return false;
  }

  bool checkOldAndNewPasswordToEqaulity(){
    bool checkOld = _checkOldPassword();
    bool newPassword = _checkNewPassword();

    if((checkOld && newPassword) && (oldPassword != newPassword1)){
      return true;
    }
    return false;
  }
}