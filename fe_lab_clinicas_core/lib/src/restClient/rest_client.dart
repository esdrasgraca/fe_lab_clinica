import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:fe_lab_clinicas_core/src/restClient/interceptors/auth_interceptor.dart';

final class RestClient extends DioForNative {
  RestClient(String baseURL)
      : super(
          BaseOptions(
            baseUrl: baseURL,
            receiveTimeout: const Duration(seconds: 60),
            connectTimeout: const Duration(seconds: 10),
          ),
        ){
          interceptors.addAll([
            LogInterceptor(requestBody: true,responseBody: true),
            AuthInterceptor(),
          ]);
        }

  RestClient get auth {
    options.extra['DIO_AUTH_KEY'] = true;
    return this;
  }

  RestClient get unAuth {
    options.extra['DIO_AUTH_KEY'] = false;
    return this;
  }
}
