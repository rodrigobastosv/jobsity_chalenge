import 'package:dio/dio.dart';

const baseUrl = 'https://api.tvmaze.com';

Dio getDefaultClient() => Dio(
  BaseOptions(
    baseUrl: baseUrl,
  ),
);

// Constants
const httpOk = 200;