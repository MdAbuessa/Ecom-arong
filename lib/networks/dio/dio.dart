import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '/helpers/di.dart';
import '../../constants/app_constants.dart';
import '../endpoints.dart';
import 'log.dart';

final class DioSingleton {
  static final DioSingleton _singleton = DioSingleton._internal();
  static CancelToken cancelToken = CancelToken();
  DioSingleton._internal();

  static DioSingleton get instance => _singleton;

  late Dio dio;

  void create() {
    BaseOptions options = BaseOptions(
        baseUrl: url,
        connectTimeout: const Duration(milliseconds: 100000), 
        receiveTimeout: const Duration(milliseconds: 100000),
        headers: {
          NetworkConstants.ACCEPT: NetworkConstants.ACCEPT_TYPE,
          NetworkConstants.ACCEPT_LANGUAGE: appData.read(kKeyCountryCode) ?? "pt",
          NetworkConstants.APP_KEY: NetworkConstants.APP_KEY_VALUE,
        });
    dio = Dio(options)
      ..interceptors.add(Logger())
      ..interceptors.add(TokenRefreshInterceptor());
  }

  void update(String auth) {
    if (kDebugMode) {
      print("Dio update");
    }
    BaseOptions options = BaseOptions(
      baseUrl: url,
      responseType: ResponseType.json,
      headers: {
        NetworkConstants.ACCEPT: NetworkConstants.ACCEPT_TYPE,
        NetworkConstants.ACCEPT_LANGUAGE: appData.read(kKeyLanguage) ?? "pt",
        NetworkConstants.APP_KEY: NetworkConstants.APP_KEY_VALUE,
        NetworkConstants.AUTHORIZATION: "Bearer $auth",
      },
      connectTimeout: const Duration(milliseconds: 100000),
      receiveTimeout: const Duration(milliseconds: 100000),
    );
    dio = Dio(options)
      ..interceptors.add(Logger())
      ..interceptors.add(TokenRefreshInterceptor());
  }

  void updateLanguage(String countryCode) {
    if (kDebugMode) {
      print("Dio update $countryCode");
    }
    BaseOptions options = BaseOptions(
      baseUrl: url,
      responseType: ResponseType.json,
      headers: {
        NetworkConstants.ACCEPT: NetworkConstants.ACCEPT_TYPE,
        NetworkConstants.ACCEPT_LANGUAGE: countryCode,
        NetworkConstants.APP_KEY: NetworkConstants.APP_KEY_VALUE,
        NetworkConstants.AUTHORIZATION: "Bearer ${appData.read(kKeyAccessToken)} ",
      },
      connectTimeout: const Duration(milliseconds: 100000),
      receiveTimeout: const Duration(milliseconds: 100000),
    );
    dio = Dio(options)
      ..interceptors.add(Logger())
      ..interceptors.add(TokenRefreshInterceptor());
  }
}

class TokenRefreshInterceptor extends Interceptor {
  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refreshToken = appData.read(kKeyRefreshToken);
      if (refreshToken != null && refreshToken.toString().isNotEmpty) {
        try {
          // Use a clean Dio instance to make the token refresh call to prevent interceptor recursion.
          final cleanDio = Dio(BaseOptions(
            baseUrl: url,
            headers: {
              NetworkConstants.ACCEPT: NetworkConstants.ACCEPT_TYPE,
              NetworkConstants.APP_KEY: NetworkConstants.APP_KEY_VALUE,
            },
          ));
          
          final response = await cleanDio.post(
            Endpoints.refreshToken(),
            data: {
              'refresh_token': refreshToken,
            },
          );

          if (response.statusCode == 200 || response.statusCode == 201) {
            final String newAccessToken = response.data['data']['access_token'] ?? "";
            final String newRefreshToken = response.data['data']['refresh_token'] ?? "";
            
            if (newAccessToken.isNotEmpty) {
              // 1. Cache the new tokens
              appData.write(kKeyAccessToken, newAccessToken);
              if (newRefreshToken.isNotEmpty) {
                appData.write(kKeyRefreshToken, newRefreshToken);
              }
              
              // 2. Update default Authorization header on the main Dio instance
              DioSingleton.instance.dio.options.headers[NetworkConstants.AUTHORIZATION] = "Bearer $newAccessToken";
              
              // 3. Clone and retry the failed request with the new access token
              final requestOptions = err.requestOptions;
              requestOptions.headers[NetworkConstants.AUTHORIZATION] = "Bearer $newAccessToken";
              
              final clonedResponse = await DioSingleton.instance.dio.fetch(requestOptions);
              return handler.resolve(clonedResponse);
            }
          }
        } catch (refreshError) {
          debugPrint("Failed to refresh token: $refreshError");
          appData.remove(kKeyIsLoggedIn);
          appData.remove(kKeyAccessToken);
          appData.remove(kKeyRefreshToken);
        }
      }
    }
    super.onError(err, handler);
  }
}

Future<Response> postHttp(String path, [dynamic data]) =>
    DioSingleton.instance.dio.post(path, data: data, cancelToken: DioSingleton.cancelToken);

Future<Response> putHttp(String path, [dynamic data]) =>
    DioSingleton.instance.dio.put(path, data: data, cancelToken: DioSingleton.cancelToken);

Future<Response> getHttp(String path, [dynamic data]) =>
    DioSingleton.instance.dio.get(path, cancelToken: DioSingleton.cancelToken);

Future<Response> deleteHttp(String path, [dynamic data]) =>
    DioSingleton.instance.dio.delete(path, data: data, cancelToken: DioSingleton.cancelToken);
