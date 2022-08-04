// ignore_for_file: prefer_const_constructors, file_names

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_fe_mobile/menuscreans/menu.dart';
import './userProfileTemp.dart';
import './userSignUp.dart';
import './userForgotPass.dart';
import './userAlbum.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

const IP = "http://127.0.0.1:8000";

late Album aToken;

class userLogin extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<userLogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
            ("images/logo.jpg"),
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
            child: Text('Sign in',
                style: GoogleFonts.adamina(
                  color: Colors.pink[200],
                  fontSize: 25,
                  letterSpacing: .5,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                )),
          ),
          Flexible(
              child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 20, right: 20, top: 100),
            constraints: BoxConstraints(maxHeight: double.infinity),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.green[50],
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
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
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => userForgotPass()),
                        );
                      },
                      child: Text('Forgot Password'),
                    )),
                Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                        child: Text('Login'),
                        onPressed: () async {
                          var URL = Uri.parse(IP + '/api/login');
                          var data = {
                            'email': emailController.text,
                            'password': passwordController.text,
                          };
                          try {
                            var response = await http.post(URL,
                                headers: {"Accept": "application/json"},
                                body: data);
                            if (response.statusCode == 200) {
                              aToken =
                                  Album.fromJson(jsonDecode(response.body));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => menu(
                                        // aToken: aToken,
                                        )),
                              );
                            } else {
                              final snackbar = SnackBar(
                                content: Text("network error occurred"),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                            }
                          } on Exception catch (_) {
                            final snackbar = SnackBar(
                              content: Text("network error occurred"),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          }
                        })),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('Don\'t have an account?'),
                    TextButton(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => userSignUp()),
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            ),
          )),
        ],
      ),
    );
  }
}
