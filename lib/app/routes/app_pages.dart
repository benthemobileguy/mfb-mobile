import 'package:flutter/cupertino.dart';
import 'package:tampay_mobile/app/login/presentation/view/login_screen.dart';
import 'package:tampay_mobile/app/profile/presentation/account_secuity_screen.dart';
import 'package:tampay_mobile/app/profile/presentation/legal_screen.dart';
import 'package:tampay_mobile/app/profile/presentation/profile_beneficiaries_screen.dart';
import 'package:tampay_mobile/app/profile/presentation/referrals_screen.dart';
import 'package:tampay_mobile/app/profile/presentation/statements_reports_screen.dart';
import 'package:tampay_mobile/app/profile/presentation/support_screen.dart';
import 'package:tampay_mobile/app/signup/presentation/account_setup_screen.dart';
import 'package:tampay_mobile/app/signup/presentation/create_pass_screen.dart';
import 'package:tampay_mobile/app/signup/presentation/forgot_password.dart';
import 'package:tampay_mobile/app/signup/presentation/set_transaction_pin_screen.dart';
import 'package:tampay_mobile/app/signup/presentation/verify_identity_screen.dart';
import 'package:tampay_mobile/app/signup/presentation/verify_phone_confirmation_screen.dart';
import 'package:tampay_mobile/app/signup/presentation/verify_phone_number_screen.dart';
import 'package:tampay_mobile/app/signup/presentation/welcome_screen.dart';
import 'package:tampay_mobile/app/view/home/add_money/add_money_screen.dart';
import 'package:tampay_mobile/app/view/home/add_money/funding_success_screen.dart';
import 'package:tampay_mobile/app/view/home/base.dart';
import 'package:tampay_mobile/app/view/home/convert/conversion_success_screen.dart';
import 'package:tampay_mobile/app/view/home/convert/convert_screen.dart';
import 'package:tampay_mobile/app/view/home/profile/profile_screen.dart';
import 'package:tampay_mobile/app/view/home/send/bank_transfer/bank_transfer_screen.dart';
import 'package:tampay_mobile/app/view/home/send/bank_transfer/transaction_details_screen.dart';
import 'package:tampay_mobile/app/view/home/send/offline_transfers/offline_transfers_screen.dart';
import 'package:tampay_mobile/app/view/home/send/pay_bills/airtime/airtime_screen.dart';
import 'package:tampay_mobile/app/view/home/send/pay_bills/electricity/electricity_screen.dart';
import 'package:tampay_mobile/app/view/home/send/pay_bills/insurance/insurance_screen.dart';
import 'package:tampay_mobile/app/view/home/send/pay_bills/internet/internet_screen.dart';
import 'package:tampay_mobile/app/view/home/send/pay_bills/pay_bills_screen.dart';
import 'package:tampay_mobile/app/view/home/send/pay_bills/travel/travel_screen.dart';
import 'package:tampay_mobile/app/view/home/send/pay_bills/tv/tv_screen.dart';
import 'package:tampay_mobile/app/view/home/send/send_money_screen.dart';
import 'package:tampay_mobile/app/view/home/send/send_tampay_tag/send_with_tampay_tag.dart';
import 'package:tampay_mobile/app/view/splash_screen.dart';
import '../signup/presentation/signup_screen.dart.dart';
import '../signup/presentation/verify_email.dart';
import '../view/home/cards/cards_screen.dart';
import '../view/home/send/bank_transfer/send_money_confirmation_screen.dart';
import '../view/home/send/bank_transfer/transaction_successful_screen.dart';
import '../view/intro/intro_screen.dart';
import 'app_routes.dart';

class AppPages {
  static const initialRoute = Routes.splashRoute;
  static Map<String, WidgetBuilder> routes = {
    Routes.splashRoute: (context) => const SplashScreen(),
    Routes.homeScreenRoute: (context) => const Base(),
    Routes.introRoute: (context) => const IntroScreen(),
    Routes.loginRoute: (context) => const LoginScreen(),
    Routes.signupRoute: (context) => const SignUpScreen(),
    Routes.createPassRoute: (context) => const CreateNewPasswordScreen(),
    Routes.verifyEmailRoute: (context) => const VerifyScreen(),
    Routes.forgotPassRoute: (context) => const ForgotPasswordScreen(),
    Routes.cardsRoute: (context) => const CardsScreen(),
    Routes.profileRoute: (context) => const ProfileScreen(),
    Routes.sendMoneyRoute: (context) => const SendMoneyScreen(),
    Routes.airtimeRoute: (context) => const AirtimeScreen(),
    Routes.verifyIdentityRoute: (context) => const VerifyIdentityScreen(),
    Routes.electricityRoute: (context) => const ElectricityScreen(),
    Routes.internetRoute: (context) => const InternetScreen(),
    Routes.travelRoute: (context) => const TravelScreen(),
    Routes.verifyPhoneNumberRoute: (context) => const VerifyPhoneNumberScreen(),
    Routes.tvRoute: (context) => const TvScreen(),
    Routes.sendWithTampayRoute: (context) => const SendWithTampayTag(),
    Routes.offlineTransfersRoute: (context) => const OfflineTransfersScreen(),
    Routes.bankTransferRoute: (context) => const BankTransferScreen(),
    Routes.accountSetUpRoute: (context) => const AccountSetupScreen(),
    Routes.verifyPhoneConfirmationRoute: (context) =>
        const VerifyPhoneConfirmationScreen(),
    Routes.sendMoneyConfirmationRoute: (context) =>
        const SendMoneyConfirmationScreen(),
    Routes.transactionDetailsRoute: (context) =>
        const TransactionDetailsScreen(),
    Routes.transactionSuccessfulRoute: (context) =>
        const TransactionSuccessfulScreen(),
    Routes.payBillsRoute: (context) => const PayBillsScreen(),
    Routes.welcomeRoute: (context) => const WelcomeScreen(),
    Routes.insuranceRoute: (context) => const InsuranceScreen(),
    Routes.addMoneyRoute: (context) => const AddMoneyScreen(),
    Routes.convertRoute: (context) => const ConvertScreen(),
    Routes.conversionSuccessRoute: (context) => const ConversionSuccessScreen(),
    Routes.fundingSuccessRoute: (context) => const FundingSuccessScreen(),
    Routes.setTransactionPinRoute: (context) => const SetTransactionPinScreen(),
    Routes.accountSecurityRoute: (context) => const AccountSecuityScreen(),
    Routes.legalRoute: (context) => const LegalScreen(),
    Routes.profileBeneficiariesRoute: (context) =>
        const ProfileBeneficiariesScreen(),
    Routes.statementReportsRoute: (context) => const StatementsReportsScreen(),
    Routes.supportRoute: (context) => const SupportScreen(),
    Routes.referralsRoute: (context) => const ReferralsScreen(),
  };
}
