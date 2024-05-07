
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
      Profile profile = Profile.fromJson(response.data);
      print(profile.firstname);
      return profile;
    } catch(e){
      print(e.toString());
      throw Exception('Failed to load content. Status code: ${response.statusCode}');
    }
  }  
}