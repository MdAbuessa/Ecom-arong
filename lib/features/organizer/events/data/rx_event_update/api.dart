import 'dart:convert';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/endpoints.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class EventUpdateApi {
  static final EventUpdateApi _singleton = EventUpdateApi._internal();
  EventUpdateApi._internal();
  static EventUpdateApi get instance => _singleton;

  Future<Map<String, dynamic>> updateEvent(String slug, FormData formData) async {
    try {
      formData.fields.add(MapEntry("_method", "PUT"));

      Response response = await postHttp(Endpoints.updateEvent(slug), formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = response.data is Map<String, dynamic>
            ? response.data
            : json.decode(response.data.toString());
        final String message = data['message'] ?? "Event updated successfully.";
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
