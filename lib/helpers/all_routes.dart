import 'dart:io';
import 'package:aarongonzales01/features/auth/choose_role/presentation/choose_role_screen.dart';
import 'package:aarongonzales01/features/auth/forget_password/presentation/forget_password_screen.dart';
import 'package:aarongonzales01/features/auth/login/presentation/login_screen.dart';
import 'package:aarongonzales01/features/auth/register/presentation/register_screen.dart';
import 'package:aarongonzales01/features/auth/register_verify/presentation/register_verify_screen.dart';
import 'package:aarongonzales01/features/auth/update_password/presentation/update_password_screen.dart';
import 'package:aarongonzales01/features/onboarding/presentation/onboarding_screen.two.dart';
import 'package:aarongonzales01/features/onboarding/presentation/onboarding_screen_one.dart';
import 'package:aarongonzales01/features/onboarding/presentation/onboarding_screen_three.dart';
import 'package:aarongonzales01/features/organizer/community/presentation/club_all_member_screen.dart';
import 'package:aarongonzales01/features/organizer/community/presentation/create_club__basic_info_screen.dart';
import 'package:aarongonzales01/features/organizer/community/presentation/join_pending_request_screen.dart';
import 'package:aarongonzales01/features/organizer/community/presentation/organizer_create_details_screen.dart';
import 'package:aarongonzales01/features/organizer/events/presentation/create_event_screen.dart';
import 'package:aarongonzales01/features/organizer/events/presentation/details_and_publish_screen.dart';
import 'package:aarongonzales01/features/organizer/events/presentation/update_event_screen.dart';
import 'package:aarongonzales01/features/organizer/community/presentation/create_new_challenges_screen.dart';
import 'package:aarongonzales01/features/organizer/community/presentation/create_social_feed_screen.dart';
import 'package:aarongonzales01/features/organizer/home/presentation/all_recent_events_screen%20.dart';
import 'package:aarongonzales01/features/organizer/home/presentation/notification_organizer_screen.dart';
import 'package:aarongonzales01/features/organizer/profile/presentation/all_mail_screen.dart';
import 'package:aarongonzales01/features/organizer/profile/presentation/edit_profile_screen.dart';
import 'package:aarongonzales01/features/organizer/profile/presentation/email_preview_screen.dart';
import 'package:aarongonzales01/features/organizer/wallet/presentation/all_transactions_screen.dart';
import 'package:aarongonzales01/features/organizer/wallet/presentation/wallet_screen.dart';
import 'package:aarongonzales01/features/organizer/wallet/presentation/withdraw_amount_screen.dart';
import 'package:aarongonzales01/features/organizer/wallet/presentation/select_method_screen.dart';
import 'package:aarongonzales01/features/organizer/wallet/presentation/bank_account_details_screen.dart';
import 'package:aarongonzales01/features/organizer/wallet/presentation/stripe_details_screen.dart';
import 'package:aarongonzales01/features/organizer/wallet/presentation/review_withdrawal_screen.dart';
import 'package:aarongonzales01/features/organizer/wallet/presentation/withdraw_success_screen.dart';
import 'package:aarongonzales01/features/organizer/promocodes/presentation/promo_codes_screen.dart';
import 'package:aarongonzales01/features/organizer/promocodes/presentation/create_promo_code_screen.dart';
import 'package:aarongonzales01/features/organizer/promocodes/presentation/promo_code_created_screen.dart';
import 'package:aarongonzales01/features/organizer/promocodes/presentation/promo_code_details_screen.dart';
import 'package:aarongonzales01/features/organizer/promocodes/widgets/promo_code_model.dart';
import 'package:aarongonzales01/features/organizer/wallet/widgets/withdraw_request.dart';
import 'package:aarongonzales01/features/organizer/profile/presentation/org_achievements_screen.dart';
import 'package:aarongonzales01/features/organizer/profile/presentation/org_change_password_scren.dart';
import 'package:aarongonzales01/features/organizer/profile/presentation/org_email_send_screen.dart';
import 'package:aarongonzales01/features/organizer/profile/presentation/org_notification_setting_screen.dart';
import 'package:aarongonzales01/features/organizer/profile/presentation/org_payout_screen.dart';
import 'package:aarongonzales01/features/organizer/profile/presentation/organiser_profile_screen.dart';
import 'package:aarongonzales01/features/organizer/race_timer_bottom_nav_bar.dart';
import 'package:aarongonzales01/features/user/checkout/presentation/checkout_screen.dart';
import 'package:aarongonzales01/features/user/profile/presentation/event_detail_screen.dart';
import 'package:aarongonzales01/features/user/profile/presentation/personal_information_screen.dart';
import 'package:aarongonzales01/features/user/profile/presentation/help_and_support_screen.dart';
import 'package:aarongonzales01/features/user/profile/presentation/privacy_policy_screen.dart';
import 'package:aarongonzales01/features/user/profile/presentation/terms_and_conditions_screen.dart';
import 'package:aarongonzales01/features/user/shop/presentation/cart_screen.dart';
import 'package:aarongonzales01/features/user/shop/presentation/favorites_list_screen.dart';
import 'package:aarongonzales01/features/user/shop/presentation/product_details_screen.dart';
import 'package:aarongonzales01/features/user/user_navigation_menu.dart';
import 'package:aarongonzales01/features/organizer/race%20timer/presentation/all_recers_screen.dart';
import 'package:flutter/cupertino.dart';

