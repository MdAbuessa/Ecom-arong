import 'package:aarongonzales01/features/organizer/community/model/club_show_model.dart';
import 'package:aarongonzales01/networks/rx_base.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class ClubShowRx extends RxResponseInt<ClubShowModel> {
  final api = ClubShowApi.instance;

  ClubShowRx({required super.empty, required super.dataFetcher});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  ValueStream<ClubShowModel> get getClubShowData => dataFetcher.stream;

  Future<void> fetchClubShow(String slug) async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final res = await api.getClubShow(slug);
      dataFetcher.sink.add(res);
    } catch (error) {
      handleErrorWithReturn(error);
    } finally {
      isLoading.value = false;
    }
  }
}
