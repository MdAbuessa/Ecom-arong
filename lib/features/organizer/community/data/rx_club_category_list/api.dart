import 'dart:convert';
import 'package:aarongonzales01/features/organizer/community/model/club_category_list_model.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import '/networks/endpoints.dart';

final class ClubCategoryListApi {
  static final ClubCategoryListApi _singleton = ClubCategoryListApi._internal();
  ClubCategoryListApi._internal();
  static ClubCategoryListApi get instance => _singleton;

  Future<ClubCategoryListModel> getClubCategoryList() async {
    try {
      Response response = await getHttp(Endpoints.clubCategoryList());

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = ClubCategoryListModel.fromRawJson(json.encode(response.data));
        return model;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
