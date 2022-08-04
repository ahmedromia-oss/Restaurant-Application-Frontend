// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const IP = "http://127.0.0.1:8000";

class userResetPass extends StatefulWidget {
  @override
  resetPass_State createState() => resetPass_State();
}

class resetPass_State extends State<userResetPass> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow[200],
          title: Text('Restaurant',
              style: TextStyle(
                color: Colors.red[300],
                fontWeight: FontWeight.w400,
                fontSize: 28,
              )),
        ),
        body: Stack(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(("images/5.jpg")),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(20),
            child: Text('Sign in',
                style: GoogleFonts.adamina(
                  color: Colors.pink[200],
                  fontSize: 25,
                  letterSpacing: .5,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                )),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(9),
            child: Text('Enter your new password',
                style: TextStyle(color: Colors.black, fontSize: 20)),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              obscureText: true,
              controller: confirmPasswordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Confirm Password',
              ),
            ),
          ),
          Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: Text('Reset Password'),
                onPressed: () {
                  print(passwordController.text);
                },
              )),
        ]));
  }
}
