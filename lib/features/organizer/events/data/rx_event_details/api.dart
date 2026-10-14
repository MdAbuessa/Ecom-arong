import 'dart:convert';
import 'package:aarongonzales01/features/organizer/events/model/event_details_model.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import '/networks/endpoints.dart';

final class EventDetailsApi {
  static final EventDetailsApi _singleton = EventDetailsApi._internal();
  EventDetailsApi._internal();
  static EventDetailsApi get instance => _singleton;

  Future<EventDetailsModel> getEventDetails(String slug) async {
    try {
      Response response = await getHttp(Endpoints.eventDetails(slug));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = EventDetailsModel.fromRawJson(json.encode(response.data));
        return model;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
