import 'dart:convert';
import 'package:aarongonzales01/features/user/profile/model/logout_model.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import '/networks/endpoints.dart';

final class LogoutApi {
  static final LogoutApi _singleton = LogoutApi._internal();
  LogoutApi._internal();
  static LogoutApi get instance => _singleton;

  Future<LogoutModel> logout() async {
    try {
      Response response = await postHttp(Endpoints.logout(), {});

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = LogoutModel.fromRawJson(json.encode(response.data));
        final String message = response.data['message'] ?? "Logged out successfully.";
        ToastUtil.showShortToast(message);
        return model;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
