import 'dart:convert';
import 'package:aarongonzales01/features/organizer/community/model/update_club_model.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import '/networks/endpoints.dart';

final class UpdateClubApi {
  static final UpdateClubApi _singleton = UpdateClubApi._internal();
  UpdateClubApi._internal();
  static UpdateClubApi get instance => _singleton;

  Future<UpdateClubModel> updateClub({
    required String clubSlug,
    required String name,
    required String topicSlug,
    required String location,
    String? description,
    String? coverPhotoPath,
    String? avatarPhotoPath,
    Map<String, String>? socialLinks,
  }) async {
    try {
      final Map<String, dynamic> fields = {
        '_method': 'PUT',
        'name': name,
        'topic_slug': topicSlug,
        'location': location,
      };

      if (description != null && description.isNotEmpty) {
        fields['description'] = description;
      }

      if (socialLinks != null) {
        socialLinks.forEach((key, value) {
          fields['social_links[$key]'] = value;
        });
      }

      if (avatarPhotoPath != null && avatarPhotoPath.isNotEmpty) {
        fields['avatar_photo'] = await MultipartFile.fromFile(
          avatarPhotoPath,
          filename: avatarPhotoPath.split('/').last,
        );
      }

      if (coverPhotoPath != null && coverPhotoPath.isNotEmpty) {
        fields['cover_photo'] = await MultipartFile.fromFile(
          coverPhotoPath,
          filename: coverPhotoPath.split('/').last,
        );
      }

      FormData formData = FormData.fromMap(fields);

      Response response = await postHttp(
        Endpoints.updateClub(clubSlug),
        formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = UpdateClubModel.fromRawJson(json.encode(response.data));
        return model;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
