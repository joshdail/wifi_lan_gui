import 'dart:convert';
import '../models/device.dart';
import '../network/backend_client.dart';

class ScannerService {
  final BackendClient _client = BackendClient();

  Future<List<Device>> scanNetwork() async {
    final response = await _client.get('/scan');

    if (response.statusCode != 200) {
      throw Exception('Scan failed: ${response.statusCode}');
    }

    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => Device.fromJson(json)).toList();
  } // scanNetwork
} // ScannerService
