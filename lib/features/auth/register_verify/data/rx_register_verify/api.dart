import 'dart:convert';
import 'package:aarongonzales01/features/auth/register_verify/model/register_verify_model.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import '/networks/endpoints.dart';

final class RegisterVerifyApi {
  static final RegisterVerifyApi _singleton = RegisterVerifyApi._internal();
  RegisterVerifyApi._internal();
  static RegisterVerifyApi get instance => _singleton;

  Future<RegisterVerifyOtpModel> verifyOtp({
    required String otp,
    required String email,
    required String otpToken,
  }) async {
    try {
      final Map<String, dynamic> data = {
        "otp": otp,
        "email": email,
        "otp_token": otpToken,
      };

      Response response = await postHttp(Endpoints.registerVerifyOtp(), data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = RegisterVerifyOtpModel.fromRawJson(json.encode(response.data));
        final String message = response.data['message'] ?? "Email verification successful.";
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
