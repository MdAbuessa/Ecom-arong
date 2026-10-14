import 'dart:convert';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/endpoints.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class SocialFeedDeleteApi {
  static final SocialFeedDeleteApi _singleton = SocialFeedDeleteApi._internal();
  SocialFeedDeleteApi._internal();
  static SocialFeedDeleteApi get instance => _singleton;

  Future<Map<String, dynamic>> deleteSocialFeed(String postSlug) async {
    try {
      Response response = await deleteHttp(Endpoints.deleteSocialFeed(postSlug));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = response.data is Map<String, dynamic>
            ? response.data
            : json.decode(response.data.toString());
        final String message = data['message'] ?? "Feed post deleted successfully.";
        ToastUtil.showShortToast(message);
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
