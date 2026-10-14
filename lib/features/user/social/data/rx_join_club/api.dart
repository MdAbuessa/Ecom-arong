import 'dart:convert';
import 'package:aarongonzales01/features/user/social/model/join_club_model.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import 'package:aarongonzales01/networks/endpoints.dart';

final class JoinClubApi {
  static final JoinClubApi _singleton = JoinClubApi._internal();
  JoinClubApi._internal();
  static JoinClubApi get instance => _singleton;

  Future<JoinClubModel> joinClub(String slug) async {
    try {
      Response response = await postHttp(Endpoints.joinClub(slug));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = JoinClubModel.fromRawJson(json.encode(response.data));
        return model;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
