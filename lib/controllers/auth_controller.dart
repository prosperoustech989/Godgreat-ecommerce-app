import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:godgreat_app/global_variables.dart';
import 'package:godgreat_app/models/user.dart';
import 'package:godgreat_app/services/manage_http_response.dart';
import 'package:godgreat_app/views/login_screen.dart';
import 'package:godgreat_app/views/register_screen.dart';
import 'package:godgreat_app/views/screens/main_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:godgreat_app/provider/user_provider.dart';

final providerContainer = ProviderContainer();

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
        onSuccess: () async {
          //Access sharedpreferences for token and user data storage
          SharedPreferences preferences = await SharedPreferences.getInstance();

          //Extract the authentication from the response body
          String token = jsonDecode(response.body)['token'];

          //Store the authentication token securely in sharedpreferences
          await preferences.setString('auth_token', token);

          //Encode the user data recived from the backend as json
          final userJson = jsonEncode(jsonDecode(response.body)['user']);

          //update the application state with the user data using Riverpod
          providerContainer.read(userProvider.notifier).setUser(userJson);

          //Store the data in sharepreference for future use

          await preferences.setString('user', userJson);

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
            MaterialPageRoute(builder: (context) => MainScreen()),
            (route) => false,
          );
          showSnackBar(context, "Logged In");
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  //Signout
  Future<void> signOutUser({required context}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      //Clear the token and user from Sharedpreferences
      await preferences.remove(' auth_token');
      await preferences.remove('user');
      //clear the user state
      providerContainer.read(userProvider.notifier).signOut();
      //navigate the user back to the login screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        ),
        (route) => false,
      );
      showSnackBar(context, 'Singnout sucessfully');
    } catch (e) {
      showSnackBar(context, 'error signing out');
    }
  }
}
