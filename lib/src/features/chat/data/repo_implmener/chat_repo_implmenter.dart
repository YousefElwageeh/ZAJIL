import 'package:call_service/src/core/api/error_handler.dart';
import 'package:call_service/src/core/api/failure.dart';
import 'package:call_service/src/features/chat/data/data_source/data_source.dart';
import 'package:call_service/src/features/chat/data/model/message_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ChatRepoImpl {
  final ChatDataSource chatDataSource;

  ChatRepoImpl({required this.chatDataSource});

  @override
  Future<Either<Failure, MessageModel>> sendMessage(
      {required String message, required String chatId}) async {
    try {
      var result =
          await chatDataSource.sendMessage(message: message, chatId: chatId);
      return Right(result);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, MessageModel>> sendVoice(
      {required String message, required String chatId}) async {
    try {
      var result =
          await chatDataSource.sendVoice(message: message, chatId: chatId);
      return Right(result);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, Response>> closeOrder({required String chatId}) async {
    try {
      var result = await chatDataSource.closeOrder(chatId: chatId);
      return Right(result);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
