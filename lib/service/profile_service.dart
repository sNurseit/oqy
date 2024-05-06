import 'package:oqy/domain/entity/profile.dart';

abstract class ProfileService{
  Future<Profile> getProfile();
}