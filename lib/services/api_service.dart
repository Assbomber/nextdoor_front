import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  Future emailVerification(String email) async {
    try {
      var url =
          Uri.https('myzone.up.railway.app', 'api/auth/email_verification');
      Map data = {'email': email};
      // encode Map to JSON
      var body = json.encode(data);
      var response = await http.post(url, body: body);
      print(['&&&&&&', response.body]);
      if (response.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  Future registerUser(
      String email, String name, int otp, String password) async {
    try {
      var url = Uri.https('myzone.up.railway.app', 'api/auth/register');
      Map data = {
        "email": email,
        "name": name,
        "otp": otp,
        "password": password
      };
      // encode Map to JSON
      var body = json.encode(data);
      var response = await http.post(url, body: body);
      print(['&&&&&&', response.body]);
      if (response.statusCode == 201) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  Future loginUser(String email, String password) async {
    try {
      var url = Uri.https('myzone.up.railway.app', 'api/auth/login');
      Map data = {"email": email, "password": password};
      // encode Map to JSON
      var body = json.encode(data);
      var response = await http.post(url, body: body);
      print(['&&&&&&', response.statusCode]);
      if (response.statusCode == 201) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      print(e.toString());
      return e;
    }
  }
}
