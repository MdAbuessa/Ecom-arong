import 'dart:convert';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/endpoints.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:aarongonzales01/features/organizer/community/model/all_comment_model.dart';
import 'package:dio/dio.dart';

final class SocialFeedCommentsApi {
  static final SocialFeedCommentsApi _singleton = SocialFeedCommentsApi._internal();
  SocialFeedCommentsApi._internal();
  static SocialFeedCommentsApi get instance => _singleton;

  Future<AllCommentModel> getComments(String postSlug) async {
    try {
      Response response = await getHttp(Endpoints.allComments(postSlug));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = response.data is Map<String, dynamic>
            ? response.data as Map<String, dynamic>
            : json.decode(response.data.toString()) as Map<String, dynamic>;
        return AllCommentModel.fromJson(responseData);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
