import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_fe_mobile/Drawer/drawer.dart';
import 'package:restaurant_fe_mobile/OrderScreens/OrderWidget.dart';
import 'package:restaurant_fe_mobile/menuscreans/menu.dart';
import 'package:restaurant_fe_mobile/user%20screens/userProfileTemp.dart';
import 'package:restaurant_fe_mobile/user%20screens/welcome.dart';
import 'package:restaurant_fe_mobile/user%20screens/userLogin.dart';

import 'package:http/http.dart' as http;

// import 'order_history.dart';

class ratingOrder extends StatefulWidget {
  ratingOrder({Key? key}) : super(key: key);

  @override
  _ratingOrder createState() => _ratingOrder();
}

class _ratingOrder extends State<ratingOrder> {
  _ratingOrder();

  double rating = 0.0;

  // Future<> fetchUser() async {
  //   // late Album aToken;
  //
  //   // print(aToken.AccessToken);
  //
  //   final response = await http.get(
  //     Uri.parse('http://127.0.0.1:8000/api/rating'), //take order_id, and the rate
  //     headers: {
  //       HttpHeaders.authorizationHeader: 'Bearer ' + aToken.AccessToken,
  //       //HttpHeaders.authorizationHeader: aToken.AccessToken,
  //     },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     // print(response.body.toString());
  //
  //     return User.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }

  @override
  void initState() {
    //futureUser = fetchUser();
    super.initState();
  }

  TextEditingController feedBackController = TextEditingController();

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
                          child: Text('Order Rate',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.check_circle_outline,
                color: Colors.green[900],
                size: 100,
              ),
              Text(
                "Thank you",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.w500, color: Colors.green),
              ),
              SizedBox(
                height: 40,
              ),

              Text(
                "Your opinion matters, so please write your feedback honstly in the box below",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey[700]),
              ),
              SizedBox(
                height:20,
              ),
              Material(
                child: TextField(
                  controller: feedBackController,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.green, width: 1.0),
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'Feedback',
                    labelStyle: new TextStyle(color: Colors.brown),
                    // border: OutlineInputBorder(),
                    // labelText: 'Address',
                  ),
                ),
              ),

              SizedBox(
                height:20,
              ),
              TextButton(
                child: Text(
                  'Press here to rate your latest order',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                ),
                onPressed: ()=> showRating(),
              ),
              // Container(
              //
              //   child:
              // ),
            ],
          )
      ),
    );
  }

  Widget buildRating() => RatingBar.builder(
      initialRating: rating,
      minRating: 1,
      itemSize: 46,
      itemPadding: EdgeInsets.symmetric(horizontal: 4),
      itemBuilder: (context, _) =>Icon(Icons.star, color: Colors.amber,),
      updateOnDrag: true,
      onRatingUpdate: (rating) => setState((){
        this.rating = rating;
      })
  );

  void showRating() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Please rate your latest order'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // const SizedBox(height: 30,),
          buildRating(),
        ],
      ),
      actions: [
        TextButton(
          child: Text(
            'OK',
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () async {
            final response = await http.post(
              Uri.parse('http://127.0.0.1:8000/api/rating'),
              headers: {
                HttpHeaders.authorizationHeader: 'Bearer ' + aToken.AccessToken,
                'Content-Type': 'application/json; charset=UTF-8'
              },
              body: jsonEncode({
                'id': OrderId,
                'rating': rating,
                'Feedback': feedBackController.text,
              }),
            );
            print( 'Response: ' + response.body);
            if (response.statusCode == 200) {
              // print(response.body);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => menu(
                      // aToken: aToken,
                    )),
              );
            } else {
              throw Exception('Unexpected error occured!');
            }
          },
        )
      ],
    ),
  );
}




