import 'package:aarongonzales01/features/organizer/community/model/update_club_model.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/rx_base.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class UpdateClubRx extends RxResponseInt<UpdateClubModel> {
  final api = UpdateClubApi.instance;

  UpdateClubRx({required super.empty, required super.dataFetcher});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  ValueStream<UpdateClubModel> get getUpdateClubData => dataFetcher.stream;

  Future<UpdateClubModel?> updateClub({
    required String clubSlug,
    required String name,
    required String topicSlug,
    required String location,
    String? description,
    String? coverPhotoPath,
    String? avatarPhotoPath,
    Map<String, String>? socialLinks,
  }) async {
    isLoading.value = true;
    try {
      final data = await api.updateClub(
        clubSlug: clubSlug,
        name: name,
        topicSlug: topicSlug,
        location: location,
        description: description,
        coverPhotoPath: coverPhotoPath,
        avatarPhotoPath: avatarPhotoPath,
        socialLinks: socialLinks,
      );
      handleSuccessWithReturn(data);
      if (data.message != null && data.message!.isNotEmpty) {
        ToastUtil.showShortToast(data.message!);
      } else {
        ToastUtil.showShortToast("Club updated successfully");
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
