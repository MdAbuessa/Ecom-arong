import 'dart:convert';
import 'package:aarongonzales01/features/user/profile/model/change_password_model.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import '/networks/endpoints.dart';

final class ChangePasswordApi {
  static final ChangePasswordApi _singleton = ChangePasswordApi._internal();
  ChangePasswordApi._internal();
  static ChangePasswordApi get instance => _singleton;

  Future<ChangePasswordModel> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    try {
      final Map<String, dynamic> data = {
        "current_password": currentPassword,
        "new_password": newPassword,
        "new_password_confirmation": newPasswordConfirmation,
      };

      Response response = await postHttp(Endpoints.updatePassword(), data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = ChangePasswordModel.fromRawJson(json.encode(response.data));
        final String message = response.data['message'] ?? "Password updated successfully.";
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
