import 'dart:convert';
import 'package:aarongonzales01/features/auth/register/model/register_model.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import '/networks/endpoints.dart';

final class RegisterApi {
  static final RegisterApi _singleton = RegisterApi._internal();
  RegisterApi._internal();
  static RegisterApi get instance => _singleton;

  Future<RegisterModel> registerApi({
    required String firstName,
    required String email,
    required String password,
    required String passwordConfirmation,
    required int termsAndConditions,
  }) async {
    try {
      final Map<String, dynamic> data = {
        "first_name": firstName,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "terms_and_conditions": termsAndConditions,
      };

      Response response = await postHttp(Endpoints.register(), data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = RegisterModel.fromRawJson(json.encode(response.data));
        final String message = response.data['message'] ?? "Registration successful. Please verify your email.";
        ToastUtil.showShortToast(message);
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      rethrow;
    }
  }
}

