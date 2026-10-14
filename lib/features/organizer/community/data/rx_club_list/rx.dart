import 'package:aarongonzales01/features/organizer/community/model/club_list_model.dart';
import 'package:aarongonzales01/networks/rx_base.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class ClubListRx extends RxResponseInt<ClubListModel> {
  final api = ClubListApi.instance;

  ClubListRx({required super.empty, required super.dataFetcher});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<bool> isLoadMore = ValueNotifier(false);

  int currentPage = 1;
  bool hasMoreData = true;
  String currentQuery = "";

  ValueStream<ClubListModel> get getClubListData => dataFetcher.stream;

  Future<void> fetchClubList(String query, {bool isLoadMoreAction = false}) async {
    if (isLoadMoreAction) {
      if (isLoadMore.value || !hasMoreData) return;
      isLoadMore.value = true;
    } else {
      if (isLoading.value) return;
      isLoading.value = true;
      currentPage = 1;
      hasMoreData = true;
      currentQuery = query;
    }

    try {
      final res = await api.getClubList(currentQuery, currentPage);
      final newClubs = res.data?.clubs ?? [];

      if (isLoadMoreAction) {
        if (newClubs.isEmpty) {
          hasMoreData = false;
        } else {
          final currentModel = dataFetcher.value;
          final updatedClubs = List<Club>.from(currentModel.data?.clubs ?? [])..addAll(newClubs);
          final updatedData = currentModel.data?.copyWith(clubs: updatedClubs) ?? Data(clubs: updatedClubs);
          final updatedModel = currentModel.copyWith(data: updatedData);
          dataFetcher.sink.add(updatedModel);
          currentPage++;
          if (newClubs.length < 20) {
            hasMoreData = false;
          }
        }
      } else {
        dataFetcher.sink.add(res);
        currentPage = 2;
        if (newClubs.length < 20) {
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
}
