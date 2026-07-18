import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import '../constants/local_storage_key_strings.dart';
import 'package:get/get.dart' as get_x;

enum RefreshTokenStatus { active, expired, fail, pending }

enum ErrorCheckResults { end, retry, next, renewSession }

class AppInterceptor extends Interceptor {
  AppInterceptor(this._baseUrl, {this.skipUnauthorizedHandler = false});

  final String _baseUrl;
  final bool skipUnauthorizedHandler;

  static final bool _isRefreshing = false;
  static final List<Function(String)> _queuedRequests = [];

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final storage = GetStorage();
    final token = storage.read(LocalStorageKeyStrings.accessToken);

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    options.extra['skipUnauthorizedHandler'] = skipUnauthorizedHandler;
    handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final skipHandler =
        err.requestOptions.extra['skipUnauthorizedHandler'] as bool? ?? false;

    if (err.response?.statusCode == 401 && !skipHandler) {
      final storage = GetStorage();
      final refreshToken = storage.read(LocalStorageKeyStrings.refreshToken);

      if (refreshToken == null || refreshToken.isEmpty) {
        logout();
        return;
      }

      // if (_isRefreshing) {
      //   _queuedRequests.add((String newToken) async {
      //     final retryResponse = await _retryRequest(
      //       err.requestOptions,
      //       newToken,
      //     );
      //     handler.resolve(retryResponse);
      //   });
      //   return;
      // }

      // _isRefreshing = true;

      // try {
      //   final dio = Dio();
        // final refreshUrl =
        //     Uri.https(_baseUrl, EndPoint.refreshTokenUrl);

        // log("Refreshing token... URL: $refreshUrl");

        // final response = await dio.postUri(
        //   refreshUrl,
        //   data: {
        //     "refresh_token": refreshToken,
        //   },
        //   options: Options(
        //     headers: {
        //       'content-type': 'application/json',
        //     },
        //   ),
        // );

    //     if (response.statusCode == 200 || response.statusCode == 201) {
    //       final data = response.data;
    //       // Note: API returns 'assess_token'
    //       final newAccessToken = data['assess_token'] ?? data['access_token'];
    //       final newRefreshToken = data['refresh_token'];

    //       if (newAccessToken != null && newRefreshToken != null) {
    //         log("Token refreshed successfully");

    //         storage.write(LocalStorageKeyStrings.accessToken, newAccessToken);
    //         storage.write(LocalStorageKeyStrings.refreshToken, newRefreshToken);

    //         for (var callback in _queuedRequests) {
    //           callback(newAccessToken);
    //         }
    //         _queuedRequests.clear();
    //         _isRefreshing = false;

    //         final retryResponse = await _retryRequest(
    //           err.requestOptions,
    //           newAccessToken,
    //         );
    //         handler.resolve(retryResponse);
    //       } else {
    //         log("Token refresh response missing tokens");
    //         _forceLogout();
    //       }
    //     } else {
    //       log("Token refresh failed with status: ${response.statusCode}");
    //       _forceLogout();
    //     }
    //   } catch (e) {
    //     log("Token refresh error: $e");
    //     _forceLogout();
    //   }
    // } else {
    //   handler.next(err);
    // }
  }}

  Future<Response> _retryRequest(
    RequestOptions requestOptions,
    String newToken,
  ) async {
    final dioRetry = Dio(
      BaseOptions(
        baseUrl: requestOptions.baseUrl,
        headers: {'Authorization': 'Bearer $newToken'},
      ),
    );

    final Response response = await dioRetry.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        headers: requestOptions.headers
          ..addAll({'Authorization': 'Bearer $newToken'}),
      ),
    );

    return response;
  }

  // void _forceLogout() {
  //   _isRefreshing = false;
  //   _queuedRequests.clear();
  //   logout();
  // }
}

Future<void> logout() async {
  log("logout unauthorize");
  try {
    get_x.Get.reset();
  } catch (e) {
    print('Error resetting GetX state on logout: $e');
  }
  await GetStorage().erase();
  LocalStorageKeyStrings.appNavKey.currentContext!.go('/');
}

// class Logging extends Interceptor {
//   final Dio dio;

//   Logging(this.dio);

//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     ApiLogger.logDioRequest(options);
//     return super.onRequest(options, handler);
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     ApiLogger.logDioResponse(response);
//     return super.onResponse(response, handler);
//   }

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     ApiLogger.logDioError(err);
//     return super.onError(err, handler);
//   }
// }}
  