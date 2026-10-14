import 'dart:convert';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/endpoints.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class SocialFeedCommentCreateApi {
  static final SocialFeedCommentCreateApi _singleton = SocialFeedCommentCreateApi._internal();
  SocialFeedCommentCreateApi._internal();
  static SocialFeedCommentCreateApi get instance => _singleton;

  Future<Map<String, dynamic>> createComment({
    required String postSlug,
    required String comment,
    int? parentId,
  }) async {
    try {
      final Map<String, dynamic> body = {
        "comment": comment,
      };
      if (parentId != null) {
        body["parent_id"] = parentId;
      }

      Response response = await postHttp(Endpoints.allComments(postSlug), body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = response.data is Map<String, dynamic>
            ? response.data as Map<String, dynamic>
            : json.decode(response.data.toString()) as Map<String, dynamic>;
        return responseData;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
