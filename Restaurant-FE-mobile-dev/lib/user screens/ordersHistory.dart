import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_fe_mobile/Drawer/drawer.dart';
import 'package:restaurant_fe_mobile/user%20screens/userProfileTemp.dart';
import 'package:restaurant_fe_mobile/user%20screens/welcome.dart';
import 'package:restaurant_fe_mobile/user%20screens/userLogin.dart';
import 'package:jwt_decode/jwt_decode.dart';
import './userAlbum.dart';
import 'package:http/http.dart' as http;

class Data {

  final String price, quantity, item_name, id, type_of_delivery;

  Data(
      {required this.price,
      required this.type_of_delivery,
      required this.quantity,
      required this.item_name,
      required this.id
      });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      price: json['price'].toString(),
      quantity: json['quantity'].toString(),
      type_of_delivery: json['type_of_delivery'],
      item_name: json['item_name'],
      id: json['id'].toString(),

    );
  }
}

class ordersHistory extends StatefulWidget {
  // late Album aToken;

  ordersHistory({
    Key? key
  }) : super(key: key);

  @override
  _OrderHistoryState createState() =>
      _OrderHistoryState();
}

class _OrderHistoryState extends State<ordersHistory> {
  _OrderHistoryState();

  Future<List<Data>> fetchData() async {

    Map<String, dynamic> payload = Jwt.parseJwt(aToken.AccessToken);

    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/order-history'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + aToken.AccessToken,
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode({
        'user_id': payload['sub'].toString(),
      }),
    );
    print( 'Response: ' + response.body);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => new Data.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  late Data futureData = new Data(price: '', quantity: '', type_of_delivery: "", item_name: "", id: "");


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Image.asset(
          "images/logo.jpg",
          fit: BoxFit.contain,
          height: 80,
        ),
        actions: [
          Container(
            //padding: EdgeInsets.only( right: 30),
              child : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Container(
                        padding: EdgeInsets.only( right: 20),
                        child :Center(
                          child: Text('Order\'s History',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w200,
                                fontSize: 28,)),
                        )
                    ),
                    PopupMenuButton<String>(
                      icon: Icon(
                        Icons.account_circle_outlined,
                        color: Colors.black87,
                      ),
                      onSelected: (String result) {
                        switch (result) {
                          case 'filter1':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => tempProfile(
                                    // aToken: aToken.AccessToken,
                                  )),
                            );
                            break;
                          case 'filter2':
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => welcome()),
                            );
                            break;
                          default:
                        }
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'filter1',
                          child: Text('My Profile'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'filter2',
                          child: Text('Log out'),
                        ),
                      ],
                    ),
                  ]
              )
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/6.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.only(left: 20, top: 35, right: 20),
        child: FutureBuilder<List<Data>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // futureData = snapshot.data;
              List<Data> data ;
              data = snapshot.data!;
              // return _jobsListView(data);
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              child: Text('Order ID: '+ data[index].id,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700]
                              ),
                            )
                          ),
                            Container(
                                child: Text('You have ordered '+ data[index].quantity+ ' of ' +data[index].item_name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[700]
                                  ),
                                )
                            ),
                            // Container(
                            //     child: Text(data[index].quantity,
                            //       style: TextStyle(fontSize: 20,
                            //           fontWeight: FontWeight.w600,
                            //           color: Colors.grey[700]
                            //       ),
                            //     )
                            // ),
                            Container(
                                child: Text('The type of delivary was '+ data[index].type_of_delivery,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[700]
                                  ),
                                )
                            ),
                            Container(
                                child: Text('The total order price was '+ data[index].price,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[700]
                                  ),
                                )
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(
                              color: Colors.green,
                            )
                          ]
                    ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
