// import 'dart:convert';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class CallApi {
  // final String _url = Uri.parse('http://logintut.localhost/api/');
  var _urlAuth = 'https://paathaiapi.moodfor.codes/api/';
  var _urlwithoutAuth = 'https://class.moodfor.codes/api/';
  // var _urlwithoutAuth = 'https://moodfor.codes/api/'
  //
  var _urlLogin = 'https://paathaiapi.moodfor.codes/api/';

  var token;

  authData(data, apiUrl) async {
    var fullUrl = Uri.parse(_urlLogin + apiUrl);
    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

   postData(data, apiUrl) async {
    var fullUrl = Uri.parse(_urlLogin + apiUrl);
    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }


  postRoutes(data, apiUrl) async {
    var fullUrl = Uri.parse(_urlAuth + apiUrl);
    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  postPoints(data, apiUrl) async {
    var fullUrl = Uri.parse(_urlAuth + apiUrl);
    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  getRoutes(apiUrl) async {
    var fullUrl = Uri.parse(_urlAuth + apiUrl);
    return await http.get(
      fullUrl,
      headers: _setHeaders(),
    );
  }

  getPoints(apiUrl) async {
    var fullUrl = Uri.parse(_urlAuth + apiUrl);
    return await http.get(
      fullUrl,
      headers: _setHeaders(),
    );
  }

  updateRoutes(data, apiUrl) async {
    var fullUrl = Uri.parse(_urlAuth + apiUrl);
    return await http.put(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  deleteRoutes(data, apiUrl) async {
    var fullUrl = Uri.parse(_urlAuth + apiUrl);
    return await http.delete(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  // getData(apiUrl) async {
  //    var fullUrl = _url + apiUrl + await _getToken();
  //    return await http.get(
  //      fullUrl,
  //      headers: _setHeaders()
  //    );
  // }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
          'Authorization': 'Bearer $token'
      };
}
