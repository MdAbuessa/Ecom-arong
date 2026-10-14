import 'dart:convert';
import 'package:aarongonzales01/features/organizer/community/model/social_feed_list_model.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import '/networks/endpoints.dart';

final class SocialFeedListApi {
  static final SocialFeedListApi _singleton = SocialFeedListApi._internal();
  SocialFeedListApi._internal();
  static SocialFeedListApi get instance => _singleton;

  Future<SocialFeedListModel> getSocialFeedList({
    int? perPage,
    String? clubSlug,
    int? page,
  }) async {
    try {
      Response response = await getHttp(
        Endpoints.socialFeedList(
          perPage: perPage,
          clubSlug: clubSlug,
          page: page,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = SocialFeedListModel.fromRawJson(
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
