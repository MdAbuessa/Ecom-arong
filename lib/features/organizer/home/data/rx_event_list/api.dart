import 'dart:convert';
import 'package:aarongonzales01/features/organizer/home/model/event_list_model.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import '/networks/endpoints.dart';

final class EventListApi {
  static final EventListApi _singleton = EventListApi._internal();
  EventListApi._internal();
  static EventListApi get instance => _singleton;

  Future<EventListModel> getEventList({String? query, String? status, int? page, int? perPage}) async {
    try {
      Response response = await getHttp(Endpoints.eventList(query: query, status: status, page: page, perPage: perPage));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = EventListModel.fromRawJson(json.encode(response.data));
        return model;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
