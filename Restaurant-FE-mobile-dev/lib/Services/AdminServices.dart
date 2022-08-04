// ignore: file_names
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_fe_mobile/Models/Categories.dart';
import 'package:restaurant_fe_mobile/user%20screens/userLogin.dart';
import 'package:restaurant_fe_mobile/AdminScreens/adminLogin.dart';



List<Categories> result = [];

Future<String> AddPromoCode(String code , int percent_off ,String end_date , int users)async {
  final http.Response response = await http.post(
    Uri.parse('http://127.0.0.1:8000/api/admin/create'),
    headers: <String, String>{
      'Authorization':'bearer ${atoken.AccessToken}',
      "Access-control-allow-origin":"*",
      'Content-Type': 'application/json; charset=UTF-8',
    },
    
    body: jsonEncode(<dynamic, dynamic>{
      'code': code,
      'end_date' : end_date,
      'no_users': users,
      'precent_off': percent_off,
      'type': 'percent_off',
      'active':1
      
    }),
  );
   if (response.statusCode == 201) {
    final jsonResponse = response.body.toString();
    return jsonResponse;
  } else {
    return "Error in inserting Promocode";
  }
  
  
  

}

Future <List<Categories>> fetchCategory() async {

  final response =
  await http.get( Uri.parse('http://127.0.0.1:8000/api/admin/categories'),
   headers: <String, String>{
      'Authorization':'bearer ${atoken.AccessToken}',
      "Access-control-allow-origin":"*",
      'Content-Type': 'application/json; charset=UTF-8',

    },
  );
      if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    
     result = jsonResponse.map((data) =>Categories.fromJson(data)).toList();
     return result;
  } else {
  throw Exception('Unexpected error occured!');
  }
}
Future<String> AddItem(String item , double price , int category_id ,{String dateTime = "2010-10-10 00:00.000" , double offer = 0})async {
  final http.Response response = await http.post(
    Uri.parse('http://127.0.0.1:8000/api/admin/additem'),
    headers: <String, String>{
      'Authorization':'bearer ${atoken.AccessToken}',
      "Access-control-allow-origin":"*",
      'Content-Type': 'application/json; charset=UTF-8',
    },
    
    body: jsonEncode(<dynamic, dynamic>{
      'item_name': item,
      'offer_end_date' : dateTime,
      'offer': offer,
      'price':price,
      'category_id': category_id
      
    }),
  );
   if (response.statusCode == 201) {
    final jsonResponse = response.body.toString();
    return jsonResponse;
  } else {
    return "Error in inserting Item";
  }
  
  
  

}

