// ignore_for_file: curly_braces_in_flow_control_structures, constant_identifier_names, unnecessary_string_interpolations

const String url = "https://admin.racerealm.com/api";
const String imageUrl = url;

final class NetworkConstants {
  NetworkConstants._();
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

final class Endpoints {
  Endpoints._();
  // --------------------- Azizul Hakim -----------------
  static String register() => "/auth/register";
  static String refreshToken() => "/auth/refresh";
  static String registerVerifyOtp() => "/auth/verify-otp";
  static String resendOtp() => "/auth/resend-otp";
  static String login() => "/auth/login";
  static String logout() => "/auth/logout";
  static String deleteAccount() => "/user/delete-account";
  static String forgetPassword() => "/auth/forget-password";
  static String forgetPasswordVerifyOtp() => "/auth/verify-otp";
  static String resetPassword() => "/auth/reset-password";
  static String chooseRole() => "/user/update-profile";
  static String updatePassword() => "/user/update-password"; 
  static String getUserInfo() => "/user/user-info";
  static String privacyPolicy() => "/privacy-policy";
  static String helpAndSupport() => "/help-and-support";
  static String termsAndConditions() => "/terms-and-conditions";
  static String updateProfile() => "/user/update-profile";
  static String getFeedList({int? perPage, int? page}) {
    String endpoint = "/v1/posts";
    final List<String> params = [];
    if (perPage != null) params.add("per_page=$perPage");
    if (page != null) params.add("page=$page");
    if (params.isNotEmpty) {
      endpoint += "?${params.join("&")}";
    }
    return endpoint;
  }
  static String followUser(String postCreatorSlug) =>
      "/v1/users/$postCreatorSlug/follow";
  static String followingsFeedList({int? perPage, int? page}) {
    String endpoint = "/v1/posts?scope=following_only";
    if (perPage != null) endpoint += "&per_page=$perPage";
    if (page != null) endpoint += "&page=$page";
    return endpoint;
  }

  static String getClubList({int? perPage}) {
    String endpoint = "/v1/clubs/browse";
    if (perPage != null) endpoint += "?per_page=$perPage";
    return endpoint;
  }
  static String joinClub(String clubSlug) => "/v1/clubs/$clubSlug/join";
  static String showClub(String clubSlug) => "/v1/clubs/browse/$clubSlug";

  static String showClubBrowse(String clubSlug) => "/v1/clubs/browse/$clubSlug";
  // --------------------- Azizul Hakim -----------------

  static String createEvent() => "/v1/events";
  static String clubCategoryList() => "/v1/clubs/categories";
  static String createClub() => "/v1/clubs";
  static String updateClub(String clubSlug) => "/v1/clubs/$clubSlug";
  static String clubList(String query, int page) =>
      "/v1/clubs?query=$query&page=$page&per_page=20";
  static String deleteClub(String clubSlug) => "/v1/clubs/$clubSlug";
  static String eventDetails(String eventSlug) => "/v1/events/$eventSlug";
  static String updateEvent(String eventSlug) => "/v1/events/$eventSlug";
  static String deleteEvent(String eventSlug) => "/v1/events/$eventSlug";
  static String clubShow(String clubSlug) => "/v1/clubs/$clubSlug";
  static String createSocialFeed() => "/v1/posts";
  static String deleteSocialFeed(String postSlug) => "/v1/posts/$postSlug";
  static String likeSocialFeed(String postSlug) => "/v1/posts/$postSlug/like";
  static String allComments(String postSlug) => "/v1/posts/$postSlug/comments";

  static String clubChallengeList({String? clubSlug, int? perPage, int? page}) {
    String endpoint = "/v1/clubs/$clubSlug/challenges";
    Map<String, dynamic> queryParams = {};
    if (perPage != null) queryParams['per_page'] = perPage;
    if (page != null) queryParams['page'] = page;
    if (queryParams.isNotEmpty) {
      final queryString = queryParams.entries
          .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
          .join('&');
      endpoint += '?$queryString';
    }
    return endpoint;
  }

  static String createChallenge(String clubSlug) =>
      "/v1/clubs/$clubSlug/challenges";
  static String deleteChallenge(String clubSlug) => "/v1/challenges/$clubSlug";

  // static String socialFeedList({int? page, int? perPage}) {
  //   final queryParams = <String>[];
  //   if (page != null) {
  //     queryParams.add('page=$page');
  //   }
  //   if (perPage != null) {
  //     queryParams.add('per_page=$perPage');
  //   }
  //   final queryString =
  //       queryParams.isNotEmpty ? '?${queryParams.join('&')}' : '';
  //   return '/v1/posts$queryString';
  // }
  //

  static String socialFeedList({int? perPage, String? clubSlug, int? page}) {
    String endpoint = "/v1/posts";
    Map<String, dynamic> queryParams = {};
    if (perPage != null) queryParams['per_page'] = perPage;
    if (clubSlug != null && clubSlug.isNotEmpty)
      queryParams['club_slug'] = clubSlug;
    if (page != null) queryParams['page'] = page;
    if (queryParams.isNotEmpty) {
      final queryString = queryParams.entries
          .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
          .join('&');
      endpoint += '?$queryString';
    }
    return endpoint;
  }

  //

  static String eventList({
    String? query,
    String? status,
    int? page,
    int? perPage,
  }) {
    final List<String> params = [];
    if (query != null && query.isNotEmpty) {
      params.add("query=$query");
    }
    if (status != null && status.isNotEmpty) {
      params.add("status=$status");
    }
    if (page != null) {
      params.add("page=$page");
    }
    if (perPage != null) {
      params.add("per_page=$perPage");
    }
    return "/v1/events${params.isEmpty ? '' : '?${params.join('&')}'}";
  }
}
