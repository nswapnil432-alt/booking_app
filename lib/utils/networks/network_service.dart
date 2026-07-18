// import 'dart:io';
// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:get_storage/get_storage.dart';
// import '../extension/sized_box_extension.dart';
// // ignore: depend_on_referenced_packages
// import 'package:http_parser/http_parser.dart' as http_parser;
// import '../constants/local_storage_key_strings.dart';
// import '../localiization/localization_manager.dart';
// import 'app_interceptor.dart';
// import 'end_point.dart';

// class NetworkService {
//   // NetworkService() {
//   //   _dio = Dio(
//   //     _getOptions(),
//   //   )..interceptors.addAll({appInterceptor});
//   // }
//   // AppInterceptor appInterceptor = getIt();
//   late Dio _dio;
//   // final String _baseUrl = EndPoint.appBaseUrl;

//   void updateAuthToken(String token) {
//     _dio.options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
//   }

//   BaseOptions _getOptions() => BaseOptions(
//         headers: _getHeaders(),
//         connectTimeout: const Duration(seconds: 60),
//         receiveTimeout: const Duration(seconds: 60),
//         sendTimeout: const Duration(seconds: 60),
//       );

//   Map<String, String?> _getHeaders() {
//     Map<String, String?> headers = {
//       HttpHeaders.contentTypeHeader: 'application/json',
//       HttpHeaders.userAgentHeader: 'dio',
//       'accept-language': LocalizationManager().currentLocale.languageCode,
//     };

//     String accessToken = GetStorage().read(LocalStorageKeyStrings.accessToken) ?? '';

//     if (accessToken.isNotEmpty) {
//       headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
//     }

//     return headers;
//   }

//   // Future<dynamic> getRequest(
//   //   String url, {
//   //   String? baseUrl,
//   //   Map<String, dynamic>? queryParameters,
//   //   bool unauthorizedFallback = false,
//   // }) async {
//   //   // Create a new Dio instance with or without the interceptor based on unauthorizedFallback
//   //   final dioInstance = _createDioInstance(unauthorizedFallback);
//   //   Uri endpoint = Uri.https(baseUrl ?? _baseUrl, url, queryParameters);
//   //   Uri.decodeQueryComponent(endpoint.toString());
//   //   Response response = await dioInstance.getUri(endpoint);
//   //   return response.data;
//   // }

//   Future<dynamic> getRequest(
//     String url, {
//     String? baseUrl,
//     Map<String, dynamic>? queryParameters,
//     bool unauthorizedFallback = false,
//     ResponseType? responseType,
//   }) async {
//     // Create a new Dio instance with or without the interceptor based on unauthorizedFallback
//     final dioInstance = _createDioInstance(unauthorizedFallback);
//     // Uri endpoint = Uri.https(baseUrl ?? _baseUrl, url, queryParameters);
//     Uri.decodeQueryComponent(endpoint.toString());
//     Response response = await dioInstance.getUri(endpoint,
//       options: Options(responseType: responseType),
//     );
//     return response.data;
//   }

//   Future<dynamic> postRequest(
//     String url, {
//     Map<String, dynamic>? body,
//     String? baseUrl,
//     Map<String, dynamic>? queryParameters,
//     bool unauthorizedFallback = false,
//   }) async {
//     // Create a new Dio instance with or without the interceptor based on unauthorizedFallback
//     final dioInstance = _createDioInstance(unauthorizedFallback);
//     Uri endpoint = Uri.https(
//       baseUrl ?? _baseUrl,
//       url,
//       queryParameters,
//     );

//     Response response = await dioInstance.postUri(endpoint, data: body ?? {});

//     if (response.data?.isNotEmpty ?? false) {
//       return response.data;
//     }

//     return null;
//   }

//   Future<dynamic> postMultipartRequest(
//     String url, {
//     required Map<String, dynamic> body,
//     String? baseUrl,
//     bool unauthorizedFallback = false,
//   }) async {
//     final dioInstance = _createDioInstance(unauthorizedFallback);
//     Uri endpoint = Uri.https(
//       baseUrl ?? _baseUrl,
//       url,
//     );

