import 'dart:convert';
import 'package:aarongonzales01/features/user/profile/model/help_and_support_model.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import '/networks/endpoints.dart';

final class HelpAndSupportApi {
  static final HelpAndSupportApi _singleton = HelpAndSupportApi._internal();
  HelpAndSupportApi._internal();
  static HelpAndSupportApi get instance => _singleton;

  Future<HelpAndSupportModel> fetchHelpAndSupport() async {
    try {
      Response response = await getHttp(Endpoints.helpAndSupport());

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model =
            HelpAndSupportModel.fromRawJson(json.encode(response.data));
        return model;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
