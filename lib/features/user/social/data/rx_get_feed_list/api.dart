import 'dart:convert';
import 'package:aarongonzales01/features/user/social/model/get_feed_list_model.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import 'package:aarongonzales01/networks/endpoints.dart';

final class GetFeedListApi {
  static final GetFeedListApi _singleton = GetFeedListApi._internal();
  GetFeedListApi._internal();
  static GetFeedListApi get instance => _singleton;

  Future<GetFeedListModel> getFeedList({int? perPage, int? page}) async {
    try {
      Response response = await getHttp(Endpoints.getFeedList(perPage: perPage, page: page));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = GetFeedListModel.fromRawJson(json.encode(response.data));
        return model;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