//     FormData formData = FormData.fromMap(body);

//     Response response = await dioInstance.postUri(
//       endpoint,
//       data: formData,
//     );

//     if (response.data?.isNotEmpty ?? false) {
//       return response.data;
//     }

//     return null;
//   }

//   Future<dynamic> putMultipartRequest(
//     String url, {
//     required Map<String, dynamic> body,
//     String? baseUrl,
//     bool unauthorizedFallback = false,
//   }) async {
//     final dioInstance = _createDioInstance(unauthorizedFallback);
//     Uri endpoint = Uri.https(
//       baseUrl ?? _baseUrl,
//       url,
//     );

//     FormData formData = FormData.fromMap(body);

//     Response response = await dioInstance.putUri(
//       endpoint,
//       data: formData,
//     );

//     if (response.data?.isNotEmpty ?? false) {
//       return response.data;
//     }

//     return null;
//   }

//   // Future<dynamic> postFileRequest(
//   //   String url, {
//   //   String? baseUrl,
//   //   required String filePath,
//   //   Function(double progress)? onProgress,
//   //   Map<String, dynamic>? extraBody,
//   //   bool unauthorizedFallback = false,
//   // }) async {
//   //   try {
//   //     // Create a separate Dio instance for file uploads
//   //     final uploadDio = Dio(BaseOptions(
//   //       baseUrl: 'https://${baseUrl ?? _baseUrl}',
//   //       connectTimeout: const Duration(seconds: 60),
//   //       receiveTimeout: const Duration(seconds: 60),
//   //       sendTimeout: const Duration(seconds: 60),
//   //     ));
//   //     // Add interceptors based on unauthorizedFallback
//   //     if (!unauthorizedFallback) {
//   //       uploadDio.interceptors.add(appInterceptor);
//   //     }
//   //     // Create a custom logging interceptor that handles FormData
//   //     uploadDio.interceptors.add(
//   //       InterceptorsWrapper(
//   //         onRequest: (options, handler) {
//   //           // Don't log FormData content as it contains binary data
//   //           if (options.data is FormData) {
//   //           } else {


//   //           }
//   //           handler.next(options);
//   //         },
//   //         onResponse: (response, handler) {
//   //           handler.next(response);
//   //         },
//   //         onError: (error, handler) {
//   //           handler.next(error);
//   //         },
//   //       ),
//   //     );
//   //     final file = File(filePath);
//   //     if (!file.existsSync()) {
//   //       throw Exception("File does not exist");
//   //     }

//   //     // Get access token
//   //     String accessToken = GetStorage().read(LocalStorageKeyStrings.accessToken) ?? '';
//   //     if (accessToken.isEmpty) {
//   //       throw Exception("Access token not found");
//   //     }

//   //     // Get proper filename and content type
//   //     final fileName = file.path.split('/').last;
//   //     final contentType = fileName.getContentType();
//   //     final formData = FormData.fromMap({
//   //       'file': await MultipartFile.fromFile(
//   //         filePath, 
//   //         filename: fileName,
//   //         contentType: http_parser.MediaType.parse(contentType),
//   //       ),
//   //     });
//   //     // Add extra body fields if provided
//   //     if (extraBody != null) {
//   //       formData.fields.addAll(
//   //         extraBody.entries .map((entry) => MapEntry(entry.key, entry.value.toString())),
//   //       );
//   //     }

//   //     Response response = await uploadDio.post(
//   //       url, // Use relative URL since baseUrl is set
//   //       data: formData,
//   //       options: Options(
//   //         headers: {
//   //           'Authorization': 'Bearer $accessToken',
//   //           'Accept': '*/*',
//   //           'Accept-Language': 'en-US,en;q=0.9',
//   //           // Don't set content-type manually - let Dio handle it
//   //         },
//   //         validateStatus: (status) => status != null && status < 500,
//   //       ),
//   //       onSendProgress: onProgress != null 
//   //         ? (sent, total) {
//   //             if (total > 0) {
//   //               onProgress(sent / total);
//   //             }
//   //           }
//   //         : null,
//   //     );

