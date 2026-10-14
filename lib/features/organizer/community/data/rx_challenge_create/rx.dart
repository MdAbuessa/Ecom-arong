import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/rx_base.dart';
import 'package:flutter/foundation.dart';
import 'api.dart';

final class ChallengeCreateRx extends RxResponseInt<Map<String, dynamic>> {
  final api = ChallengeCreateApi.instance;

  ChallengeCreateRx({required super.empty, required super.dataFetcher});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<bool> createChallengeRx({
    required String clubSlug,
    required String title,
    required String description,
    required String goalType,
    required String goalValue,
    required String startDate,
    required String endDate,
    String? thumbnailPath,
  }) async {
    if (isLoading.value) return false;
    isLoading.value = true;

    try {
      final res = await api.createChallenge(
        clubSlug: clubSlug,
        title: title,
        description: description,
        goalType: goalType,
        goalValue: goalValue,
        startDate: startDate,
        endDate: endDate,
        thumbnailPath: thumbnailPath,
      );
      dataFetcher.sink.add(res);
      ToastUtil.showShortToast("Challenge created successfully");
      return true;
    } catch (error) {
      handleErrorWithReturn(error);
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
