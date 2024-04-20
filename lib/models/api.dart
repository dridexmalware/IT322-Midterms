import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lawod/models/api_response.dart';

class Api {
  final String apiUrl = dotenv.env['API_URL'] ?? "http://127.0.0.1:8000";

  Api._privateConstructor();

  static final Api instance = Api._privateConstructor();

  Future<List<dynamic>> login(Map<String, dynamic> credentials) async {
    try {
      final url = Uri.parse('$apiUrl/login');
      final response = await http.post(
        url,
        body: convert.jsonEncode(credentials),
        headers: {"Content-type": "application/json"},
      ).timeout(const Duration(seconds: 10));

      final jsonResponse = convert.jsonDecode(response.body);

      final apiResponse = ApiResponse(
        status: jsonResponse['status'],
        message: jsonResponse['message'],
        data: jsonResponse['data'] ?? {},
      );

      return [apiResponse, response.statusCode];
    } on TimeoutException {
      return ["Request Timeout", 500];
    } on Exception catch (e) {
      return ["An error occurred: $e", 500];
    }
  }

  Future<List<dynamic>> register(Map<String, dynamic> userData) async {
    try {
      final url = Uri.parse('$apiUrl/register');
      final response = await http.post(
        url,
        body: convert.jsonEncode(userData),
        headers: {"Content-type": "application/json"},
      );

      final jsonResponse = convert.jsonDecode(response.body);
      final apiResponse = ApiResponse(
        status: jsonResponse['status'],
        message: jsonResponse['message'],
        data: jsonResponse['data'] ?? {},
      );

      return [apiResponse, response.statusCode];
    } on Exception catch (e) {
      return ["An error occurred: $e", 500];
    }
  }
}
