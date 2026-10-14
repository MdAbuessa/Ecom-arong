import 'package:aarongonzales01/networks/rx_base.dart';
import 'package:flutter/foundation.dart';
import 'api.dart';

final class ChallengeDeleteRx extends RxResponseInt<Map<String, dynamic>> {
  final api = ChallengeDeleteApi.instance;

  ChallengeDeleteRx({required super.empty, required super.dataFetcher});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<bool> deleteChallengeRx(String challengeSlug) async {
    if (isLoading.value) return false;
    isLoading.value = true;

    try {
      final res = await api.deleteChallenge(challengeSlug);
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
