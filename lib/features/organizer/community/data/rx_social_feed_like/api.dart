import 'dart:convert';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/endpoints.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class SocialFeedLikeApi {
  static final SocialFeedLikeApi _singleton = SocialFeedLikeApi._internal();
  SocialFeedLikeApi._internal();
  static SocialFeedLikeApi get instance => _singleton;

  Future<Map<String, dynamic>> likeSocialFeed(String postSlug) async {
    try {
      Response response = await postHttp(Endpoints.likeSocialFeed(postSlug));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = response.data is Map<String, dynamic>
            ? response.data as Map<String, dynamic>
            : json.decode(json.encode(response.data)) as Map<String, dynamic>;
        return responseData;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
