import 'dart:convert';
import 'package:aarongonzales01/features/organizer/community/model/club_challenge_list_model.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import '/networks/endpoints.dart';

final class ClubChallengeListApi {
  static final ClubChallengeListApi _singleton =
      ClubChallengeListApi._internal();
  ClubChallengeListApi._internal();
  static ClubChallengeListApi get instance => _singleton;

  Future<ClubChallengeListModel> getClubChallengeList({
    String? clubSlug,
    int? perPage,
    int? page,
  }) async {
    try {
      Response response = await getHttp(
        Endpoints.clubChallengeList(
          clubSlug: clubSlug,
          perPage: perPage,
          page: page,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = ClubChallengeListModel.fromRawJson(
          json.encode(response.data),
        );
        return model;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
