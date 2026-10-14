import 'package:aarongonzales01/networks/rx_base.dart';
import 'package:flutter/foundation.dart';
import 'api.dart';

final class SocialFeedCommentCreateRx extends RxResponseInt<Map<String, dynamic>> {
  final api = SocialFeedCommentCreateApi.instance;

  SocialFeedCommentCreateRx({required super.empty, required super.dataFetcher});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<bool> createCommentRx({
    required String postSlug,
    required String comment,
    int? parentId,
  }) async {
    if (isLoading.value) return false;
    isLoading.value = true;

    try {
      final res = await api.createComment(
        postSlug: postSlug,
        comment: comment,
        parentId: parentId,
      );
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
