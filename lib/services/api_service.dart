import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/response_handler.dart';
import '../constants/constants.dart';
import '../utils/utils.dart';

class ApiService {
  Future emailVerification(String email) async {
    try {
      var url = Uri.https(API_ENDPOINT, EMAIL_VERIFICATION);
      Map data = {'email': email};
      // encode Map to JSON
      var body = json.encode(data);
      var response = await http.post(url, body: body);
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          return Success(data['message']);
        default:
          final data = json.decode(response.body);
          return Failure(Exception(data['message']));
      }
    } on Exception catch (e) {
      return Failure(Exception(e));
    }
  }

  Future registerUser(
      String email, String name, int otp, String password) async {
    try {
      var url = Uri.https(API_ENDPOINT, REGISTER_USER);
      Map data = {
        'email': email,
        'username': name,
        'otp': otp,
        'password': password
      };
      // encode Map to JSON
      var body = json.encode(data);
      var response = await http.post(url, body: body);
      switch (response.statusCode) {
        case 201:
          final data = json.decode(response.body);
          return Success(data['message']);
        default:
          final data = json.decode(response.body);
          return Failure(Exception(data['message']));
      }
    } on Exception catch (e) {
      return Failure(Exception(e));
    }
  }

  Future loginUser(String email, String password) async {
    try {
      var url = Uri.https(API_ENDPOINT, LOGIN_API);
      Map data = {'email': email, 'password': password};
      // encode Map to JSON
      var body = json.encode(data);
      var response = await http.post(url, body: body);

      switch (response.statusCode) {
        case 201:
          final data = json.decode(response.body);
          String getToken = data['data']['token'];
          await storeToken('token', getToken);
          return Success(data['message']);
        default:
          final data = json.decode(response.body);
          return Failure(Exception(data['message']));
      }
    } on Exception catch (e) {
      return Failure(Exception(e));
    }
  }

  Future resetUserPassword(String email, String password, int otp) async {
    try {
      var url = Uri.https(API_ENDPOINT, RESET_PASSWORD);
      Map data = {'email': email, 'password': password, 'otp': otp};
      // encode Map to JSON
      var body = json.encode(data);
      var response = await http.post(url, body: body);

      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          return Success(data['message']);
        default:
          final data = json.decode(response.body);
          return Failure(Exception(data['message']));
      }
    } on Exception catch (e) {
      return Failure(Exception(e));
    }
  }
}
