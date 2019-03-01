import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  final String urlBase;

  Api(this.urlBase);

  Future<dynamic> get(String url, {Map<String, String> headers}) async {
    try {
      http.Response response = await http.get(urlBase + url, headers: headers);
      final statusCode = response.statusCode;
      if (statusCode < 200 || statusCode >= 300 || response.body == null) {
        throw new FetchDataException("Error request:", statusCode);
      }
      JsonDecoder decoder = const JsonDecoder();
      print(response.body);
      return decoder.convert(response.body);
    } catch (e) {
      throw new FetchDataException(e.toString(), 0);
    }
  }
}

class FetchDataException implements Exception {
  String _message;
  int _code;

  FetchDataException(this._message, this._code);

  String toString() {
    return "Exception: $_message/$_code";
  }

  int code() {
    return _code;
  }
}
