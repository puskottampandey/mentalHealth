class APIEndpoints {
  static const String baseUrl =
      'https://mint-publicly-seagull.ngrok-free.app/api';
  static const String signIn = "/Account/sign-in";
  static const String signUp = "/Account/sign-up";
  static const String sendemail = "/Account/send-email-confirmation";
  static const String emailconfirm = "/Account/email-confirmation";
  static const String userData = "/CurrentUser";
  static const String therapist = "/Therapist";
  static const String therapistUser = "/Therapist/User";
  static const String payment = "/Payment/transactions";
  static const String paymentLast = "/Payment/Verify";
}
