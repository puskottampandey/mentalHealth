import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentalhealth/global/routes/route_constants.dart';
import 'package:mentalhealth/views/oboarding/multiple_choice.dart';
import '../../views/authentication/forgot_password/forgot_password.dart';
import '../../views/authentication/forgot_password/reset_password_screen.dart';
import '../../views/authentication/forgot_password/verification_code_screen.dart';
import '../../views/authentication/signin/sign_in_screen.dart';
import '../../views/authentication/signup/sign_up_screen.dart';
import '../../views/doctor_book/doctor_details.dart';
import '../../views/doctor_book/payment_screen.dart';
import '../../views/home/chat/chat_screen.dart';
import '../../views/home/main_home/main_home_screen.dart';
import '../../views/oboarding/onboarding_screen.dart';
import '../../views/search/search_screen.dart';
import '../../views/splash/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
        name: RouteConstants.splash,
        path: '/',
        builder: (context, state) {
          return const SplashScreen();
        }),
    GoRoute(
        name: RouteConstants.myApp,
        path: '/myApp',
        builder: (context, state) {
          return MainHomeScreen();
        }),
    GoRoute(
        name: RouteConstants.onboard,
        path: '/onboard',
        builder: (context, state) {
          return OnboardingScreen();
        }),
    GoRoute(
        name: RouteConstants.signIn,
        path: '/signIn',
        builder: (context, state) {
          return SignInScreen();
        }),
    GoRoute(
        name: RouteConstants.signUp,
        path: '/signUp',
        builder: (context, state) {
          return SignUpScreen();
        }),
    GoRoute(
        name: RouteConstants.forgotPassword,
        path: '/forgotPassword',
        builder: (context, state) {
          return const ForgotPassword();
        }),
    GoRoute(
        name: RouteConstants.verificationCode,
        path: '/verificationCode',
        builder: (context, state) {
          return VerificationCodeScreen();
        }),
    GoRoute(
        name: RouteConstants.resetPassword,
        path: '/resetPassword',
        builder: (context, state) {
          return const ResetPasswordScreen();
        }),
    GoRoute(
        name: RouteConstants.search,
        path: '/search',
        builder: (context, state) {
          return const SearchScreen();
        }),
    GoRoute(
        name: RouteConstants.doctorDetails,
        path: '/doctorDetails',
        builder: (context, state) {
          return const DoctorDetails();
        }),
    GoRoute(
        name: RouteConstants.payment,
        path: '/payment',
        builder: (context, state) {
          return const PaymentScreen();
        }),
    GoRoute(
        name: RouteConstants.chat,
        path: '/chat',
        builder: (context, state) {
          final value = state.extra as String;
          return ChatScreen(data: value);
        }),
    GoRoute(
        name: RouteConstants.multipleChoice,
        path: '/multipleChoice',
        builder: (context, state) {
          return const PHQ9Screen();
        }),
  ],
);