//   //     if (response.data?.isNotEmpty ?? false) {
//   //       return response.data;
//   //     }

//   //     return null;
//   //   } catch (e) {
//   //     if (e is DioException) {
//   //       // Handle error based on unauthorizedFallback
//   //       if (e.response?.statusCode == 401 && unauthorizedFallback) {
//   //         // Don't logout, just rethrow the exception
//   //         rethrow;
//   //       }
//   //     }
//   //     rethrow;
//   //   }
//   // }

//   // Future<dynamic> postMultipleFilesRequest(
//   //   String url, {
//   //   String? baseUrl,
//   //   required List<String> filePaths,
//   //   required Map<String, dynamic> data,
//   //   Function(double progress)? onProgress,
//   //   bool unauthorizedFallback = false,
//   // }) async {
//   //   try {
//   //     final dioInstance = _createDioInstance(unauthorizedFallback);
//   //     Uri endpoint = Uri.https(baseUrl ?? _baseUrl, url);

//   //     final formData = FormData();
//   //     formData.fields.add(MapEntry('data', jsonEncode(data)));

//   //     for (String filePath in filePaths) {
//   //       final file = File(filePath);
//   //       if (!file.existsSync()) continue;

//   //       final fileName = file.path.split(RegExp(r'[/\\]')).last;
//   //       final contentType = fileName.getContentType();
        
//   //       formData.files.add(
//   //         MapEntry(
//   //           'files[]',
//   //           await MultipartFile.fromFile(
//   //             filePath,
//   //             filename: fileName,
//   //             contentType: http_parser.MediaType.parse(contentType),
//   //           ),
//   //         ),
//   //       );
//   //     }

//   //     Response response = await dioInstance.postUri(
//   //       endpoint,
//   //       data: formData,
//   //       onSendProgress: onProgress != null
//   //           ? (sent, total) {
//   //               if (total > 0) {
//   //                 onProgress(sent / total);
//   //               }
//   //             }
//   //           : null,
//   //     );

//   //     return response.data;
//   //   } catch (e) {
//   //     rethrow;
//   //   }
//   // }
//   // Future<dynamic> putRequest(
//   //   String url, {
//   //   Map<String, dynamic>? body,
//   //   String? baseUrl,
//   //   bool unauthorizedFallback = false,
//   // }) async {
//   //   // Create a new Dio instance with or without the interceptor based on unauthorizedFallback
//   //   final dioInstance = _createDioInstance(unauthorizedFallback);
//   //   Uri endpoint = Uri.https(baseUrl ?? _baseUrl, url);
//   //   Response response = await dioInstance.putUri(endpoint, data: body ?? {});

//   //   return response.data;
//   // }

//   // Future<dynamic> deleteRequest(
//   //   String url, {
//   //   Map<String, dynamic>? queryParameters,
//   //   String? baseUrl,
//   //   bool unauthorizedFallback = false,
//   // }) async {
//   //   // Create a new Dio instance with or without the interceptor based on unauthorizedFallback
//   //   final dioInstance = _createDioInstance(unauthorizedFallback);
//   //   Uri endpoint = Uri.https(baseUrl ?? _baseUrl, url, queryParameters);
//   //   Response response = await dioInstance.deleteUri(endpoint);
//   //   return response.data;
//   // }

//   // Helper method to create Dio instance with appropriate interceptors
//   // Dio _createDioInstance(bool unauthorizedFallback) {
//   //   final dioInstance = Dio(_getOptions());
//   //   // Always add logging interceptor
//   //   dioInstance.interceptors.add(Logging(dioInstance));
//   //   // Add app interceptor only if unauthorizedFallback is false
//   //   if (!unauthorizedFallback) {
//   //     dioInstance.interceptors.add(appInterceptor);
//   //   }
//   //   return dioInstance;
//   // }
// }