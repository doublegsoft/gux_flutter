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

Future<Map<String,dynamic>> get(String url, Map<String,dynamic> params) async {
  String urlWithParams = url;
  params.forEach((key, value) {
    if (urlWithParams.contains('?')) {
      urlWithParams += '&$key=$value';
    } else {
      urlWithParams += '?$key=$value';
    }
  });
  final uri = Uri.parse(urlWithParams);
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to post data');
  }
}

Future<Map<String,dynamic>> put(String url, Map<String,dynamic> params) async {
  final uri = Uri.parse(url);
  final response = await http.put(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(params),
  );
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('failed to get data');
  }
}

Future<Map<String,dynamic>> patch(String url, Map<String,dynamic> params) async {
  final uri = Uri.parse(url);
  final response = await http.patch(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(params),
  );
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('failed to get data');
  }
}

Future<Map<String,dynamic>> delete(String url, Map<String,dynamic> params) async {
  final uri = Uri.parse(url);
  final response = await http.delete(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(params),
  );
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('failed to get data');
  }
}