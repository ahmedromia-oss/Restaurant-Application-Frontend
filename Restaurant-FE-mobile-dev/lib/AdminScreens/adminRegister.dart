// ignore_for_file: prefer_const_constructors, file_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './adminAlbum.dart';
import 'package:restaurant_fe_mobile/menuscreans/menu.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

const IP = "http://127.0.0.1:8000";

class adminSignUp extends StatefulWidget {
  final adAlbum aToken;

  const adminSignUp({
    Key? key,
    required this.aToken,
  }) : super(key: key);

  @override
  _adSignUpState createState() => _adSignUpState();
}

class _adSignUpState extends State<adminSignUp> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  late int isSuper;
  bool isSwitched = false;

  late String tokenH;
  late adAlbum aToken;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => menu(
                      // aToken: aToken,
                      )),
            );
          },
          child: Image.asset(
            'images/logo.jpg',
            fit: BoxFit.contain,
            height: 80,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
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
            padding: EdgeInsets.all(9),
            child: Text('Add a new admin',
                style: GoogleFonts.adamina(
                  color: Colors.pink[200],
                  fontSize: 25,
                  letterSpacing: .5,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                )),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            margin: EdgeInsets.only(left: 20, right: 20, top: 100),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment(0, -0.82),
                    child: TextField(
                      controller: userNameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.green[50],
                        border: OutlineInputBorder(),
                        labelText: 'username',
                      ),
                    )),
                Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment(0, -0.22),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.green[50],
                        border: OutlineInputBorder(),
                        labelText: 'Email Address',
                      ),
                    )),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  alignment: Alignment(0, 0.05),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.green[50],
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  alignment: Alignment(0, 0.34),
                  child: TextField(
                    obscureText: true,
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.green[50],
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password',
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    alignment: Alignment(0, 0.59),
                    child: Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                          isSwitched ? isSuper = 1 : isSuper = 0;
                        });
                      },
                    )),
                Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    alignment: Alignment(0, 0.59),
                    child: ElevatedButton(
                      child: Text('Sign Up'),
                      onPressed: () async {
                        var URL = Uri.parse(IP + '/api/admin/register');
                        var data = {
                          'username': userNameController.text,
                          'email': emailController.text,
                          'password': passwordController.text,
                          'password_confirmation':
                              confirmPasswordController.text,
                          'superadmin': isSuper.toString()
                        };
                        try {
                          // tokenH = 'Bearer ' + widget.aToken.AccessToken;
                          var response = await http.post(URL,
                              headers: {
                                HttpHeaders.authorizationHeader: tokenH
                              },
                              body: data);
                          if (response.statusCode == 200) {
                            SnackBar(
                              content: Text('Admin Added'),
                            );
                          } else {
                            String message;
                            if (aToken.message == null) {
                              message = "something went wrong";
                            } else {
                              message = aToken.message;
                            }
                            final snackbar = SnackBar(
                              content: Text(message),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          }
                        } on Exception catch (_) {
                          final snackbar = SnackBar(
                            content: Text("network error occurred"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }
                      },
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
