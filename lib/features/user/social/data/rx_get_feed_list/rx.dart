import 'dart:developer';
import 'package:aarongonzales01/features/user/social/model/get_feed_list_model.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/rx_base.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class GetFeedListRx extends RxResponseInt<GetFeedListModel> {
  final api = GetFeedListApi.instance;

  GetFeedListRx({required super.empty, required super.dataFetcher});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<bool> isLoadMore = ValueNotifier(false);

  int currentPage = 1;
  bool hasMoreData = true;

  ValueStream<GetFeedListModel> get getFeedListData => dataFetcher.stream;

  Future<void> fetchFeedList({
    int perPage = 10,
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
    }

    try {
      final res = await api.getFeedList(
        page: currentPage,
        perPage: perPage,
      );
      final newPosts = res.data?.posts ?? [];

      if (isLoadMoreAction) {
        if (newPosts.isEmpty) {
          hasMoreData = false;
        } else {
          final currentModel = dataFetcher.value;
          final updatedPosts = List<Post>.from(currentModel.data?.posts ?? [])..addAll(newPosts);
          final updatedData = currentModel.data?.copyWith(posts: updatedPosts) ?? Data(posts: updatedPosts);
          final updatedModel = currentModel.copyWith(data: updatedData);
          dataFetcher.sink.add(updatedModel);
          currentPage++;
          if (newPosts.length < perPage) {
            hasMoreData = false;
          }
        }
      } else {
        dataFetcher.sink.add(res);
        currentPage = 2;
        if (newPosts.length < perPage) {
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
