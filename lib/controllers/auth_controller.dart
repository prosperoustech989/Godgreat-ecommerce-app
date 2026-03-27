import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:godgreat_app/global_variables.dart';
import 'package:godgreat_app/models/user.dart';
import 'package:godgreat_app/services/manage_http_response.dart';
import 'package:godgreat_app/views/register_screen.dart';
import 'package:godgreat_app/views/screens/main_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthController {
  Future<void> signUpUsers({
    required context,
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      User user = User(
        id: "",
        fullName: fullName,
        email: email,
        state: "",
        city: "",
        locality: "",
        password: password,
        token: '',
      );
      http.Response response = await http.post(
        Uri.parse('$uri/api/signup'),
        body: jsonEncode(
          user.toMap(),
        ), //covert the user object to jason for the request body
        headers: <String, String>{
          // set the Headers for the request
          "Content-Type":
              'application/json; charset=UTF-8', //specify the context type as json
        },
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegisterScreen()),
          );
          showSnackBar(context, 'Account has been created for you');
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  ///signin users function
  Future<void> signInUsers({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/api/signin"),
        body: jsonEncode({
          'email': email, //include the email in the request body,
          'password': password, //include the password in the request body,
        }),
        headers: <String, String>{
          //this will set the header
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      //Handle the response using the managehttpresponse

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
            (Route) => false,
          );
          showSnackBar(context, 'Logged In');
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }
}
