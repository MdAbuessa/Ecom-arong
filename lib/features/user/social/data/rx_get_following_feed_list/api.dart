import 'dart:convert';
import 'package:aarongonzales01/features/user/social/model/get_following_list_model.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import 'package:aarongonzales01/networks/endpoints.dart';

final class GetFollowingFeedListApi {
  static final GetFollowingFeedListApi _singleton = GetFollowingFeedListApi._internal();
  GetFollowingFeedListApi._internal();
  static GetFollowingFeedListApi get instance => _singleton;

  Future<GetFollowingListModel> getFollowingFeedList({int? perPage, int? page}) async {
    try {
      Response response = await getHttp(Endpoints.followingsFeedList(perPage: perPage, page: page));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = GetFollowingListModel.fromRawJson(json.encode(response.data));
        return model;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
