import 'dart:developer';
import 'package:aarongonzales01/features/user/club_details/model/club_details_model.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/rx_base.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class ClubDetailsRx extends RxResponseInt<ClubDetailsModel> {
  final api = ClubDetailsApi.instance;

  ClubDetailsRx({required super.empty, required super.dataFetcher});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  ValueStream<ClubDetailsModel> get getClubDetailsData => dataFetcher.stream;

  Future<ClubDetailsModel?> getClubDetails(String slug) async {
    if (isLoading.value) return null;
    isLoading.value = true;

    try {
      final res = await api.getClubDetails(slug);
      dataFetcher.sink.add(res);
      return res;
      // Note: we can also log or show toast if needed, but this is a get request
    } catch (error) {
      handleErrorWithReturn(error);
      return null;
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
