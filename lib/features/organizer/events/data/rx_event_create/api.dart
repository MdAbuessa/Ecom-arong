import 'dart:convert';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/endpoints.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class EventCreateApi {
  static final EventCreateApi _singleton = EventCreateApi._internal();
  EventCreateApi._internal();
  static EventCreateApi get instance => _singleton;

  Future<Map<String, dynamic>> createEvent(FormData formData) async {
    try {
      Response response = await postHttp(Endpoints.createEvent(), formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = response.data is Map<String, dynamic>
            ? response.data
            : json.decode(response.data.toString());
        final String message = data['message'] ?? "Event created successfully.";
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
