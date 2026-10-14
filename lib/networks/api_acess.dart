import 'package:aarongonzales01/features/auth/register/data/rx_register/rx.dart';
import 'package:aarongonzales01/features/auth/register/model/register_model.dart';
import 'package:aarongonzales01/features/auth/register/data/rx_register_verify_otp/rx.dart';
import 'package:aarongonzales01/features/auth/register/model/register_verify_otp_model.dart';
import 'package:aarongonzales01/features/auth/login/data/rx_login/rx.dart';
import 'package:aarongonzales01/features/auth/login/model/login_model.dart';
import 'package:aarongonzales01/features/auth/forget_password/data/rx_forget_password/rx.dart';
import 'package:aarongonzales01/features/auth/forget_password/model/forget_password_model.dart';
import 'package:aarongonzales01/features/auth/forget_password_verify_otp/data/rx_forget_password_verify_otp/rx.dart';
import 'package:aarongonzales01/features/auth/forget_password_verify_otp/model/forget_password_otp_verify_model.dart';
import 'package:aarongonzales01/features/auth/forget_password_verify_otp/data/rx_resend_otp/rx.dart';
import 'package:aarongonzales01/features/auth/forget_password_verify_otp/model/resend_otp_model.dart';
import 'package:aarongonzales01/features/auth/update_password/data/rx_reset_password/rx.dart';
import 'package:aarongonzales01/features/auth/update_password/model/reset_password_model.dart';
import 'package:aarongonzales01/features/auth/choose_role/data/rx.dart';
import 'package:aarongonzales01/features/auth/choose_role/model/choose_role_model.dart';
import 'package:aarongonzales01/features/user/profile/data/rx_logout/rx.dart';
import 'package:aarongonzales01/features/user/profile/model/logout_model.dart';
import 'package:aarongonzales01/features/user/profile/data/rx_delete_account/rx.dart';
import 'package:aarongonzales01/features/user/profile/model/delete_account_model.dart';
import 'package:aarongonzales01/features/user/profile/data/rx_change_password/rx.dart';
import 'package:aarongonzales01/features/user/profile/model/change_password_model.dart';
import 'package:aarongonzales01/features/user/profile/data/rx_get_user_info/rx.dart';
import 'package:aarongonzales01/features/user/profile/model/get_user_info_model.dart';
import 'package:aarongonzales01/features/user/profile/data/rx_help_and_support/rx.dart';
import 'package:aarongonzales01/features/user/profile/model/help_and_support_model.dart';
import 'package:aarongonzales01/features/user/profile/data/rx_privacy_policy/rx.dart';
import 'package:aarongonzales01/features/user/profile/model/privacy_policy_model.dart';
import 'package:aarongonzales01/features/user/profile/data/terms_and_conditions/rx.dart';
import 'package:aarongonzales01/features/user/profile/model/terms_and_condition_model.dart';
import 'package:aarongonzales01/features/user/profile/data/rx_update_profile/rx.dart';
import 'package:aarongonzales01/features/user/profile/model/update_profile_model.dart';
import 'package:aarongonzales01/features/organizer/home/data/rx_event_list/rx.dart';
import 'package:aarongonzales01/features/organizer/home/model/event_list_model.dart';
import 'package:aarongonzales01/features/organizer/events/data/rx_event_details/rx.dart';
import 'package:aarongonzales01/features/organizer/events/model/event_details_model.dart';
import 'package:aarongonzales01/features/organizer/events/data/rx_event_update/rx.dart';
import 'package:aarongonzales01/features/organizer/events/data/rx_event_delete/rx.dart';
import 'package:aarongonzales01/features/organizer/events/data/rx_event_create/rx.dart';
import 'package:aarongonzales01/features/organizer/community/data/rx_club_category_list/rx.dart';
import 'package:aarongonzales01/features/organizer/community/model/club_category_list_model.dart';
import 'package:aarongonzales01/features/organizer/community/data/rx_create_club/rx.dart';
import 'package:aarongonzales01/features/organizer/community/model/create_club_model.dart';
import 'package:aarongonzales01/features/organizer/community/data/rx_club_list/rx.dart';
import 'package:aarongonzales01/features/organizer/community/model/club_list_model.dart';
import 'package:aarongonzales01/features/organizer/community/data/rx_delete_club/rx.dart';
import 'package:aarongonzales01/features/organizer/community/model/club_delete_model.dart';
import 'package:aarongonzales01/features/organizer/community/data/update_club/rx.dart';
import 'package:aarongonzales01/features/organizer/community/model/update_club_model.dart';

