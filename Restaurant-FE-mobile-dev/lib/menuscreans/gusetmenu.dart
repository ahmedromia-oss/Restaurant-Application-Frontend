import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_fe_mobile/Providers/CartProvider.dart';
import 'package:restaurant_fe_mobile/menuscreans/itemGit.dart';
import 'package:restaurant_fe_mobile/user%20screens/userSignUp.dart';


class guest extends StatefulWidget {
  const guest({Key? key}) : super(key: key);

  @override
  _guestState createState() => _guestState();
}
class _guestState extends State<guest> {
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
  late Future<List<GitItem>> futureItem;

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
                                MaterialPageRoute(builder: (context) => userSignUp()),
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
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => userSignUp()),
                                                    );
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
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => userSignUp()),
                                                      );
                                                    },
                                                    color: Colors.red,
                                                  )),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
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
}


