import 'dart:developer';
import 'package:aarongonzales01/features/organizer/community/model/club_challenge_list_model.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/rx_base.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class ClubChallengeListRx extends RxResponseInt<ClubChallengeListModel> {
  final api = ClubChallengeListApi.instance;
  ClubChallengeListRx({required super.empty, required super.dataFetcher});
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<List<Challenge>> allChallenges = ValueNotifier([]);
  bool hasMore = true;
  ValueStream<ClubChallengeListModel> get getClubChallengeListData =>
      dataFetcher.stream;
  Future<bool> fetchClubChallengeList({
    String? slug,
    int? perPage,
    int page = 1,
  }) async {
    if (isLoading.value) return false;
    isLoading.value = true;

    try {
      final res = await api.getClubChallengeList(
        clubSlug: slug,
        perPage: perPage,
        page: page,
      );
      final newChallenges = res.data?.challenges ?? [];
      final pagination = res.data?.pagination;

      if (page == 1) {
        allChallenges.value = newChallenges;
      } else {
        allChallenges.value = [...allChallenges.value, ...newChallenges];
      }

      hasMore = (pagination?.currentPage ?? 1) < (pagination?.lastPage ?? 1);
      dataFetcher.sink.add(res);
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
      if (error.response!.statusCode == 400) {
        ToastUtil.showShortToast(error.response!.data["error"]);
      } else if (error.response!.statusCode == 401) {
      } else {
        ToastUtil.showShortToast(error.response!.data["error"]);
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}
