class ApiEndPoint {
  //Live Server - Web uses proxy or should use HTTPS
  // For web development, use --disable-web-security flag or configure CORS on backend
  static const String _liveServerUrl = "http://62.72.26.31:5003";
  static const String _testServerUrl = "http://10.10.7.111:5003";

  // Use live server by default (change to false for test server)
  static const bool _useLiveServer = true;

  static String get _serverUrl =>
      _useLiveServer ? _liveServerUrl : _testServerUrl;

  static String get baseUrl => "$_serverUrl/api/v1/";
  static String get imageUrl => _serverUrl;
  static String get socketUrl => _serverUrl;

  static const signUp = "users/sign-up";
  static const verifyEmail = "auth/verify-email";
  static const signIn = "auth/login";
  static const forgotPassword = "auth/forget-password";
  static const verifyOtp = "users/verify-otp";
  static const resetPassword = "auth/reset-password";
  static const changePassword = "users/change-password";
  static const resendOtp = "auth/resend-otp"; // নতুন এন্ডপয়েন্ট যোগ করা হয়েছে
  static const user = "users";
  static const profile = "users/profile";
  static const notifications = "notifications";
  static const privacyPolicies = "privacy-policies";
  static const termsOfServices = "terms-and-conditions";
  static const chats = "chats";
  static const createChat = "chats/create-chat";
  static const messages = "messages";
  static const deleteUser = "users/profile";

  // Product endpoints
  static const products = "products";
  static const categories = "categories";
  static const brands = "brands";
  static const wishlist = "wishlist";
  static const bookmarks = "bookmarks";
  static const news = "news";
}
