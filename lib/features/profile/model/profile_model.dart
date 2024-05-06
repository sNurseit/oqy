import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:oqy/domain/entity/profile.dart';
import 'package:oqy/service/profile_service.dart';

class ProfileModel extends ChangeNotifier{
  ProfileService profileService = GetIt.I<ProfileService>();

  Future <Profile?> getProfile() async {
    final profile = await profileService.getProfile();
    notifyListeners();
    return profile;
  }

  Future<bool> changePasssword() async {
    return true;
  }
}