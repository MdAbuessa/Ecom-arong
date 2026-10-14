import 'dart:convert';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import '/networks/endpoints.dart';

final class ChallengeCreateApi {
  static final ChallengeCreateApi _singleton = ChallengeCreateApi._internal();
  ChallengeCreateApi._internal();
  static ChallengeCreateApi get instance => _singleton;

  Future<Map<String, dynamic>> createChallenge({
    required String clubSlug,
    required String title,
    required String description,
    required String goalType,
    required String goalValue,
    required String startDate,
    required String endDate,
    String? thumbnailPath,
  }) async {
    try {
      final Map<String, dynamic> formDataMap = {
        "title": title,
        "description": description,
        "goal_type": goalType,
        "goal_value": goalValue,
        "start_date": startDate,
        "end_date": endDate,
      };

      if (thumbnailPath != null && thumbnailPath.isNotEmpty) {
        formDataMap["thumbnail"] = await MultipartFile.fromFile(
          thumbnailPath,
          filename: thumbnailPath.split('/').last,
        );
      }

      final data = FormData.fromMap(formDataMap);

      Response response = await postHttp(Endpoints.createChallenge(clubSlug), data);

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
