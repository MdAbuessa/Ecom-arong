import 'dart:developer';
import 'package:aarongonzales01/features/organizer/home/model/event_list_model.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/rx_base.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class EventListRx extends RxResponseInt<EventListModel> {
  final api = EventListApi.instance;

  EventListRx({required super.empty, required super.dataFetcher});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<bool> isLoadMore = ValueNotifier(false);

  int currentPage = 1;
  bool hasMoreData = true;
  String currentQuery = "";
  String? currentStatus;

  ValueStream<EventListModel> get getEventListData => dataFetcher.stream;

  Future<void> fetchEventList({
    String query = "",
    String? status,
    int perPage = 20,
    bool isLoadMoreAction = false,
  }) async {
    if (isLoadMoreAction) {
      if (isLoadMore.value || !hasMoreData) return;
      isLoadMore.value = true;
    } else {
      if (isLoading.value) return;
      isLoading.value = true;
      currentPage = 1;
      hasMoreData = true;
      currentQuery = query;
      currentStatus = status;
    }

    try {
      final res = await api.getEventList(
        query: currentQuery,
        status: currentStatus,
        page: currentPage,
        perPage: perPage,
      );
      final newEvents = res.data?.events ?? [];

      if (isLoadMoreAction) {
        if (newEvents.isEmpty) {
          hasMoreData = false;
        } else {
          final currentModel = dataFetcher.value;
          final updatedEvents = List<Event>.from(currentModel.data?.events ?? [])..addAll(newEvents);
          final updatedData = currentModel.data?.copyWith(events: updatedEvents) ?? Data(events: updatedEvents);
          final updatedModel = currentModel.copyWith(data: updatedData);
          dataFetcher.sink.add(updatedModel);
          currentPage++;
          if (newEvents.length < perPage) {
            hasMoreData = false;
          }
        }
      } else {
        dataFetcher.sink.add(res);
        currentPage = 2;
        if (newEvents.length < perPage) {
          hasMoreData = false;
        }
      }
    } catch (error) {
      handleErrorWithReturn(error);
    } finally {
      if (isLoadMoreAction) {
        isLoadMore.value = false;
      } else {
        isLoading.value = false;
      }
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
