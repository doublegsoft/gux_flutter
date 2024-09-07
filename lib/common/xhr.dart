import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String,dynamic>> post(String url, Map<String,dynamic> params) async {
  final uri = Uri.parse(url);
  final response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(params),
  );
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to post data');
  }
}