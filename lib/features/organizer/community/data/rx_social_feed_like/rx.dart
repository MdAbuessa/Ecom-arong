import 'package:aarongonzales01/networks/rx_base.dart';
import 'package:flutter/foundation.dart';
import 'api.dart';

final class SocialFeedLikeRx extends RxResponseInt<Map<String, dynamic>> {
  final api = SocialFeedLikeApi.instance;

  SocialFeedLikeRx({required super.empty, required super.dataFetcher});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<bool> likeSocialFeedRx(String postSlug) async {
    if (isLoading.value) return false;
    isLoading.value = true;

    try {
      final res = await api.likeSocialFeed(postSlug);
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
