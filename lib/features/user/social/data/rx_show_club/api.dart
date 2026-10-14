import 'dart:convert';
import 'package:aarongonzales01/features/user/social/model/show_club_model.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import 'package:aarongonzales01/networks/endpoints.dart';

final class ShowClubApi {
  static final ShowClubApi _singleton = ShowClubApi._internal();
  ShowClubApi._internal();
  static ShowClubApi get instance => _singleton;

  Future<ShowClubModel> showClub(String slug) async {
    try {
      Response response = await getHttp(Endpoints.showClub(slug));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = ShowClubModel.fromRawJson(json.encode(response.data));
        return model;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
