// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'dart:developer';

import 'package:call_service/src/config/utils/AppStrings.dart';
import 'package:call_service/src/core/api/failure.dart';
import 'package:call_service/src/core/routes/navigation.dart';
import 'package:call_service/src/core/routes/routes.dart';
import 'package:dio/dio.dart';
import 'package:get/get_utils/get_utils.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      // dio error so its an error from response of the API or from dio itself
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.DEFAULT.getFailure(error.response);
    }
  }
}

Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure(error.response);
    case DioExceptionType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure(error.response);
    case DioExceptionType.receiveTimeout:
      return DataSource.RECIEVE_TIMEOUT.getFailure(error.response);
    case DioExceptionType.badResponse:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return Failure(error.response?.statusCode ?? 0,
            error.response?.statusMessage ?? "", error.response);
      } else {
        return DataSource.DEFAULT.getFailure(error.response);
      }
    case DioExceptionType.cancel:
      return DataSource.CANCEL.getFailure(error.response);
    case DioExceptionType.unknown:
      return DataSource.DEFAULT.getFailure(error.response);
    case DioExceptionType.badCertificate:
      return DataSource.BAD_CERTIFICATE.getFailure(error.response);
    case DioExceptionType.connectionError:
      return DataSource.connectionError.getFailure(error.response);
  }
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
  BAD_CERTIFICATE,
  connectionError
}

extension DataSourceExtension on DataSource {
  Failure getFailure(Response<dynamic>? response) {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS, response);
      case DataSource.NO_CONTENT:
        return Failure(
            ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT, response);
      case DataSource.BAD_REQUEST:
        return Failure(
            ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST, response);
      case DataSource.FORBIDDEN:
        return Failure(
            ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN, response);
      case DataSource.UNAUTORISED:
        return Failure(
            ResponseCode.UNAUTORISED, ResponseMessage.UNAUTORISED, response);
      case DataSource.NOT_FOUND:
        return Failure(
            ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND, response);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR, response);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(ResponseCode.CONNECT_TIMEOUT,
            ResponseMessage.CONNECT_TIMEOUT, response);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL, response);
      case DataSource.RECIEVE_TIMEOUT:
        return Failure(ResponseCode.RECIEVE_TIMEOUT,
            ResponseMessage.RECIEVE_TIMEOUT, response);
      case DataSource.SEND_TIMEOUT:
        return Failure(
            ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT, response);
      case DataSource.CACHE_ERROR:
        return Failure(
            ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR, response);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION, response);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT, response);
      case DataSource.BAD_CERTIFICATE:
        return Failure(
            ResponseCode.BAD_CERTIFICATE, ResponseMessage.DEFAULT, response);
      case DataSource.connectionError:
        return Failure(
            ResponseCode.CONNECTION_ERROR, ResponseMessage.DEFAULT, response);
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTORISED = 401; // failure, user is not authorised
  static const int FORBIDDEN = 403; //  failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  static const int NOT_FOUND = 404; // failure, not found
  static const int BAD_CERTIFICATE = 495; // failure, not found
  static const int CONNECTION_ERROR = 503; // failure, not found

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static String SUCCESS = AppStrings.success.tr; // success with data
  static String NO_CONTENT =
      AppStrings.success.tr; // success with no data (no content)
  static String BAD_REQUEST =
      AppStrings.badRequestError.tr; // failure, API rejected request
  static String UNAUTORISED =
      AppStrings.unauthorizedError.tr; // failure, user is not authorised
  static String FORBIDDEN =
      AppStrings.forbiddenError.tr; //  failure, API rejected request
  static String INTERNAL_SERVER_ERROR =
      AppStrings.internalServerError.tr; // failure, crash in server side
  static String NOT_FOUND =
      AppStrings.notFoundError.tr; // failure, crash in server side

  // local status code
  static String CONNECT_TIMEOUT = AppStrings.timeoutError.tr;
  static String CANCEL = AppStrings.defaultError.tr;
  static String RECIEVE_TIMEOUT = AppStrings.timeoutError.tr;
  static String SEND_TIMEOUT = AppStrings.timeoutError.tr;
  static String CACHE_ERROR = AppStrings.cacheError.tr;
  static String NO_INTERNET_CONNECTION = AppStrings.noInternetError.tr;
  static String BAD_CERTIFICATE = AppStrings.bad_certificate.tr;
  static String CONNECTION_ERROR = AppStrings.CONNECTION_ERROR.tr;

  static String DEFAULT = AppStrings.defaultError;
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}
