import 'package:dio/dio.dart';

abstract class HttpAdapter {
  Future<dynamic> get(String endpoint);
}

class HttpAdapterImpl extends HttpAdapter {
  final Dio client;

  HttpAdapterImpl({required this.client});

  @override
  Future<dynamic> get(String endpoint) async {
    final response = await client.get(endpoint);

    return response.data;
  }
}
