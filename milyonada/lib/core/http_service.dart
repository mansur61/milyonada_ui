import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../features/model/api_list_response_model.dart';
import '../features/model/api_response_model.dart'; 

abstract class IHttpService {
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters});
  Future<Response> post(String path, {dynamic data});
  Future<Response> patch(String path, {dynamic data});
  Future<Response> put(String path, {dynamic data});
  Future<Response> delete(String path, {dynamic data});

  Future<ApiResponse<T>> request<T>({
    required Future<Response> Function() requestFunction,
    required T Function(Object? json) fromJson,
  });

  Future<ApiListResponse<T>> requestList<T>({
    required Future<Response> Function() requestFunction,
    required T Function(Map<String, dynamic>) fromJson,
  });
}

class HttpService implements IHttpService {
  static HttpService? _instance;
  late final Dio _dio;
    final _token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb21wYW55X2lkIjoxMSwiaWF0IjoxNzUxMTk2Mzk1LCJleHAiOjE3NjE1NjQzOTV9.pGrnYXCWuqDiV8845AasA6SvHJ0Ae8d2obkObASo5fA";

  static Future<void> init() async {
    if (_instance != null) return;
    final info = await PackageInfo.fromPlatform();
    _instance = HttpService._internal(info.version);
  }

  factory HttpService() {
    if (_instance == null) {
      throw StateError(
          'HttpService kullanılmadan önce await HttpService.init() çağırın');
    }
    return _instance!;
  }

  HttpService._internal(String appVersion) {
    _dio = Dio(BaseOptions(
      baseUrl: 'http://16.170.81.49:3000',
      //ConstantString.backendUrl,
      headers: {
        'Content-Type': 'application/json',
        "x-app-version": appVersion,
        //'Accept-Language': LanguageManager.instance.languageCode,
      },
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
       /*final token = CacheManager.db.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }*/
         options.headers['Authorization'] = 'Bearer $_token';
        
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        switch (e.response?.statusCode) {
          case 401:
           // LoginStatusService().logout();
            break;
          case 400:
            if (e.response is Response &&
                (e.response!.data["statusEnum"] == "MINIMUM_APP_VERSION" ||
                    e.response!.data["statusEnum"] ==
                        "WRONG_VERSION_NUMBER_FORMAT")) {
            //  NavigationService.ns.gotoForceUpdate();
            }
            break;
          default:
        }
        return handler.next(e);
      },
    ));

    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  void updateLanguageHeader(String languageCode) {
    _dio.options.headers['Accept-Language'] = languageCode;
  }

  @override
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  @override
  Future<Response> post(String path, {data}) {
    return _dio.post(path, data: data);
  }

  @override
  Future<Response> patch(String path, {data}) {
    return _dio.patch(path, data: data);
  }

  @override
  Future<Response> put(String path, {data}) {
    return _dio.put(path, data: data);
  }

  @override
  Future<Response> delete(String path, {data}) {
    return _dio.delete(path, data: data);
  }

  @override
  Future<ApiResponse<T>> request<T>({
    required Future<Response> Function() requestFunction,
    required T Function(Object? json) fromJson,
  }) async {
    try {
      final response = await requestFunction();
      final apiResponse = ApiResponse<T>.fromJson(response.data, fromJson);

      if (apiResponse.success) {
        return apiResponse;
      } else {
        throw apiResponse;
        //NetworkException(apiResponse.message);
      }
    } on DioException catch (e) {
      //MyLog.debug("HttpService request DioException $e");
      final message = _extractErrorMessage(e);
      throw message;
      // NetworkException(BaseDioService.service.handleDioError(e, message));
    } catch (e) {
     // MyLog.debug("HttpService request catch $e");
      rethrow;
    }
  }

  @override
  Future<ApiListResponse<T>> requestList<T>({
    required Future<Response> Function() requestFunction,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await requestFunction();
      final apiResponse = ApiListResponse<T>.fromJson(response.data, fromJson);

      if (apiResponse.success ?? false) {
        return apiResponse;
      } else {
       throw apiResponse;
       //NetworkException(apiResponse.message ?? "");
         
      }
    } on DioException catch (e) {
      final message = _extractErrorMessage(e);
      throw message;
      //NetworkException(BaseDioService.service.handleDioError(e, message));
    } catch (e) {
      rethrow;
    }
  }

  String _extractErrorMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      return data["message"]?.toString() ?? "";
      //ConstantString().errorOccurred;
    }
    return "";
    //ConstantString().errorOccurred;
  }
}
