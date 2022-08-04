// ignore_for_file: prefer_const_constructors, file_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './userAlbum.dart';
import './userLogin.dart';
import './userProfileTemp.dart';
import 'package:restaurant_fe_mobile/menuscreans/menu.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

const IP = "http://127.0.0.1:8000";

class userSignUp extends StatefulWidget {
  @override
  signUp_State createState() => signUp_State();
}

class signUp_State extends State<userSignUp> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  late String tokenH;

  late Album aToken;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).popAndPushNamed('/');
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
            child: Text('Sign up',
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
                      controller: firstNameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.green[50],
                        border: OutlineInputBorder(),
                        labelText: 'First name',
                      ),
                    )),
                Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment(0, -0.52),
                    child: TextField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.green[50],
                        border: OutlineInputBorder(),
                        labelText: 'last name',
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
                    child: ElevatedButton(
                      child: Text('Sign Up'),
                      onPressed: () async {
                        var URL = Uri.parse(IP + '/api/register');
                        var data = {
                          'first_name': firstNameController.text,
                          'last_name': lastNameController.text,
                          'email': emailController.text,
                          'password': passwordController.text,
                          'password_confirmation':
                              confirmPasswordController.text
                        };
                        try {
                          var response = await http.post(URL, body: data);
                          if (response.statusCode == 201) {
                            aToken = Album.fromJson(jsonDecode(response.body));
                            try {
                              tokenH = 'Bearer ' + aToken.AccessToken;
                              final response2 = await http.post(
                                  Uri.parse(IP +
                                      '/api/email/verification-notification'),
                                  headers: {
                                    HttpHeaders.authorizationHeader: tokenH
                                  });
                            } on Exception catch (__) {
                              final snackbar = SnackBar(
                                content: Text("Validation error"),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => tempProfile(
                                      //aToken : aToken,
                                      )),
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
                Container(
                    alignment: Alignment(0, 0.74),
                    child: Row(
                      children: <Widget>[
                        Text('Already have an account?'),
                        TextButton(
                          child: Text(
                            'Sign in',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => userLogin()),
                            );
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
