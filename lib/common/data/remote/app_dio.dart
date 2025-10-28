import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class AppDio with DioMixin implements Dio {
  AppDio._() {
    interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          const apiKey = String.fromEnvironment(
            'TMDB_API_KEY',
            defaultValue: '',
          );

          if (apiKey.isEmpty) {
            throw Exception(
              'TMDB_API_KEY not found. Please run with --dart-define=TMDB_API_KEY=your_api_key',
            );
          }

          options.queryParameters['api_key'] = apiKey;
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );

    options = BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3/',
      contentType: 'application/json',
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );

    httpClientAdapter = IOHttpClientAdapter();
  }

  static Dio getInstance() => AppDio._();
}
