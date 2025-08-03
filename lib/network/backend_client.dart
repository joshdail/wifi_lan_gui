import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:network_info_plus/network_info_plus.dart';

class BackendClient {
  static final BackendClient _instance = BackendClient._internal();
  factory BackendClient() => _instance;
  BackendClient._internal();

  String? _cachedBaseUrl;
  final int _port = 8000;

  /// Detects the device's IP and caches the base URL
  Future<String> _detectBaseUrl() async {
    if (_cachedBaseUrl != null) {
      return _cachedBaseUrl!;
    }
    final info = NetworkInfo();
    final ip = await info.getWifiIP();

    if (ip == null || ip.isEmpty) {
      throw Exception("Failed to detect host IP");
    }

    _cachedBaseUrl = 'http://$ip:$_port';
    return _cachedBaseUrl!;
  } // _detectBaseUrl

  /// Performs a GET request to the given path (e.g. '/scan')
  Future<http.Response> get(String path) async {
    final baseUrl = await _detectBaseUrl();
    final uri = Uri.parse('$baseUrl$path');

    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 5));
      return response;
    } on TimeoutException catch (_) {
      throw Exception("Request timed out to $uri");
    } on Exception catch (e) {
      throw Exception("Error on GET request to $uri:\n$e");
    }
  } // get
} // BackendClient
