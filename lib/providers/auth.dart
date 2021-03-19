import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:st_mgt_shop_app/models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    //url changed from const to final, cause its runtime const and not compliation const
    //----
    // const url = Uri.https('<domain>', '/<path>')
    //final url = Uri.https('identitytoolkit.googleapis.com', '/v1/accounts:$urlSegment?key=AIzaSyCRYJJewWgq2g_UInSn467cJb3OPa3RI50');

    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyCRYJJewWgq2g_UInSn467cJb3OPa3RI50';

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
      //return Future.error(error);
    }

    //print(json.decode(response.body));
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}

//final url = 'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyCRYJJewWgq2g_UInSn467cJb3OPa3RI50';

// After http update to 0.13.0^ onwards
// const url = Uri.https('<domain>', '/<path>')
// http.post(url, ...)
//
