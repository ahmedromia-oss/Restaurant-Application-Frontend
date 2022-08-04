// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_fe_mobile/Providers/CartProvider.dart';
import 'package:restaurant_fe_mobile/user%20screens/ordersHistory.dart';
import 'package:restaurant_fe_mobile/user%20screens/ratingOrder.dart';
import 'package:restaurant_fe_mobile/user%20screens/userAlbum.dart';
import './user screens/userSignUp.dart';
import './user screens/userLogin.dart';
import './user screens/welcome.dart';
import 'package:provider/provider.dart';
import './menuscreans//menu.dart';
import './user screens/userProfileTemp.dart';
import 'AdminScreens/CreateItem.dart';


void main() {
  late Album aToken;
  runApp(ChangeNotifierProvider(create:(context){
    return CartProvider();
  },
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: welcome(),
      routes: {
        '/' : (context) => welcome(),
        '/login' : (context) => userLogin(),
        '/mainMenu' : (context) => menu(),
        '/profile' : (context) => tempProfile(),
        '/orderHistory' : (context) => ordersHistory(),
      },
    ),
  ));
}