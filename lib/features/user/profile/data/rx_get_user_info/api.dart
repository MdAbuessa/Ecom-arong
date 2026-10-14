import 'dart:convert';
import 'package:aarongonzales01/features/user/profile/model/get_user_info_model.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import '/networks/endpoints.dart';

final class GetUserInfoApi {
  static final GetUserInfoApi _singleton = GetUserInfoApi._internal();
  GetUserInfoApi._internal();
  static GetUserInfoApi get instance => _singleton;

  Future<GetUserInfoModel> getUserInfo() async {
    try {
      Response response = await getHttp(Endpoints.getUserInfo());

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = GetUserInfoModel.fromRawJson(json.encode(response.data));
        return model;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
