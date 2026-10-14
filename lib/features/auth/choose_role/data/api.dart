import 'dart:convert';
import 'package:aarongonzales01/features/auth/choose_role/model/choose_role_model.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import '/networks/endpoints.dart';

final class ChooseRoleApi {
  static final ChooseRoleApi _singleton = ChooseRoleApi._internal();
  ChooseRoleApi._internal();
  static ChooseRoleApi get instance => _singleton;

  Future<ChooseRoleModel> updateRole({
    required String role,
  }) async {
    try {
      final Map<String, dynamic> data = {
        "role": role,
      };

      Response response = await postHttp(Endpoints.chooseRole(), data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = ChooseRoleModel.fromRawJson(json.encode(response.data));
        final String message = response.data['message'] ?? "Profile updated successfully.";
        ToastUtil.showShortToast(message);
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
