import 'dart:convert';
import 'package:aarongonzales01/features/organizer/community/model/create_club_model.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import '/networks/endpoints.dart';

final class CreateClubApi {
  static final CreateClubApi _singleton = CreateClubApi._internal();
  CreateClubApi._internal();
  static CreateClubApi get instance => _singleton;

  Future<CreateClubModel> createClub({
    required String name,
    required String topicSlug,
    required String location,
    String? description,
    String? coverPhotoPath,
    String? avatarPhotoPath,
    Map<String, String>? socialLinks,
  }) async {
    try {
      final Map<String, dynamic> formDataMap = {
        "name": name,
        "topic_slug": topicSlug,
        "location": location,
      };

      if (description != null && description.isNotEmpty) {
        formDataMap["description"] = description;
      }

      if (avatarPhotoPath != null && avatarPhotoPath.isNotEmpty) {
        formDataMap["avatar_photo"] = await MultipartFile.fromFile(
          avatarPhotoPath,
          filename: avatarPhotoPath.split('/').last,
        );
      }

      if (coverPhotoPath != null && coverPhotoPath.isNotEmpty) {
        formDataMap["cover_photo"] = await MultipartFile.fromFile(
          coverPhotoPath,
          filename: coverPhotoPath.split('/').last,
        );
      }

      if (socialLinks != null) {
        socialLinks.forEach((key, val) {
          if (val.isNotEmpty) {
            formDataMap["social_links[$key]"] = val;
          }
        });
      }

      final data = FormData.fromMap(formDataMap);

      Response response = await postHttp(Endpoints.createClub(), data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = CreateClubModel.fromRawJson(json.encode(response.data));
        return model;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
