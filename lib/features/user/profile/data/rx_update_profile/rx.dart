// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:aarongonzales01/features/user/profile/model/update_profile_model.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/rx_base.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class UpdateProfileRx extends RxResponseInt<UpdateProfileModel> {
  final api = UpdateProfileApi.instance;

  UpdateProfileRx({required super.empty, required super.dataFetcher});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  ValueStream<UpdateProfileModel> get getFileData => dataFetcher.stream;

  Future<bool> updateProfileRx({
    String? firstName,
    String? email,
    String? phone,
    String? location,
    String? gender,
    String? dateOfBirth,
    String? avatarPath,
  }) async {
    isLoading.value = true;
    try {
      final data = await api.updateProfile(
        firstName: firstName,
        email: email,
        phone: phone,
        location: location,
        gender: gender,
        dateOfBirth: dateOfBirth,
        avatarPath: avatarPath,
      );
      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      handleErrorWithReturn(error);
      return false;
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
