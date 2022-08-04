// ignore_for_file: avoid_print, file_names, prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_fe_mobile/AdminScreens/CreateItem.dart';
import 'package:restaurant_fe_mobile/menuscreans/menu.dart';
import 'PromoCodeScreen.dart';
import 'adminAlbum.dart';
import 'adminRegister.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

const IP = "http://127.0.0.1:8000";

class AdminProfile extends StatefulWidget {
  final adAlbum aToken;

  const AdminProfile({
    Key? key,
    required this.aToken,
  }) : super(key: key);

  @override
  _AdminProfState createState() => _AdminProfState();
}

class _AdminProfState extends State<AdminProfile> {
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
            child: Text('Admin Dashboard',
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
            margin: EdgeInsets.only(left: 20, right: 20, top: 100, bottom: 200),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            alignment: Alignment.center,
            child: Row(
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                        child: Text('Register A new admin'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => adminSignUp(
                                      aToken: widget.aToken,
                                    )),
                          );
                        })),
                Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                        child: Text('Add new Item'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateItem(
                                    //aToken: widget.aToken,
                                    )),
                          );
                        })),
                Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                        child: Text('Create promo code'), onPressed: () {
                           Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreatePromoCode(
                                    //aToken: widget.aToken,
                                    )),
                          );
                        }))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
