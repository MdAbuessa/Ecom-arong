import 'package:aarongonzales01/features/organizer/community/model/club_delete_model.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/rx_base.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class DeleteClubRx extends RxResponseInt<ClubDeleteModel> {
  final api = DeleteClubApi.instance;

  DeleteClubRx({required super.empty, required super.dataFetcher});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  ValueStream<ClubDeleteModel> get getDeleteClubData => dataFetcher.stream;

  Future<ClubDeleteModel?> deleteClub(String clubSlug) async {
    isLoading.value = true;
    try {
      final data = await api.deleteClub(clubSlug);
      handleSuccessWithReturn(data);
      if (data.message != null && data.message!.isNotEmpty) {
        ToastUtil.showShortToast(data.message!);
      } else {
        ToastUtil.showShortToast("Club deleted successfully");
      }
      return data;
    } catch (error) {
      handleErrorWithReturn(error);
      return null;
    } finally {
      isLoading.value = false;
    }
  }
}
