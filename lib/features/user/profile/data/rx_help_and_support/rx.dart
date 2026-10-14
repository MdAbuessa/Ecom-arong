import 'dart:developer';
import 'package:aarongonzales01/features/user/profile/model/help_and_support_model.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/rx_base.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class HelpAndSupportRx extends RxResponseInt<HelpAndSupportModel> {
  final api = HelpAndSupportApi.instance;

  HelpAndSupportRx({required super.empty, required super.dataFetcher});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  ValueStream<HelpAndSupportModel> get helpAndSupportData =>
      dataFetcher.stream;

  Future<HelpAndSupportModel?> fetchHelpAndSupport() async {
    isLoading.value = true;
    try {
      final data = await api.fetchHelpAndSupport();
      handleSuccessWithReturn(data);
      return data;
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
