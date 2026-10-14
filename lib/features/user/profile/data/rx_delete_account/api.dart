import 'dart:convert';
import 'package:aarongonzales01/features/user/profile/model/delete_account_model.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import '/networks/endpoints.dart';

final class DeleteAccountApi {
  static final DeleteAccountApi _singleton = DeleteAccountApi._internal();
  DeleteAccountApi._internal();
  static DeleteAccountApi get instance => _singleton;

  Future<DeleteAccountModel> deleteAccount() async {
    try {
      Response response = await deleteHttp(Endpoints.deleteAccount(), {});

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = DeleteAccountModel.fromRawJson(json.encode(response.data));
        final String message = response.data['message'] ?? "Account deleted successfully.";
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
