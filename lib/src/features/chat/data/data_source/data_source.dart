import 'package:call_service/src/core/api/constant&endPoints.dart';
import 'package:call_service/src/core/api/dio_factory.dart';
import 'package:call_service/src/features/chat/data/model/message_model.dart';
import 'package:dio/dio.dart';

class ChatDataSource {
  Future<MessageModel> sendMessage(
      {required String message, required String chatId}) async {
    var result =
        await DioFactory.postdata(url: '${EndPoints.textToText}$chatId', data: {
      "text": message,
    });
    return MessageModel.fromMap(result.data);
  }

  Future<MessageModel> sendVoice(
      {required String message, required String chatId}) async {
    var result = await DioFactory.postdata(
        url: '${EndPoints.textToVoice}$chatId',
        data: {
          "text": message,
        });
    return MessageModel.fromMap(result.data, isVoice: true);
  }

  Future<Response> closeOrder({required String chatId}) async {
    var result = await DioFactory.getdata(
      url: '${EndPoints.closeOrder}$chatId',
    );
    return result.data;
  }
}
