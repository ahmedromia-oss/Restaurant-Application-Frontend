// ignore_for_file: prefer_const_constructors, file_names, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './userResetPass.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

const IP = "http://127.0.0.1:8000";

class userForgotPass extends StatefulWidget {
  @override
  forgotPass_State createState() => forgotPass_State();
}

class forgotPass_State extends State<userForgotPass> {
  TextEditingController emailController = TextEditingController();
  static String message = "";
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: FloatingActionButton(
          onPressed: () {
            print('home page press');
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
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.fromLTRB(20, 100, 20, 250),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 50),
                    child: Text(
                        'Enter your email and we\'ll send you a reset link',
                        style: GoogleFonts.adamina(
                          color: Colors.pink[200],
                          fontSize: 20,
                          letterSpacing: .5,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                        )),
                  ),
                  Container(
                      alignment: Alignment(0, -.2),
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
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
                      alignment: Alignment(0, .09),
                      child: ElevatedButton(
                        child: Text('Send Reset Link'),
                        onPressed: () async {
                          message = "Network error";
                          isVisible = !isVisible;
                          var URL = Uri.parse(IP + '/api/forgot-password');
                          var data = {
                            'email': emailController.text,
                          };
                          try {
                            var response = await http.post(URL, body: data);
                            if (response.statusCode == 201) {
                              message = "Email sent";
                              isVisible = !isVisible;
                            } else if (response.statusCode == 500) {
                              message = "Email not found";
                              isVisible = !isVisible;
                            } else {
                              message = "Network error";
                              isVisible = !isVisible;
                            }
                          } on Exception catch (_) {
                            message = "Network Error caught";
                            isVisible = !isVisible;
                          }
                          print(message);
                        },
                      )),
                  Visibility(
                      visible: isVisible,
                      maintainState: true,
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(9),
                        child: Text(message,
                            style: TextStyle(color: Colors.red, fontSize: 15)),
                      ))
                ],
              )),
        ],
      ),
    );
  }
}