import 'package:aarongonzales01/features/organizer/community/data/rx_club_show/rx.dart';
import 'package:aarongonzales01/features/organizer/community/model/club_show_model.dart';
import 'package:aarongonzales01/features/organizer/community/data/rx_club_challenge_list/rx.dart';
import 'package:aarongonzales01/features/organizer/community/model/club_challenge_list_model.dart';
import 'package:aarongonzales01/features/organizer/community/data/rx_challenge_create/rx.dart';
import 'package:aarongonzales01/features/organizer/community/data/rx_challenge_delete/rx.dart';
import 'package:aarongonzales01/features/organizer/community/data/rx_social_feed_list/rx.dart';
import 'package:aarongonzales01/features/organizer/community/model/social_feed_list_model.dart';
import 'package:aarongonzales01/features/organizer/community/data/rx_social_feed_create/rx.dart';

import 'package:aarongonzales01/features/organizer/community/data/rx_social_feed_delete/rx.dart';
import 'package:aarongonzales01/features/organizer/community/data/rx_social_feed_like/rx.dart';
import 'package:aarongonzales01/features/organizer/community/data/rx_social_feed_comments/rx.dart';
import 'package:aarongonzales01/features/organizer/community/data/rx_social_feed_comment_create/rx.dart';
import 'package:aarongonzales01/features/organizer/community/model/all_comment_model.dart';
import 'package:rxdart/subjects.dart';

import 'package:aarongonzales01/features/user/social/data/rx_get_feed_list/rx.dart';
import 'package:aarongonzales01/features/user/social/model/get_feed_list_model.dart';
import 'package:aarongonzales01/features/user/social/data/rx_follow_user/rx.dart';
import 'package:aarongonzales01/features/user/social/model/user_follow_model.dart';
import 'package:aarongonzales01/features/user/social/data/rx_get_following_feed_list/rx.dart';
import 'package:aarongonzales01/features/user/social/model/get_following_list_model.dart';
import 'package:aarongonzales01/features/user/social/data/rx_get_club_list/rx.dart';
import 'package:aarongonzales01/features/user/social/model/get_club_list_model.dart';
import 'package:aarongonzales01/features/user/social/data/rx_join_club/rx.dart';
import 'package:aarongonzales01/features/user/social/model/join_club_model.dart';
import 'package:aarongonzales01/features/user/social/data/rx_show_club/rx.dart';
import 'package:aarongonzales01/features/user/social/model/show_club_model.dart';
import 'package:aarongonzales01/features/user/club_details/data/rx_club_details/rx.dart';
import 'package:aarongonzales01/features/user/club_details/model/club_details_model.dart';

// ------------- Club Category List Api Access -----------------//
ClubCategoryListRx clubCategoryListRxObj = ClubCategoryListRx(
  empty: ClubCategoryListModel(),
  dataFetcher: BehaviorSubject<ClubCategoryListModel>(),
);

// ------------- Create Club Api Access -----------------//
CreateClubRx createClubRxObj = CreateClubRx(
  empty: CreateClubModel(),
  dataFetcher: BehaviorSubject<CreateClubModel>(),
);

// ------------- Club List Api Access -----------------//
ClubListRx clubListRxObj = ClubListRx(
  empty: ClubListModel(),
  dataFetcher: BehaviorSubject<ClubListModel>(),
);

// ------------- Delete Club Api Access -----------------//
DeleteClubRx deleteClubRxObj = DeleteClubRx(
  empty: ClubDeleteModel(),
  dataFetcher: BehaviorSubject<ClubDeleteModel>(),
);

// ------------- Update Club Api Access -----------------//
UpdateClubRx updateClubRxObj = UpdateClubRx(
  empty: UpdateClubModel(),
  dataFetcher: BehaviorSubject<UpdateClubModel>(),
);

