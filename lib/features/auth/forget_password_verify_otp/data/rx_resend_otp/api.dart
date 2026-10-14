import 'dart:convert';
import 'package:aarongonzales01/features/auth/forget_password_verify_otp/model/resend_otp_model.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/endpoints.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class ResendOtpApi {
  static final ResendOtpApi _singleton = ResendOtpApi._internal();
  ResendOtpApi._internal();
  static ResendOtpApi get instance => _singleton;

  Future<ResennOtpModel> resendOtp({
    required String email,
    required String otpToken,
  }) async {
    try {
      final Map<String, dynamic> data = {
        "email": email,
        "otp_token": otpToken,
      };

      Response response = await postHttp(Endpoints.resendOtp(), data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = ResennOtpModel.fromRawJson(json.encode(response.data));
        final String message = response.data['message'] ?? "OTP resent successfully.";
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
