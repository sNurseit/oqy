
import 'package:dio/dio.dart';
import 'package:oqy/domain/api_constant/api_constants.dart';
import 'package:oqy/domain/config/auth_config.dart';
import 'package:oqy/domain/entity/profile.dart';
import 'package:oqy/service/profile_service.dart';

class ProfileServiceImpl implements ProfileService{
  final String _api = ApiConstants.myProfile;
  final Dio dio;

  ProfileServiceImpl({required this.dio}){
    dio.interceptors.add(AuthInterceptor());
  }

  @override
  Future<Profile> getProfile() async {
    Response response = await dio.get(_api);
    try{
        if (response.statusCode == 200) {
        Profile profile = Profile.fromJson(response.data);
        return profile;
      } else {
        throw Exception('Failed to load content. Status code: ${response.statusCode}');
      }
    } catch(e){
      throw Exception('Failed to load content. Status code: ${response.statusCode}');
    }
  }  
}