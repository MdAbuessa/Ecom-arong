import 'dart:convert';
import 'package:aarongonzales01/features/auth/forget_password/model/forget_password_model.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/endpoints.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class ForgetPasswordApi {
  static final ForgetPasswordApi _singleton = ForgetPasswordApi._internal();
  ForgetPasswordApi._internal();
  static ForgetPasswordApi get instance => _singleton;

  Future<ForgetPasswordModel> forgetPasswordApi({
    required String email,
  }) async {
    try {
      final Map<String, dynamic> data = {
        "email": email,
      };

      Response response = await postHttp(Endpoints.forgetPassword(), data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = ForgetPasswordModel.fromRawJson(json.encode(response.data));
        final String message = response.data['message'] ?? "OTP sent for password reset.";
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
