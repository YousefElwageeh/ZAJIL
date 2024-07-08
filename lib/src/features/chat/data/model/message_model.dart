import 'dart:convert';

class MessageModel {
  final bool isSender;
  final String message;

  MessageModel({
    required this.isSender,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'isSender': isSender});
    result.addAll({'response': message});

    return result;
  }

  factory MessageModel.fromMap(Map<String, dynamic> map,
      {bool isVoice = false}) {
    return MessageModel(
      isSender: map['isSender'] ?? false,
      message: isVoice ? map['voiceLink'] : map['response'] ?? '',
    );
  }
}
