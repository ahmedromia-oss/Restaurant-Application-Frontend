import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_fe_mobile/Providers/CartProvider.dart';
import 'package:restaurant_fe_mobile/menuscreans/menu.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
    Widget build(BuildContext context) {
      return Consumer<CartProvider>(builder: (_, CartProvider , child){
        return Drawer(
          child : Container(
            color : Colors.black54,
            child: ListView(
              children: <Widget>[
                Image.asset( "images/logo.jpg",
                  fit: BoxFit.contain,
                  height: 200,
                  width: 100,
                ),
                Card(
                  color : Colors.white,
                  elevation: 5,
                  child: ListTile(
                    title : Text('User Profile',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).popAndPushNamed('/profile');
                    },
                  ),
                ),
                Card(
                  color : Colors.white,
                  elevation: 5,
                  child: ListTile(
                    title : Text('Main Manu',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                    onTap: (){
                      CartProvider.Remove();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => menu()),
                      );
                    },
                  ),
                ),
                Card(
                  color : Colors.white,
                  elevation: 5,
                  child: ListTile(
                    title : Text('Orders History',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).popAndPushNamed('/orderHistory');
                    },
                  ),
                ),

                Card(
                  color : Colors.white,
                  elevation: 5,
                  child: ListTile(
                    title : Text('Logout',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                    onTap: (){
                      CartProvider.Remove();
                      Navigator.of(context).popAndPushNamed('/');
                    },
                  ),
                ),
              ],
            ),
          ),
      
        );
      }
      );
  }
}