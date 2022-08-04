import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_fe_mobile/Models/Order.dart';
import 'package:restaurant_fe_mobile/user%20screens/userLogin.dart';




Future<String> Promocode (double total , String Code) async{
  final http.Response response = await http.post(
    Uri.parse('http://127.0.0.1:8000/api/store'),
    headers: <String, String>{
      'Authorization':'bearer ${aToken.AccessToken}',
      "Access-control-allow-origin":"*",
      'Content-Type': 'application/json; charset=UTF-8',
    },
    
    body: jsonEncode(<String, dynamic>{
      'total': total,
      'code':Code
    }),
  );

  if(response.statusCode == 200){
    final responsa = response.body.toString();
    return responsa;
  }
  else if(response.statusCode == 201){
    final responsa = response.body.toString();
    return responsa;
  }

    
  
  else{
    throw Exception('Failed to Load response');
  }

  
  }   

Future<Order> createOrder (double price , String type_of_delivery) async{
  final http.Response response = await http.post(
    Uri.parse('http://127.0.0.1:8000/api/addneworder'),
    headers: <String, String>{
      'Authorization':'bearer ${aToken.AccessToken}',
      "Access-control-allow-origin":"*",
      'Content-Type': 'application/json; charset=UTF-8',
    },
    
    body: jsonEncode(<String, dynamic>{
      'price': price,
      'type_of_delivery':type_of_delivery
    }),
  );

  if(response.statusCode == 201){
    final responsa = await Order.fromJson(json.decode(response.body));

    return responsa;

  }
  else{
    throw Exception('Failed to Load response');
  }

  
  }   
  


Future<http.Response> addorder(int quantity , int item_id , int order_id) {
  return http.post(
    Uri.parse('http://127.0.0.1:8000/api/addtoorder'),
    headers: <String, String>{
      'Authorization':'bearer ${aToken.AccessToken}',
      "Access-control-allow-origin":"*",
      'Content-Type': 'application/json; charset=UTF-8',
    },
    
    body: jsonEncode(<dynamic, dynamic>{
      'quantity': quantity,
      'item_id' : item_id,
      'order_id': order_id
      
    }),
  );
     
}
Future<http.Response> UpdateOrder (String additionalComment , int id , double TotalPrice){
  return http.post(
    Uri.parse('http://127.0.0.1:8000/api/updateorder/$id'),
    headers: <String, String>{
      'Authorization':'bearer ${aToken.AccessToken}',
      "Access-control-allow-origin":"*",
      'Content-Type': 'application/json; charset=UTF-8',
    },
    
    body: jsonEncode(<String, dynamic>{
      'additional_comment': additionalComment,
      'price':TotalPrice
    }),
  );
}

Future<http.Response> addAddress (String Location, String UserId){

  return http.post(
    Uri.parse('http://127.0.0.1:8000/api/add-another-addresses'),
    headers: <String, String>{
      'Authorization':'bearer ${aToken.AccessToken}',
      "Access-control-allow-origin":"*",
      'Content-Type': 'application/json; charset=UTF-8',
    },

    body: jsonEncode(<String, dynamic>{
      'user_id': UserId ,
      'location':Location,
    }),
  );
}


Future<http.Response> DeleteOrder (int id){
  return http.post(
    Uri.parse('http://127.0.0.1:8000/api/removeorder/$id'),
    headers: <String, String>{
      'Authorization':'bearer ${aToken.AccessToken}',
      "Access-control-allow-origin":"*",
      'Content-Type': 'application/json; charset=UTF-8',
    }
  );
}