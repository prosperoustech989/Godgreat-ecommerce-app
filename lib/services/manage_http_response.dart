import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void manageHttpResponse({ 
  required http.Response response, //the http response from the request 
  required BuildContext context,/// the context is to show snackbar 
  required VoidCallback onSuccess,//the callback to execute on a sucessful response

}){ 
  //Switch statement to handle different http status codes 
switch(response.statusCode){
  case 200://status code 200 indicate a successful request 
     onSuccess(); 
     break; 
     case 400:// status code 400 indicate bad request 
     showSnackBar(context,json.decode(response.body)['msg'] ?? 'Something went wrong');
     break; 
     case 500: // status code 500 indicates a server error
     showSnackBar(context,json.decode(response.body)['error'] ?? 'Server error');  
     break; 
     case 201: //status code 201 indicate a resources was created sucessfully 
     onSuccess(); 
     break; 

}
  
}  

void showSnackBar(BuildContext context , String title){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title))); 
}