final class Routes {
  static final Routes _routes = Routes._internal();
  Routes._internal();
  static Routes get instance => _routes;
  static const String logInScreen = '/logInScreen';
  static const String onboardingScreenOne = '/onboardingScreenOne';
  static const String onboardingScreenTwo = '/onboardingScreenTwo';
  static const String onboardingScreenThree = '/onboardingScreenThree';
  static const String chooseRoleScreen = '/chooseRoleScreen';
  static const String registerScreen = '/registerScreen';
  static const String registerVerifyScreen = '/registerVerifyScreen';
  static const String chooseRoleDemo = '/chooseRoleDemo';
  static const String loginScreen = '/loginScreen';
  static const String updatePasswordScreen = '/updatePasswordScreen';

  static const String orgAchievementsScreen = '/orgAchievementsScreen';
  static const String orgNotificationSettingScreen =
      '/orgNotificationSettingScreen';
  static const String editProfileScreen = '/editProfileScreen';
  static const String orgChangePasswordScren = '/orgChangePasswordScren';
  static const String forgetPasswordScreen = '/forgetPasswordScreen';
  static const String orgEmailSendScreen = '/orgEmailSendScreen';
  static const String orgPayoutScreen = '/orgPayoutScreen';
  static const String organiserProfileScreen = '/organiserProfileScreen';
  static const String allRecentEventsScreen = '/allRecentEventsScreen';
  static const String detailsAndPublishScreen = '/detailsAndPublishScreen';
  static const String createEventScreen = '/createEventScreen';
  static const String organizerCreateDetailsScreen =
      '/organizerCreateDetailsScreen';
  static const String clubAllMemberScreen = '/clubAllMemberScreen';
  static const String joinPendingRequestScreen = '/joinPendingRequestScreen';
  static const String createClubBasicInfoScreen = '/createClubBasicInfoScreen';
  static const String productDetailsScreen = '/productDetailsScreen';
  static const String cartScreen = '/cartScreen';
  static const String favoritesListScreen = '/favoritesListScreen';
  static const String userNavigationMenu = '/userNavigationMenu';
  static const String notificationOrganizerScreen =
      '/notificationOrganizerScreen';
  static const String allRecersScreen = '/allRecersScreen';
  static const String allRecersRecordScreen = '/allRecersRecordScreen';
  static const String eventDetailScreen = '/eventDetailScreen';
  static const String personalInformationScreen = '/personalInformationScreen';
  static const String helpAndSupportScreen = '/helpAndSupportScreen';
  static const String privacyPolicyScreen = '/privacyPolicyScreen';
  static const String termsAndConditionsScreen = '/termsAndConditionsScreen';
  static const String allMailScreen = '/allMailScreen';
  static const String emailPreviewScreen = '/emailPreviewScreen';
  static const String walletScreen = '/walletScreen';
  static const String allTransactionsScreen = '/allTransactionsScreen';
  static const String withdrawAmountScreen = '/withdrawAmountScreen';
  static const String selectMethodScreen = '/selectMethodScreen';
  static const String bankAccountDetailsScreen = '/bankAccountDetailsScreen';
  static const String stripeDetailsScreen = '/stripeDetailsScreen';
  static const String reviewWithdrawalScreen = '/reviewWithdrawalScreen';
  static const String withdrawSuccessScreen = '/withdrawSuccessScreen';
  static const String promoCodesScreen = '/promoCodesScreen';
  static const String createPromoCodeScreen = '/createPromoCodeScreen';
  static const String promoCodeCreatedScreen = '/promoCodeCreatedScreen';
  static const String promoCodeDetailsScreen = '/promoCodeDetailsScreen';
  static const String checkoutScreen = '/checkoutScreen';
  static const String updateEventScreen = '/updateEventScreen';
  static const String createNewChallengesScreen = '/createNewChallengesScreen';
  static const String createSocialFeedScreen = '/createSocialFeedScreen';
}

