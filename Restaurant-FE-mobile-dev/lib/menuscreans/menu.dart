import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_fe_mobile/Drawer/drawer.dart';
import 'package:restaurant_fe_mobile/Models/OrderItem.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_fe_mobile/OrderScreens/OrderWidget.dart';
import 'package:restaurant_fe_mobile/Providers/CartProvider.dart';
import 'package:restaurant_fe_mobile/menuscreans/itemGit.dart';
import 'package:restaurant_fe_mobile/user%20screens/userLogin.dart';
import 'package:restaurant_fe_mobile/user%20screens/userProfileTemp.dart';
import 'package:restaurant_fe_mobile/user%20screens/welcome.dart';



class menu extends StatefulWidget {
  const menu({Key? key}) : super(key: key);

  @override
  _menuState createState() => _menuState();
}

class _menuState extends State<menu> {
//  String decoded = utf8.decode(base64.decode(aToken.AccessToken));
  final List mylist = [
    'images/p1.jpg',
    'images/p2.jpg',
    'images/p3.jpg',
    'images/p4.jpg',
    'images/p5.jpg',
    'images/p6.jpg',
    'images/p7.jpg',
    'images/p8.jpg',
    'images/p9.jpg',
    'images/p10.jpg',
    'images/p11.jpg',
    'images/p12.jpg',
    'images/p13.jpg',
    'images/p14.jpg',
    'images/p15.jpg',
    'images/p16.jpg',
    'images/p17.jpg',
    'images/p18.jpg',
    'images/p19.jpg',
    'images/p20.jpg',
    'images/p21.jpg',
    'images/p22.jpg',
    'images/p23.jpg',
    'images/p24.jpg',
    'images/p25.jpg',
    'images/p1.jpg',
    'images/p2.jpg',
    'images/p3.jpg',
    'images/p4.jpg',
    'images/p5.jpg',
    'images/p6.jpg',
    'images/p7.jpg',
    'images/p8.jpg',
    'images/p9.jpg',
    'images/p10.jpg',
    'images/p11.jpg',
    'images/p12.jpg',
    'images/p13.jpg',
    'images/p14.jpg',
    'images/p15.jpg',
    'images/p16.jpg',
    'images/p17.jpg',
    'images/p18.jpg',
    'images/p19.jpg',
    'images/p20.jpg',
    'images/p21.jpg',
    'images/p22.jpg',
    'images/p23.jpg',
    'images/p24.jpg',
    'images/p25.jpg',
  ];
  TextEditingController feedBackController = TextEditingController();
  Map<String, dynamic> payload = Jwt.parseJwt(aToken.AccessToken);
  late Future<List<GitItem>> futureItem;
  double rating = 0.0;
  @override
  void initState() {
    super.initState();
    futureItem = fetchItem();
  }
  @override
  Widget build(BuildContext context) {

    return Consumer<CartProvider>(builder: (_, CartProvider , child){
      return WillPopScope(
        onWillPop:()async => false,
        child: Scaffold(

          drawer: MyDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.brown,
            title: Image.asset(
              "images/logo.jpg",
              fit: BoxFit.contain,
              height: 80,
            ),
            actions: [
              Container(
                  child : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only( right: 20),
                            child :Center(
                              child: Text('Main Menu',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 28,)),
                            )
                        ),
                        Container(
                          padding: EdgeInsets.only( right: 7),
                          child :ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => OrderWidget()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white, // background
                              onPrimary: Colors.yellow, // foreground
                            ),
                            child: Text(
                              'View cart',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        PopupMenuButton<String>(
                          icon: Icon(
                            Icons.account_circle_outlined,
                            color: Colors.black87,
                          ),
                          onSelected: (String result) {
                            switch (result) {
                              case 'filter1':
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => tempProfile(
                                        // aToken: aToken.AccessToken,
                                      )),
                                );
                                break;
                              case 'filter2':
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => welcome()),
                                );
                                break;
                              default:
                            }
                          },
                          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'filter1',
                              child: Text('My Profile'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'filter2',
                              child: Text('Log out'),
                            ),
                          ],
                        ),
                      ]
                  )
              ),
            ],

          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/4.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            padding: EdgeInsets.only(left: 20, top: 35, right: 20),
            child: FutureBuilder<List<GitItem>>(
              future: futureItem,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {

                        return Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Image.network(mylist[index],
                                  width: 100,
                                  height: 100,
                                ),
                                Container(
                                    child: Text.rich(
                                      TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(text:'Item Name  :  ',
                                                style: TextStyle(color: Colors.black,fontSize: 18,) ,
                                                children: <TextSpan>[TextSpan(text:snapshot.data![index].itemName,
                                                  style: TextStyle(color: Colors.black , fontSize: 15,),
                                                )] ),
                                          ]
                                      ),
                                    )
                                ),
                                Container(
                                    child:  Text.rich(
                                      TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(text:'Item Price  :  ',
                                                style: TextStyle(color: Colors.black,fontSize: 18,) ,
                                                children: <TextSpan>[TextSpan(text:snapshot.data![index].price,
                                                  style: TextStyle(color: Colors.black , fontSize: 15,),
                                                )] ),
                                          ]
                                      ),
                                    )
                                ),
                                Container(
                                    child:Text.rich(
                                      TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(text:'Item Rating  :  ',
                                                style: TextStyle(color: Colors.black,fontSize: 18,) ,
                                                children: <TextSpan>[TextSpan(text: snapshot.data![index].rating.toString(),
                                                  style: TextStyle(color: Colors.black , fontSize: 15,),
                                                )] ),
                                          ]
                                      ),
                                    )
                                ),
                                Container(
                                    child:Text.rich(
                                      TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(text:'Item Offer  :  ',
                                                style: TextStyle(color: Colors.black,fontSize: 18,) ,
                                                children: <TextSpan>[TextSpan(text: snapshot.data![index].offer,
                                                  style: TextStyle(color: Colors.black , fontSize: 15,),
                                                )] ),
                                          ]
                                      ),
                                    )
                                ),
                                Container(
                                    child: Text.rich(
                                      TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(text:'Item Offer End Date  :  ',
                                                style: TextStyle(color: Colors.black,fontSize: 18,) ,
                                                children: <TextSpan>[TextSpan(text: snapshot.data![index].offerEndDate.toString(),
                                                  style: TextStyle(color: Colors.black , fontSize: 15,),
                                                )] ),
                                          ]
                                      ),
                                    )
                                ),
                                Center(
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("${snapshot.data![index].quantity}"),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 0),
                                                child: RaisedButton(
                                                  child: Text(
                                                    "+",
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                  onPressed: (){
                                                    setState(() {
                                                      snapshot.data![index].quantity = snapshot.data![index].quantity + 1;
                                                    });
                                                    // snapshot.data![index].quantity = snapshot.data![index].quantity + 1;
                                                    // CartProvider.Increment(snapshot.data![index]);
                                                    int x;
                                                    if(CartProvider.Items.indexWhere((Item) => CartProvider.Items.map((e) => e.Item_id).contains(Item.Item_id)) == -1){
                                                      x = 1;
                                                    }
                                                    else{
                                                      x = CartProvider.Items[CartProvider.Items.indexWhere((Item) => CartProvider.Items.map((e) => e.Item_id).contains(Item.Item_id))].quantity;
                                                    }
                                                    CartProvider.AddToOrder(OrderItem(Item_id: int.parse(snapshot.data![index].id) ,
                                                        price:double.parse(snapshot.data![index].price) ,
                                                        quantity: x , item_name: snapshot.data![index].itemName));
                                                  },
                                                  color: Colors.green[400],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Padding(
                                                  padding: const EdgeInsets.only(left: 10),
                                                  child: RaisedButton(
                                                    child: Text(
                                                      "-",
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                    onPressed: (){
                                                      if(snapshot.data![index].quantity > 0){
                                                        setState(() {
                                                          snapshot.data![index].quantity =  snapshot.data![index].quantity-1;
                                                        });
                                                      }
                                                      CartProvider.Decrement(
                                                          OrderItem(Item_id: int.parse(snapshot.data![index].id) ,
                                                              price:double.parse(snapshot.data![index].price) ,
                                                              quantity: snapshot.data![index].quantity ,
                                                              item_name: snapshot.data![index].itemName));
                                                    },
                                                    color: Colors.red,
                                                  )
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ), ), ),

                                TextButton(
                                  child: Text(
                                    'feedback and rating',
                                    style: TextStyle(fontSize: 20 , color: Colors.black),
                                  ),

                                  onPressed: ()=> showRating(int.parse(snapshot.data![index].id)),
                                ),

                                SizedBox(
                                  height: 15,
                                ),
                              ]
                          ),
                        );
                      }
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default show a loading spinner.
                return
                  CircularProgressIndicator();
              },
            ),
          ),
        ),
      );
    }
    );
  }
  Widget buildRating() => RatingBar.builder(
      initialRating: rating = 0,
      minRating: 1,
      itemSize: 46,
      itemPadding: EdgeInsets.symmetric(horizontal: 4),
      itemBuilder: (context, _) =>Icon(Icons.star, color: Colors.amber,),
      updateOnDrag: true,
      onRatingUpdate: (rating) => setState((){
        this.rating = rating;
      })
  );
  void showRating( int itemId) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Please rate the item'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // const SizedBox(height: 30,),
          buildRating(),
          Padding(
            padding: const EdgeInsets.only(top: 3, bottom: 3,),
          ),
          Material(
            child: TextField(
              controller: feedBackController,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 1.0),
                ),
                border: const OutlineInputBorder(),
                labelText: 'Feedback',
                labelStyle: new TextStyle(color: Colors.brown),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
            child: Text(
              'OK',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () async {
              if (feedBackController.text.isNotEmpty) {}
              else {
                feedBackController.text = 'null';
              }
              if(rating!=0){final response = await http.post(
                Uri.parse('http://127.0.0.1:8000/api/review-iteam'),
                headers: {
                  HttpHeaders.authorizationHeader: 'Bearer ' + aToken.AccessToken,
                  'Content-Type': 'application/json; charset=UTF-8'
                },
                body: jsonEncode({
                  'user_id' : payload['sub'].toString() ,
                  'item_id': itemId,
                  'rating': rating,
                  'feedback': feedBackController.text,
                }),
              );
              print( 'Response: ' + response.body);
              if (response.statusCode == 200) {
                // print(response.body);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => menu(
                      )),
                );
              } else {
                throw Exception('Unexpected error occured!');
              }
              }
              else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => menu(
                      )),);
              }
            }
        )
      ],
    ),
  );

}

