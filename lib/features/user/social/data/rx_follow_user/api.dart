import 'dart:convert';
import 'package:aarongonzales01/features/user/social/model/user_follow_model.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/endpoints.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class FollowUserApi {
  static final FollowUserApi _singleton = FollowUserApi._internal();
  FollowUserApi._internal();
  static FollowUserApi get instance => _singleton;

  Future<UserFollowModel> followUser(String slug) async {
    try {
      Response response = await postHttp(Endpoints.followUser(slug));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = UserFollowModel.fromRawJson(json.encode(response.data));
        return model;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
