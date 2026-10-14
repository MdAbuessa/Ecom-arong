import 'dart:convert';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/endpoints.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class EventDeleteApi {
  static final EventDeleteApi _singleton = EventDeleteApi._internal();
  EventDeleteApi._internal();
  static EventDeleteApi get instance => _singleton;

  Future<Map<String, dynamic>> deleteEvent(String slug) async {
    try {
      Response response = await deleteHttp(Endpoints.deleteEvent(slug));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = response.data is Map<String, dynamic>
            ? response.data
            : json.decode(response.data.toString());
        final String message = data['message'] ?? "Event deleted successfully.";
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
