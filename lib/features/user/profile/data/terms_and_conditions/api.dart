import 'dart:convert';
import 'package:aarongonzales01/features/user/profile/model/terms_and_condition_model.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import '/networks/endpoints.dart';

final class TermsAndConditionsApi {
  static final TermsAndConditionsApi _singleton =
      TermsAndConditionsApi._internal();
  TermsAndConditionsApi._internal();
  static TermsAndConditionsApi get instance => _singleton;

  Future<TermsAndConditionModel> fetchTermsAndConditions() async {
    try {
      Response response = await getHttp(Endpoints.termsAndConditions());

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model =
            TermsAndConditionModel.fromRawJson(json.encode(response.data));
        return model;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
