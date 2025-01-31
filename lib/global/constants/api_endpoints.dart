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
  static const String mytherapist = "/Therapist/my-therapist";
  static const String sendMessage = "/Conversations";
  static const String sleepHistory = "/Mood/sleep-history";
  static const String moodTrends = "/Mood/mood-trends";
  static const String exerciseMin = "/Mood/exercise-minutes";
  static const String reportMin = "/Mood/download-mood-report";
  static const String posts = "/posts";
  static const String getposts = "/posts";
  static const String likeposts = "/posts/like-post";
  static const String unlikeposts = "/posts/unlike-post";
  static const String commentposts = "/posts/comment-post";
  static const String mood = "/Mood";
}
