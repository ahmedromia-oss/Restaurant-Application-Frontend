import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;



List<GitItem> gitItemFromJson(String str) => List<GitItem>.from(json.decode(str).map((x) => GitItem.fromJson(x)));

class GitItem {
  GitItem({
   required this.id,
   required this.itemName,
    required this.rating,
    required this.price,
    required this.offer,
    required this.offerEndDate,
  });
  String id;
  String itemName;
  String rating;
  String price;
  String offer;
  DateTime offerEndDate;
  int quantity = 0;

  factory GitItem.fromJson(Map<String, dynamic> json) => GitItem(
    id: json['id'].toString(),
    itemName: json["item_name"],
    rating: json["rating"].toString(),
    price: json["price"],
    offer: json["offer"],
    offerEndDate: DateTime.parse(json["offer_end_date"]),
  );
}

Future <List<GitItem>> fetchItem() async {
//  Uri temp = Uri.parse('http://localhost/api/All-Items') ;
  final response =
  await http.get( Uri.parse('http://127.0.0.1:8000/api/All-Items'));
  //await http.post(print(temp.path));
      //await http.get((Uri.parse('http://10.0.2.2:8000/api/All-Items'));
   // print(response);
   // print('*********************************************');
   // print(json.decode(response.body));
  // print('*********************************************');
      if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    //print(jsonResponse.map());
    return jsonResponse.map((data) =>GitItem.fromJson(data)).toList();
  } else {
  throw Exception('Unexpected error occured!');
  }
}