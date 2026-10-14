import 'dart:developer';
import 'package:aarongonzales01/features/organizer/events/model/event_details_model.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/rx_base.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class EventDetailsRx extends RxResponseInt<EventDetailsModel> {
  final api = EventDetailsApi.instance;

  EventDetailsRx({required super.empty, required super.dataFetcher});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  ValueStream<EventDetailsModel> get getEventDetailsData => dataFetcher.stream;

  Future<void> fetchEventDetails(String slug) async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final res = await api.getEventDetails(slug);
      dataFetcher.sink.add(res);
    } catch (error) {
      handleErrorWithReturn(error);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionError ||
          error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        ToastUtil.showNoInternetToast();
        log(error.toString());
        dataFetcher.sink.addError(error);
        return;
      }
      final responseData = error.response?.data;
      if (responseData is Map<String, dynamic>) {
        if (responseData.containsKey('errors')) {
          final errors = responseData['errors'];
          if (errors is List && errors.isNotEmpty) {
            final firstError = errors.first;
            if (firstError is List && firstError.isNotEmpty) {
              ToastUtil.showShortToast(firstError.first.toString());
              log(error.toString());
              dataFetcher.sink.addError(error);
              return;
            } else if (firstError != null) {
              ToastUtil.showShortToast(firstError.toString());
              log(error.toString());
              dataFetcher.sink.addError(error);
              return;
            }
          } else if (errors is Map && errors.isNotEmpty) {
            final firstErrorList = errors.values.first;
            if (firstErrorList is List && firstErrorList.isNotEmpty) {
              ToastUtil.showShortToast(firstErrorList.first.toString());
              log(error.toString());
              dataFetcher.sink.addError(error);
              return;
            }
          }
        }
        final message = responseData['message'];
        if (message != null && message.toString().isNotEmpty) {
          ToastUtil.showShortToast(message.toString());
          log(error.toString());
          dataFetcher.sink.addError(error);
          return;
        }
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
  }
}
