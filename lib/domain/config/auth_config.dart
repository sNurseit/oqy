import 'package:dio/dio.dart';
import 'package:oqy/domain/provider/session_provider.dart';

class AuthInterceptor extends Interceptor {
  final _sessionProvider = SessionDataProvider();
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await _sessionProvider.getToken();

    if (accessToken != null) {
      // Добавляем токен к заголовкам запроса
      options.headers['Authorization'] = accessToken;
      options.headers['Content-Type'] = 'application/json';
    }

    return super.onRequest(options, handler);
  }
}
