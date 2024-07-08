class Constants {
  static String? token;
  static String language = 'ar';

  static String baseUrl = "https://api.call-gpt.tech";
}

class EndPoints {
  static const String textToVoice = '/api/v1/order/voice/';
  static const String textToText = '/api/v1/order/chat/';
  static const String closeOrder = '/api/v1/order/close/';
}
