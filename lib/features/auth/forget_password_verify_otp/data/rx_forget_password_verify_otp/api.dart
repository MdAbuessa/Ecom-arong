import 'dart:convert';
import 'package:aarongonzales01/features/auth/forget_password_verify_otp/model/forget_password_otp_verify_model.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/endpoints.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class ForgetPasswordVerifyOtpApi {
  static final ForgetPasswordVerifyOtpApi _singleton = ForgetPasswordVerifyOtpApi._internal();
  ForgetPasswordVerifyOtpApi._internal();
  static ForgetPasswordVerifyOtpApi get instance => _singleton;

  Future<ForgetPasswordOtpVerifyModel> verifyOtp({
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

      Response response = await postHttp(Endpoints.forgetPasswordVerifyOtp(), data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = ForgetPasswordOtpVerifyModel.fromRawJson(json.encode(response.data));
        final String message = response.data['message'] ?? "Email verified successfully.";
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