final class RouteGenerator {
  static final RouteGenerator _routeGenerator = RouteGenerator._internal();
  RouteGenerator._internal();
  static RouteGenerator get instance => _routeGenerator;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // ----------- Onboarding Routes -----------
      case Routes.onboardingScreenOne:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: OnboardingScreenOne(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => OnboardingScreenOne());

      // ----------- Onboarding Routes -----------
      case Routes.onboardingScreenTwo:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: OnboardingScreenTwo(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => OnboardingScreenTwo());

      case Routes.onboardingScreenThree:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: OnboardingScreenThree(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => OnboardingScreenThree());

      case Routes.orgAchievementsScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: OrgAchievementsScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => OrgAchievementsScreen());

      case Routes.loginScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: LoginScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => LoginScreen());

      // ----------- Auth Routes start-----------
      case Routes.logInScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: LoginScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => LoginScreen());

      case Routes.chooseRoleScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ChooseRoleScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => ChooseRoleScreen());

      case Routes.checkoutScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: CheckoutScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => CheckoutScreen());

      case Routes.registerScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: RegisterScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => RegisterScreen());

      case Routes.registerVerifyScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: RegisterVerifyScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => RegisterVerifyScreen(),
                settings: settings,
              );

      case Routes.updatePasswordScreen:
        Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        String email = args['email'] ?? "";
        String resetToken = args['reset_token'] ?? "";
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: UpdatePasswordScreen(
                  email: email,
                  resetToken: resetToken,
                ),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => UpdatePasswordScreen(
                  email: email,
                  resetToken: resetToken,
                ),
              );

      // ----------- Auth Routes end-----------

      case Routes.orgNotificationSettingScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: OrgNotificationSettingScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => OrgNotificationSettingScreen(),
              );
      case Routes.editProfileScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: EditProfileScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => EditProfileScreen());

      case Routes.orgChangePasswordScren:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: OrgChangePasswordScren(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => OrgChangePasswordScren(),
              );

      case Routes.forgetPasswordScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ForgetPasswordScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => ForgetPasswordScreen());

      case Routes.orgEmailSendScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: OrgEmailSendScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => OrgEmailSendScreen());

      case Routes.orgPayoutScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: OrgPayoutScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => OrgPayoutScreen());

      case Routes.organiserProfileScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: OrganiserProfileScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => OrganiserProfileScreen(),
              );

      case Routes.allRecentEventsScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: AllRecentEventsScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => AllRecentEventsScreen());

      case Routes.userNavigationMenu:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: UserNavigationMenu(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => UserNavigationMenu());

      case Routes.detailsAndPublishScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: DetailsAndPublishScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => DetailsAndPublishScreen(),
                settings: settings,
              );

      case Routes.createEventScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: CreateEventScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => CreateEventScreen());

      case Routes.updateEventScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: UpdateEventScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => UpdateEventScreen(),
                settings: settings,
              );

      case Routes.createNewChallengesScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const CreateNewChallengesScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => const CreateNewChallengesScreen(),
                settings: settings,
              );

      case Routes.createSocialFeedScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const CreateSocialFeedScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => const CreateSocialFeedScreen(),
                settings: settings,
              );

      case Routes.organizerCreateDetailsScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: OrganizerCreateDetailsScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => OrganizerCreateDetailsScreen(),
                settings: settings,
              );

      case Routes.clubAllMemberScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ClubAllMemberScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => ClubAllMemberScreen());

      case Routes.joinPendingRequestScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: JoinPendingRequestScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => JoinPendingRequestScreen(),
              );

      case Routes.createClubBasicInfoScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: CreateClubBasicInfoScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => CreateClubBasicInfoScreen(),
                settings: settings,
              );

      case Routes.productDetailsScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ProductDetailsScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => ProductDetailsScreen());

      case Routes.cartScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: CartScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => CartScreen());

      case Routes.favoritesListScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: FavoritesListScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => FavoritesListScreen());

      case Routes.notificationOrganizerScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: NotificationOrganizerScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => NotificationOrganizerScreen(),
              );

      case Routes.allRecersScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: AllRecersScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => AllRecersScreen());

      case Routes.allRecersRecordScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: RaceTimerBottomNavBar(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => RaceTimerBottomNavBar());

      case Routes.eventDetailScreen:
        final event = settings.arguments as Map<String, dynamic>;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: EventDetailScreen(event: event),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => EventDetailScreen(event: event),
              );

      case Routes.personalInformationScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: PersonalInformationScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => PersonalInformationScreen(),
              );

      case Routes.helpAndSupportScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const HelpAndSupportScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => const HelpAndSupportScreen(),
              );

      case Routes.privacyPolicyScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const PrivacyPolicyScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => const PrivacyPolicyScreen(),
              );

      case Routes.termsAndConditionsScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const TermsAndConditionsScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => const TermsAndConditionsScreen(),
              );

      case Routes.allMailScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: AllMailScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => AllMailScreen());

      case Routes.emailPreviewScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: EmailPreviewScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => EmailPreviewScreen());

      case Routes.walletScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const WalletScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => const WalletScreen());

      case Routes.allTransactionsScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const AllTransactionsScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => const AllTransactionsScreen(),
              );

      case Routes.withdrawAmountScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const WithdrawAmountScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => const WithdrawAmountScreen(),
              );

      case Routes.selectMethodScreen:
        final request = settings.arguments as WithdrawRequest;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: SelectMethodScreen(request: request),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => SelectMethodScreen(request: request),
              );

      case Routes.bankAccountDetailsScreen:
        final request = settings.arguments as WithdrawRequest;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: BankAccountDetailsScreen(request: request),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) =>
                    BankAccountDetailsScreen(request: request),
              );

      case Routes.stripeDetailsScreen:
        final request = settings.arguments as WithdrawRequest;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: StripeDetailsScreen(request: request),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => StripeDetailsScreen(request: request),
              );

      case Routes.reviewWithdrawalScreen:
        final request = settings.arguments as WithdrawRequest;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ReviewWithdrawalScreen(request: request),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => ReviewWithdrawalScreen(request: request),
              );

      case Routes.withdrawSuccessScreen:
        final request = settings.arguments as WithdrawRequest;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: WithdrawSuccessScreen(request: request),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => WithdrawSuccessScreen(request: request),
              );

      case Routes.promoCodesScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const PromoCodesScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => const PromoCodesScreen(),
              );

      case Routes.createPromoCodeScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const CreatePromoCodeScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => const CreatePromoCodeScreen(),
              );

      case Routes.promoCodeCreatedScreen:
        final promoCode = settings.arguments as PromoCode;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: PromoCodeCreatedScreen(promoCode: promoCode),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) =>
                    PromoCodeCreatedScreen(promoCode: promoCode),
              );

      case Routes.promoCodeDetailsScreen:
        final promoData = settings.arguments as Map<String, String>;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: PromoCodeDetailsScreen(promoData: promoData),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) =>
                    PromoCodeDetailsScreen(promoData: promoData),
              );

      default:
        return null;
    }
  }
}

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({required this.widget, required this.settings})
    : super(
        settings: settings,
        reverseTransitionDuration: const Duration(milliseconds: 1),
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return widget;
            },
        transitionDuration: const Duration(milliseconds: 1),
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return FadeTransition(
                opacity: CurvedAnimation(parent: animation, curve: Curves.ease),
                child: child,
              );
            },
      );
}

class ScreenTitle extends StatelessWidget {
  final Widget widget;

  const ScreenTitle({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: .5, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceIn,
      builder: (context, value, child) {
        return Opacity(opacity: value, child: child);
      },
      child: widget,
    );
  }
}
