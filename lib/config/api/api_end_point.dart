class ApiEndPoint {
  // static const baseUrl = "http://192.168.10.207:5003/api/v1/";
  // static const imageUrl = "http://192.168.10.207:5003";
  // static const socketUrl = "http://192.168.10.207:5003";
  static const baseUrl = "http://10.10.7.111:5003/api/v1/";
  static const imageUrl = "http://10.10.7.111:5003";
  static const socketUrl = "http://10.10.7.111:5003";

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
  static const messages = "messages";

  // Product endpoints
  static const products = "products";
  static const categories = "categories";
  static const brands = "brands";
  static const wishlist = "wishlist";
  static const bookmarks = "bookmarks";
  static const news = "news";
}
