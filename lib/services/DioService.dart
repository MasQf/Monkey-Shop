// lib/services/dio_service.dart

import 'package:dio/dio.dart';
import 'package:intl/intl.dart'; // 用于日期格式化

class DioService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://cbec-studapi.gzport.net', // 基地址
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ));

  // 单例模式
  static final DioService _instance = DioService._internal();
  factory DioService() => _instance;
  DioService._internal();

  Dio get dio => _dio;

  // 添加公共参数
  Map<String, dynamic> addCommonParams(Map<String, dynamic> data) {
    String appKey = 'mh_4304d403dc994f5a';
    String timestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    String v = '1.0';
    String signMethod = 'MD5';
    String sign = '123456';

    Map<String, dynamic> commonParams = {
      'app_key': appKey,
      'timestamp': timestamp,
      'v': v,
      'sign_method': signMethod,
      'sign': sign,
      'data': data
    };

    return commonParams;
  }
}
