import 'dart:convert';
import 'package:aarongonzales01/features/user/profile/model/privacy_policy_model.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import '/networks/endpoints.dart';

final class PrivacyPolicyApi {
  static final PrivacyPolicyApi _singleton = PrivacyPolicyApi._internal();
  PrivacyPolicyApi._internal();
  static PrivacyPolicyApi get instance => _singleton;

  Future<PrivacyPolicyModel> fetchPrivacyPolicy() async {
    try {
      Response response = await getHttp(Endpoints.privacyPolicy());

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model =
            PrivacyPolicyModel.fromRawJson(json.encode(response.data));
        return model;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
