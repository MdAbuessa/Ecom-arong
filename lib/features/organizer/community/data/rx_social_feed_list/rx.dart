import 'dart:developer';
import 'package:aarongonzales01/features/organizer/community/data/rx_social_feed_list/api.dart';
import 'package:aarongonzales01/features/organizer/community/model/social_feed_list_model.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/foundation.dart';

final class SocialFeedListRX extends RxResponseInt<SocialFeedListModel> {
  final api = SocialFeedListApi.instance;
  SocialFeedListRX({required super.empty, required super.dataFetcher});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  // all of new posts stay here
  final ValueNotifier<List<Post>> allPosts = ValueNotifier([]);
  bool hasMore = true;
  ValueStream<SocialFeedListModel> get socialFeedListStream =>
      dataFetcher.stream;
  Future<bool> getSocialFeedList({
    int? perPage,
    String? clubSlug,
    int page = 1,
  }) async {
    if (isLoading.value) return false;
    isLoading.value = true;
    try {
      SocialFeedListModel data = await api.getSocialFeedList(
        perPage: perPage,
        clubSlug: clubSlug,
        page: page,
      );
      final newPosts = data.data?.posts ?? [];
      final pagination = data.data?.pagination;
      //if page 1 the clean otherwise append
      if (page == 1) {
        allPosts.value = newPosts;
      } else {
        allPosts.value = [...allPosts.value, ...newPosts];
      }
      //data have or not check it
      hasMore = (pagination?.currentPage ?? 1) < (pagination?.lastPage ?? 1);
      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response!.statusCode == 400) {
        ToastUtil.showShortToast(error.response!.data["error"]);
      } else if (error.response!.statusCode == 401) {
      } else {
        ToastUtil.showShortToast(error.response!.data["error"]);
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    // throw error;
    return false;
  }
}
