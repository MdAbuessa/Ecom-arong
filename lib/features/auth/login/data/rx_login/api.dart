import 'dart:convert';
import 'package:aarongonzales01/constants/app_constants.dart';
import 'package:aarongonzales01/features/auth/login/model/login_model.dart';
import 'package:aarongonzales01/helpers/di.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/endpoints.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class LoginApi {
  static final LoginApi _singleton = LoginApi._internal();
  LoginApi._internal();
  static LoginApi get instance => _singleton;

  Future<LoginModel> loginApi({
    required String email,
    required String password,
    int? rememberMe,
  }) async {
    try {
      Map<String, dynamic> formDataMap = {
        "email": email,
        "password": password,
      };

      if (rememberMe != null) {
        formDataMap["remember_me"] = rememberMe;
      }

      FormData data = FormData.fromMap(formDataMap);

      Response response = await postHttp(Endpoints.login(), data);

      if (response.statusCode == 200) {
        final loginResponse = LoginModel.fromRawJson(json.encode(response.data));
        // Save token and login state
        if (loginResponse.data?.accessToken != null) {
          appData.write(kKeyIsLoggedIn, true);
          appData.write(kKeyAccessToken, loginResponse.data!.accessToken);
          appData.write(kKeyRefreshToken, loginResponse.data!.refreshToken);
          DioSingleton.instance.update(loginResponse.data!.accessToken!);
        }
        if (loginResponse.data != null) {
          appData.write(
            kKeyName,
            loginResponse.data!.user!.firstName ?? loginResponse.data!.user!.username,
          );
          appData.write(kKeyEmail, loginResponse.data!.user!.email);
        }
        ToastUtil.showShortToast(
          loginResponse.message ?? "Login successful.",
        );
        return loginResponse;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      rethrow;
    }
  }
}
