import 'dart:convert';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import '/networks/endpoints.dart';

final class SocialFeedCreateApi {
  static final SocialFeedCreateApi _singleton = SocialFeedCreateApi._internal();
  SocialFeedCreateApi._internal();
  static SocialFeedCreateApi get instance => _singleton;

  Future<Map<String, dynamic>> createSocialFeed({
    required String clubSlug,
    required String caption,
    List<String>? imagePaths,
    List<String>? videoPaths,
  }) async {
    try {
      final Map<String, dynamic> formDataMap = {
        "club_slug": clubSlug,
        "caption": caption,
      };

      if (imagePaths != null && imagePaths.isNotEmpty) {
        final List<MultipartFile> imageFiles = [];
        for (final path in imagePaths) {
          imageFiles.add(await MultipartFile.fromFile(
            path,
            filename: path.split('/').last,
          ));
        }
        formDataMap["images[]"] = imageFiles;
      }

      if (videoPaths != null && videoPaths.isNotEmpty) {
        final List<MultipartFile> videoFiles = [];
        for (final path in videoPaths) {
          videoFiles.add(await MultipartFile.fromFile(
            path,
            filename: path.split('/').last,
          ));
        }
        formDataMap["videos[]"] = videoFiles;
      }

      final data = FormData.fromMap(formDataMap);

      Response response = await postHttp(Endpoints.createSocialFeed(), data);

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
