// ignore_for_file: prefer_const_constructors, file_names

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_fe_mobile/AdminScreens/AdminProf.dart';
import './adminAlbum.dart';
import 'package:restaurant_fe_mobile/menuscreans/menu.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

const IP = "http://127.0.0.1:8000";

late adAlbum atoken;

class adminLogin extends StatefulWidget {
  @override
  _adloginState createState() => _adloginState();
}

class _adloginState extends State<adminLogin> {
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
            padding: EdgeInsets.all(20),
            child: Text('Admin Sign in',
                style: GoogleFonts.adamina(
                  color: Colors.pink[200],
                  fontSize: 25,
                  letterSpacing: .5,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                )),
          ),
          Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.fromLTRB(20, 100, 20, 200),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                      alignment: Alignment(0, -0.66),
                      padding: EdgeInsets.all(20),
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
                    alignment: Alignment(0, -0.3),
                    padding: EdgeInsets.all(20),
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
                      alignment: Alignment(0, 0.08),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                          child: Text('Login'),
                          onPressed: () async {
                            var URL = Uri.parse(IP + '/api/admin/login');
                            var data = {
                              'email': emailController.text,
                              'password': passwordController.text,
                            };
                            try {
                              var response = await http.post(URL,
                                  headers: {"Accept": "application/json"},
                                  body: data);
                              atoken =
                                  adAlbum.fromJson(jsonDecode(response.body));
                              if (response.statusCode == 200) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdminProfile(
                                            aToken: atoken,
                                          )),
                                );
                              } else {
                                String message;
                                if (atoken.message == null) {
                                  message = "something went wrong";
                                } else {
                                  message = atoken.message;
                                }
                                final snackbar = SnackBar(
                                  content: Text(message),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                              }
                            } on Exception catch (_) {
                              final snackbar2 = SnackBar(
                                content: Text('NetWork Error Occured'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar2);
                            }
                          }))
                ],
              )),
        ],
      ),
    );
  }
}
