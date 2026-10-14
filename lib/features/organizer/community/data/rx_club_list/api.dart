import 'dart:convert';
import 'package:aarongonzales01/features/organizer/community/model/club_list_model.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import '/networks/endpoints.dart';

final class ClubListApi {
  static final ClubListApi _singleton = ClubListApi._internal();
  ClubListApi._internal();
  static ClubListApi get instance => _singleton;

  Future<ClubListModel> getClubList(String query, int page) async {
    try {
      Response response = await getHttp(Endpoints.clubList(query, page));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = ClubListModel.fromRawJson(json.encode(response.data));
        return model;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