// ------------- Club Show Api Access -----------------//
ClubShowRx clubShowRxObj = ClubShowRx(
  empty: ClubShowModel(),
  dataFetcher: BehaviorSubject<ClubShowModel>(),
);

// ------------- Club Challenge List Api Access -----------------//
ClubChallengeListRx clubChallengeListRxObj = ClubChallengeListRx(
  empty: ClubChallengeListModel(),
  dataFetcher: BehaviorSubject<ClubChallengeListModel>(),
);

// ------------- Challenge Create Api Access -----------------//
ChallengeCreateRx challengeCreateRxObj = ChallengeCreateRx(
  empty: const {},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

// ------------- Challenge Delete Api Access -----------------//
ChallengeDeleteRx challengeDeleteRxObj = ChallengeDeleteRx(
  empty: const {},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

// ------------- Social Feed List Api Access -----------------//
SocialFeedListRX socialFeedListRXObj = SocialFeedListRX(
  empty: SocialFeedListModel(),
  dataFetcher: BehaviorSubject<SocialFeedListModel>(),
);

// ------------- Social Feed Create Api Access -----------------//
SocialFeedCreateRx socialFeedCreateRxObj = SocialFeedCreateRx(
  empty: const {},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

// ------------- Social Feed Delete Api Access -----------------//
SocialFeedDeleteRx socialFeedDeleteRxObj = SocialFeedDeleteRx(
  empty: const {},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

// ------------- Social Feed Like Api Access -----------------//
SocialFeedLikeRx socialFeedLikeRxObj = SocialFeedLikeRx(
  empty: const {},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

// ------------- Social Feed Comments Api Access -----------------//
SocialFeedCommentsRx socialFeedCommentsRxObj = SocialFeedCommentsRx(
  empty: AllCommentModel(),
  dataFetcher: BehaviorSubject<AllCommentModel>(),
);

// ------------- Social Feed Comment Create Api Access -----------------//
SocialFeedCommentCreateRx socialFeedCommentCreateRxObj =
    SocialFeedCommentCreateRx(
      empty: const {},
      dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
    );

// ------------- Register Api Access -----------------//
RegisterRx registerRxObj = RegisterRx(
  empty: RegisterModel(),
  dataFetcher: BehaviorSubject<RegisterModel>(),
);

// ------------- Register Verify Otp Api Access -----------------//
RegisterVerifyOtpRx registerVerifyOtpRxObj = RegisterVerifyOtpRx(
  empty: RegisterVerifyOtpModel(),
  dataFetcher: BehaviorSubject<RegisterVerifyOtpModel>(),
);

// ------------- Login Api Access -----------------//
LoginRx loginRxObj = LoginRx(
  empty: LoginModel(),
  dataFetcher: BehaviorSubject<LoginModel>(),
);

// ------------- Choose Role Api Access -----------------//
ChooseRoleRx chooseRoleRxObj = ChooseRoleRx(
  empty: ChooseRoleModel(),
  dataFetcher: BehaviorSubject<ChooseRoleModel>(),
);

// ------------- Logout Api Access -----------------//
LogoutRx logoutRxObj = LogoutRx(
  empty: LogoutModel(),
  dataFetcher: BehaviorSubject<LogoutModel>(),
);

// ------------- Forget Password Api Access -----------------//
ForgetPasswordRx forgetPasswordRxObj = ForgetPasswordRx(
  empty: ForgetPasswordModel(),
  dataFetcher: BehaviorSubject<ForgetPasswordModel>(),
);

// ------------- Delete Account Api Access -----------------//
DeleteAccountRx deleteAccountRxObj = DeleteAccountRx(
  empty: DeleteAccountModel(),
  dataFetcher: BehaviorSubject<DeleteAccountModel>(),
);

// ------------- Change Password Api Access -----------------//
ChangePasswordRx changePasswordRxObj = ChangePasswordRx(
  empty: ChangePasswordModel(),
  dataFetcher: BehaviorSubject<ChangePasswordModel>(),
);

// ------------- Get User Info Api Access -----------------//
GetUserInfoRx getUserInfoRxObj = GetUserInfoRx(
  empty: GetUserInfoModel(),
  dataFetcher: BehaviorSubject<GetUserInfoModel>(),
);

// ------------- Help And Support Api Access -----------------//
HelpAndSupportRx helpAndSupportRxObj = HelpAndSupportRx(
  empty: HelpAndSupportModel(),
  dataFetcher: BehaviorSubject<HelpAndSupportModel>(),
);

// ------------- Privacy Policy Api Access -----------------//
PrivacyPolicyRx privacyPolicyRxObj = PrivacyPolicyRx(
  empty: PrivacyPolicyModel(),
  dataFetcher: BehaviorSubject<PrivacyPolicyModel>(),
);

// ------------- Terms And Conditions Api Access -----------------//
TermsAndConditionsRx termsAndConditionsRxObj = TermsAndConditionsRx(
  empty: TermsAndConditionModel(),
  dataFetcher: BehaviorSubject<TermsAndConditionModel>(),
);

// ------------- Update Profile Api Access -----------------//
UpdateProfileRx updateProfileRxObj = UpdateProfileRx(
  empty: UpdateProfileModel(),
  dataFetcher: BehaviorSubject<UpdateProfileModel>(),
);

// ------------- Event Create Api Access -----------------//
EventCreateRx eventCreateRxObj = EventCreateRx(
  empty: const {},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

// ------------- Event List Api Access -----------------//
EventListRx eventListRxObj = EventListRx(
  empty: EventListModel(),
  dataFetcher: BehaviorSubject<EventListModel>(),
);

// ------------- Event Details Api Access -----------------//
EventDetailsRx eventDetailsRxObj = EventDetailsRx(
  empty: EventDetailsModel(),
  dataFetcher: BehaviorSubject<EventDetailsModel>(),
);

// ------------- Event Update Api Access -----------------//
EventUpdateRx eventUpdateRxObj = EventUpdateRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

// ------------- Event Delete Api Access -----------------//
EventDeleteRx eventDeleteRxObj = EventDeleteRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

VerifyForgetPasswordOtpRx verifyForgetPasswordOtpRxObj =
    VerifyForgetPasswordOtpRx(
      empty: ForgetPasswordOtpVerifyModel(),
      dataFetcher: BehaviorSubject<ForgetPasswordOtpVerifyModel>(),
    );

ResendOtpRx resendOtpRxObj = ResendOtpRx(
  empty: ResennOtpModel(),
  dataFetcher: BehaviorSubject<ResennOtpModel>(),
);

// ------------- Reset Password Api Access -----------------//
ResetPasswordRx resetPasswordRxObj = ResetPasswordRx(
  empty: ResetPasswordModel(),
  dataFetcher: BehaviorSubject<ResetPasswordModel>(),
);

// ------------- Get Feed List Api Access -----------------//
GetFeedListRx getFeedListRxObj = GetFeedListRx(
  empty: GetFeedListModel(),
  dataFetcher: BehaviorSubject<GetFeedListModel>(),
);

// ------------- Follow User Api Access -----------------//
FollowUserRx followUserRxObj = FollowUserRx(
  empty: UserFollowModel(),
  dataFetcher: BehaviorSubject<UserFollowModel>(),
);

// ------------- Get Following Feed List Api Access -----------------//
GetFollowingFeedListRx getFollowingFeedListRxObj = GetFollowingFeedListRx(
  empty: GetFollowingListModel(),
  dataFetcher: BehaviorSubject<GetFollowingListModel>(),
);

// ------------- Get Club List Api Access -----------------//
GetClubListRx getClubListRxObj = GetClubListRx(
  empty: GetClubListModel(),
  dataFetcher: BehaviorSubject<GetClubListModel>(),
);

// ------------- Join Club Api Access -----------------//
JoinClubRx joinClubRxObj = JoinClubRx(
  empty: JoinClubModel(),
  dataFetcher: BehaviorSubject<JoinClubModel>(),
);

// ------------- Show Club Api Access -----------------//
ShowClubRx showClubRxObj = ShowClubRx(
  empty: ShowClubModel(),
  dataFetcher: BehaviorSubject<ShowClubModel>(),
);

// ------------- Club Details Api Access -----------------//
ClubDetailsRx clubDetailsRxObj = ClubDetailsRx(
  empty: ClubDetailsModel(),
  dataFetcher: BehaviorSubject<ClubDetailsModel>(),
);

