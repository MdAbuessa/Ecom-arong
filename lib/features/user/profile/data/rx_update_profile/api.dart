import 'dart:convert';
import 'package:aarongonzales01/features/user/profile/model/update_profile_model.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import '/networks/endpoints.dart';

final class UpdateProfileApi {
  static final UpdateProfileApi _singleton = UpdateProfileApi._internal();
  UpdateProfileApi._internal();
  static UpdateProfileApi get instance => _singleton;

  Future<UpdateProfileModel> updateProfile({
    String? firstName,
    String? email,
    String? phone,
    String? location,
    String? gender,
    String? dateOfBirth,
    String? avatarPath,
  }) async {
    try {
      final Map<String, dynamic> formDataMap = {};

      if (firstName != null && firstName.isNotEmpty) {
        formDataMap["first_name"] = firstName;
      }
      if (email != null && email.isNotEmpty) {
        formDataMap["email"] = email;
      }
      if (phone != null && phone.isNotEmpty) {
        formDataMap["phone"] = phone;
      }
      if (location != null && location.isNotEmpty) {
        formDataMap["location"] = location;
      }
      if (gender != null && gender.isNotEmpty) {
        formDataMap["gender"] = gender;
      }
      if (dateOfBirth != null && dateOfBirth.isNotEmpty) {
        formDataMap["date_of_birth"] = dateOfBirth;
      }

      if (avatarPath != null && avatarPath.isNotEmpty) {
        formDataMap["avatar"] = await MultipartFile.fromFile(
          avatarPath,
          filename: avatarPath.split('/').last,
        );
      }

      final data = FormData.fromMap(formDataMap);

      Response response = await postHttp(Endpoints.updateProfile(), data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = UpdateProfileModel.fromRawJson(
          json.encode(response.data),
        );
        final String message =
            response.data['message'] ?? "Profile updated successfully.";
        ToastUtil.showShortToast(message);
        return model;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
