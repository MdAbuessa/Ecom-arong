import 'dart:convert';
import 'package:aarongonzales01/features/auth/update_password/model/reset_password_model.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/endpoints.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class ResetPasswordApi {
  static final ResetPasswordApi _singleton = ResetPasswordApi._internal();
  ResetPasswordApi._internal();
  static ResetPasswordApi get instance => _singleton;

  Future<ResetPasswordModel> resetPassword({
    required String email,
    required String resetToken,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final Map<String, dynamic> data = {
        "email": email,
        "reset_token": resetToken,
        "password": password,
        "password_confirmation": passwordConfirmation,
      };

      Response response = await postHttp(Endpoints.resetPassword(), data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = ResetPasswordModel.fromRawJson(json.encode(response.data));
        final String message = response.data['message'] ?? "Password reset successfully.";
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
