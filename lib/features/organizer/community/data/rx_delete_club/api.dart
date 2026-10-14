import 'dart:convert';
import 'package:aarongonzales01/features/organizer/community/model/club_delete_model.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import '/networks/endpoints.dart';

final class DeleteClubApi {
  static final DeleteClubApi _singleton = DeleteClubApi._internal();
  DeleteClubApi._internal();
  static DeleteClubApi get instance => _singleton;

  Future<ClubDeleteModel> deleteClub(String clubSlug) async {
    try {
      Response response = await deleteHttp(Endpoints.deleteClub(clubSlug));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = ClubDeleteModel.fromRawJson(json.encode(response.data));
        return model;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
