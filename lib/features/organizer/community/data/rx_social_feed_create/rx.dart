import 'dart:developer';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/rx_base.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'api.dart';

final class SocialFeedCreateRx extends RxResponseInt<Map<String, dynamic>> {
  final api = SocialFeedCreateApi.instance;

  SocialFeedCreateRx({required super.empty, required super.dataFetcher});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<bool> createSocialFeedRx({
    required String clubSlug,
    required String caption,
    List<String>? imagePaths,
    List<String>? videoPaths,
  }) async {
    if (isLoading.value) return false;
    isLoading.value = true;

    try {
      final res = await api.createSocialFeed(
        clubSlug: clubSlug,
        caption: caption,
        imagePaths: imagePaths,
        videoPaths: videoPaths,
      );
      dataFetcher.sink.add(res);
      ToastUtil.showShortToast("Feed post created successfully");
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
      if (error.response?.statusCode == 400) {
        ToastUtil.showShortToast(error.response?.data["error"] ?? "Bad request");
      } else if (error.response?.statusCode == 401) {
        // Unauthorized
      } else {
        ToastUtil.showShortToast(error.response?.data["error"] ?? "Something went wrong");
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
  }
}
