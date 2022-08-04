// ignore_for_file: avoid_print, avoid_unnecessary_containers, non_constant_identifier_names, file_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_fe_mobile/Drawer/drawer.dart';
import 'package:restaurant_fe_mobile/user%20screens/ordersHistory.dart';
import 'package:restaurant_fe_mobile/user%20screens/userForgotPass.dart';
import 'package:restaurant_fe_mobile/user%20screens/welcome.dart';
import 'package:restaurant_fe_mobile/user%20screens/userLogin.dart';

import './userAlbum.dart';
import 'package:http/http.dart' as http;

// import 'order_history.dart';
late String UserId;

String firstName = "";
String lastName = "";
String email = "";
String phoneNum = "";
int points = 0;

class User {
  final String first_name, last_name, email, phone_number;
  final int points, user_id;

  User({
    required this.user_id,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.phone_number,
    required this.points,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        user_id: json['id'],
        first_name: json['first_name'],
        last_name: json['last_name'],
        email: json['email'],
        phone_number: json['phone_number'],
        points: json['points']);
  }
}

class tempProfile extends StatefulWidget {
  // late Album aToken;
  tempProfile({Key? key}) : super(key: key);

  @override
  _tempProfState createState() => _tempProfState();
}

class _tempProfState extends State<tempProfile> {
  // late Album aToken;
  _tempProfState();

  Future<User> fetchUser() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/my-profile'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + aToken.AccessToken,
      },
    );

    if (response.statusCode == 200) {
      UserId = User.fromJson(jsonDecode(response.body)).user_id.toString();
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  late User futureUser = new User(
      user_id: 0,
      first_name: "",
      last_name: "",
      email: "",
      phone_number: "",
      points: 0);

  @override
  void initState() {
    //futureUser = fetchUser();
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
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Container(
                    padding: EdgeInsets.only(right: 20),
                    child: Center(
                      child: Text('Your Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w200,
                            fontSize: 28,
                          )),
                    )),
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
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
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
              ])),
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
          child: Container(
            child: FutureBuilder<User>(
                future: fetchUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    futureUser = snapshot.data!;
                    // print(futureUser.first_name);
                    return Column(
                      children: <Widget>[
                        ProfileDataWidget(
                            futureUser: futureUser,
                            label: "First Name",
                            property: futureUser.first_name),
                        ProfileDataWidget(
                            futureUser: futureUser,
                            label: "Last Name",
                            property: futureUser.last_name),
                        ProfileDataWidget(
                            futureUser: futureUser,
                            label: "Email",
                            property: futureUser.email),
                        ProfileDataWidget(
                            futureUser: futureUser,
                            label: "Phone Number",
                            property: futureUser.phone_number),
                        ProfileDataWidget(
                            futureUser: futureUser,
                            label: "Points",
                            property: futureUser.points.toString()),
                        SizedBox(
                          height: 20,
                        ),
                        ButtonTheme(
                          minWidth: double.infinity,
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => userForgotPass()),
                              );
                            },
                            child: Text('Reset Password',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                            color: Colors.brown,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ButtonTheme(
                          minWidth: double.infinity,
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ordersHistory()),
                              );
                            },
                            child: Text('View Order\'s History',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                            color: Colors.brown,
                          ),
                        )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                }),
          )),
    );
  }
}

class ProfileDataWidget extends StatelessWidget {
  const ProfileDataWidget({
    Key? key,
    required this.futureUser,
    required this.label,
    required this.property,
  }) : super(key: key);

  final User futureUser;
  final String label;
  final String property;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            label,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.brown),
                ),
              ),
              child: Text(
                property,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700]),
              )),
        ],
      ),
    );
  }
}
