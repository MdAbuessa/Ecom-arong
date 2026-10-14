import 'dart:convert';
import 'package:aarongonzales01/features/organizer/community/model/club_show_model.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import '/networks/endpoints.dart';

final class ClubShowApi {
  static final ClubShowApi _singleton = ClubShowApi._internal();
  ClubShowApi._internal();
  static ClubShowApi get instance => _singleton;

  Future<ClubShowModel> getClubShow(String slug) async {
    try {
      Response response = await getHttp(Endpoints.clubShow(slug));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = ClubShowModel.fromRawJson(json.encode(response.data));
        return model;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
