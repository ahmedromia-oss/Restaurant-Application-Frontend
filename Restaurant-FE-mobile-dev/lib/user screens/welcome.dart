// ignore_for_file: prefer_const_constructors, file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_fe_mobile/AdminScreens/adminLogin.dart';
import 'package:restaurant_fe_mobile/menuscreans/gusetmenu.dart';
import './userLogin.dart';

class welcome extends StatefulWidget {
  @override
  welcome_State createState() => welcome_State();
}

class welcome_State extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/3.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.all(10),
          child: ListView(children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(15),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => userLogin()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // background
                  onPrimary: Colors.yellow, // foreground
                ),
                child: Text(
                  'Login / Register ',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(50),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => guest()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // background
                  onPrimary: Colors.yellow, // foreground
                ),
                child: Text(
                  'Continue  as Guest ',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment(0, 1.0),
              padding: EdgeInsets.all(50),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => adminLogin()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // background
                  onPrimary: Colors.yellow, // foreground
                ),
                child: Text(
                  'temporary admin login for testing',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ])),
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Image.asset(
          "images/logo.jpg",
          fit: BoxFit.contain,
          height: 80,
        ),
        actions: [
          Text('Restaurant ',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 28,
              )),
        ],
      ),
    );
  }
}
