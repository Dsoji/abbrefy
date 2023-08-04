import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String endpoint = 'http://abbrefy.xyz/api/v1/url/abbrefy/';
  final Map<String, String> header = {
    "apiKey": '1814c177e2ae41f3931c3192021ee675'
  };

  ///post function
  Future<Map<String, dynamic>?> makePostRequest(
      Map<String, dynamic> requestData) async {
    final String requestBody = json.encode(requestData);

    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: header,
        body: requestBody,
      );
      if (response.statusCode == 200) {
        // Successful request, parse the response body and return the data
        Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
        print('$responseData');
      } else if (response.statusCode == 301) {
        final redirectedUrl = response.headers['location'];
        //making new request
        final redirectedRespone = await http.post(
          Uri.parse('$redirectedUrl'),
          headers: header,
          body: requestBody,
        );
      } else {
        // Request failed, handle the error (you can throw an exception or return null)
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Exception occurred during the request, handle the error (you can throw an exception or return null)
      print('Exception: $e');
      return null;
    }
  }
}
