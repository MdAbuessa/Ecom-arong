import 'dart:convert';
import 'package:aarongonzales01/features/user/club_details/model/club_details_model.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import 'package:aarongonzales01/networks/endpoints.dart';

final class ClubDetailsApi {
  static final ClubDetailsApi _singleton = ClubDetailsApi._internal();
  ClubDetailsApi._internal();
  static ClubDetailsApi get instance => _singleton;

  Future<ClubDetailsModel> getClubDetails(String slug) async {
    try {
      Response response = await getHttp(Endpoints.showClub(slug));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = ClubDetailsModel.fromRawJson(json.encode(response.data));
        return model;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
