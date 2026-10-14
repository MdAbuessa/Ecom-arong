import 'package:aarongonzales01/features/organizer/community/model/all_comment_model.dart';
import 'package:aarongonzales01/networks/rx_base.dart';
import 'package:flutter/foundation.dart';
import 'api.dart';

final class SocialFeedCommentsRx extends RxResponseInt<AllCommentModel> {
  final api = SocialFeedCommentsApi.instance;
  SocialFeedCommentsRx({required super.empty, required super.dataFetcher});
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<bool> getCommentsRx(String postSlug) async {
    clean();
    if (isLoading.value) return false;
    isLoading.value = true;

    try {
      final res = await api.getComments(postSlug);
      dataFetcher.sink.add(res);
      return true;
    } catch (error) {
      handleErrorWithReturn(error);
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
