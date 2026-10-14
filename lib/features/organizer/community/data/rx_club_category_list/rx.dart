import 'package:aarongonzales01/features/organizer/community/model/club_category_list_model.dart';
import 'package:aarongonzales01/networks/rx_base.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class ClubCategoryListRx extends RxResponseInt<ClubCategoryListModel> {
  final api = ClubCategoryListApi.instance;

  ClubCategoryListRx({required super.empty, required super.dataFetcher});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  ValueStream<ClubCategoryListModel> get getClubCategoryListData =>
      dataFetcher.stream;

  Future<ClubCategoryListModel?> fetchClubCategoryList() async {
    isLoading.value = true;
    try {
      final data = await api.getClubCategoryList();
      handleSuccessWithReturn(data);
      return data;
    } catch (error) {
      handleErrorWithReturn(error);
      return null;
    } finally {
      isLoading.value = false;
    }
  }
}
