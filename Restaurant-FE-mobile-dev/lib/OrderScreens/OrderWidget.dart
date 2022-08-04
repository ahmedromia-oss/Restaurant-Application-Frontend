
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_fe_mobile/Drawer/drawer.dart';
import 'package:restaurant_fe_mobile/Models/Order.dart';
import 'package:restaurant_fe_mobile/Models/OrderItem.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_fe_mobile/OrderScreens/ItemInCart.dart';
import 'package:restaurant_fe_mobile/Providers/CartProvider.dart';
import 'package:restaurant_fe_mobile/Services/OrderSevices.dart';
import 'package:restaurant_fe_mobile/menuscreans/menu.dart';
import 'package:restaurant_fe_mobile/user%20screens/ratingOrder.dart';
import 'package:restaurant_fe_mobile/user%20screens/userLogin.dart';
import 'package:restaurant_fe_mobile/user%20screens/userProfileTemp.dart';
import 'package:restaurant_fe_mobile/user%20screens/userSignUp.dart';
import 'package:restaurant_fe_mobile/user%20screens/welcome.dart';
import 'package:jwt_decode/jwt_decode.dart';

int OrderId = 0;
double GlobalTotalPrice =0 ;
class OrderWidget extends StatefulWidget {


  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  double totalprice = 0;
  bool _isButtonDisabled = false;
  Future<OrderItem>? futureOrderItem;
@override
  void initState(){
    super.initState();
    _isButtonDisabled = false;
  }  
  
  
  void changeStatue(String DeliveryType , double TotalPrice , List Items) async{
    if(Items.length != 0){
      setState((){
      _isButtonDisabled = true;
      GlobalTotalPrice = TotalPrice;
    });
    await createOrder(TotalPrice , DeliveryType).then((value){    
      OrderId = int.parse(value.id);
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => Checkout())
      
    );
    setState((){
      _isButtonDisabled = false;
    });
  }
  }
  @override
  Widget build(BuildContext context) {
  String type_of_delivery = "In Restaurant";
  List<String> delivrey = ["In Restaurant" , "To Home" , "To Car" , "Take Away"];
    return Scaffold(
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
                padding: EdgeInsets.only( right: 30),
    
                child : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
    
                      Container(
                          padding: EdgeInsets.only( right: 150),
    
                          child :Center(
                            child: Text('Main Menu',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 28,)),
                          )
                      ),
                      
                    ]
                )
            ),
          ],
        ),
    
      body: Consumer<CartProvider>(builder: (_, CartProvider , child){
        totalprice = 0;
         for(int i = 0; i<CartProvider.Items.length;i++ ){ 
            totalprice = CartProvider.Items[i].price*CartProvider.Items[i].quantity + totalprice;
            
          }
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/1.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //  Image.asset(
            // "images/4.jpg",
            // fit: BoxFit.cover,
            // ),
            SingleChildScrollView(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top:20 ,left:20 ,right:20 ),
                    child:Expanded(
                    child: Container(
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50)),
                        color: Colors.blue[900]
                      ),
                      child:Center(
                        child: Column(
                          children: [
                            Column(
                              children: List.generate(CartProvider.Items.length,(index){
                              
                              return ItemInCart(item: CartProvider.Items[index]);
                              }
              
                              )
                            ),
                             StatefulBuilder(builder: (context , setState){
                return Container(
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.orange
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Type of delivery: " , style: TextStyle(color: Colors.white , fontSize: 10),),
                        DropdownButton(
                        style: TextStyle(color: Colors.grey[600]),
                        value:type_of_delivery,
                        onChanged:(String? newvalue){
                            setState(() {
                            type_of_delivery = newvalue!;
                            });
                        } ,
                         items: delivrey.map<DropdownMenuItem<String>>((e) {
                            return DropdownMenuItem(
                              child:Text(e),
                              value:e
                            );
                        }).toList(),
                        
                        ),
                      ],
                    ),
                  ),
                );
              }
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                
                  child:ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.transparent) , shadowColor: MaterialStateProperty.all(Colors.transparent)),
                        child: Container
                        (
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30) ,  color: Colors.orange,),
                         
                          width: double.infinity,
                          height:60,  
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Make Order" , style:TextStyle(fontSize: 10)),
                              Text("Total Price: $totalprice Pound" , style:TextStyle(fontSize: 10)),
                            ],
                          ),
                        ),
                        onPressed:_isButtonDisabled?null: (){
                          changeStatue(type_of_delivery, totalprice , CartProvider.Items
                          );

                          CartProvider.PromoResponse = "Try Promocode";
                        }
                  
                     
                  ),
                ),
                          ],
                        ),
                      ),
                    ),
                    ),
                  ),
                  
                ),
              ),
            )
          ],
            );
        
        }
      ), 
    );
  }
}

class Checkout extends StatefulWidget {
  const Checkout({ Key? key }) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
   Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to go back to cart?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          TextButton(
            onPressed: (){
              DeleteOrder(OrderId);
              Navigator.of(context).pop(true);
            },
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }
 
 
  @override
  void initState(){
    super.initState();
    
    
  }  
  // TextEditingController feedBackController = TextEditingController();
   TextEditingController AddressController = TextEditingController();
  TextEditingController additionalCommentController = TextEditingController();
  TextEditingController PromoCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: Image.asset(
            "images/logo.jpg",
            fit: BoxFit.contain,
            height: 80,
          ),
          actions: [
            Container(
              //padding: EdgeInsets.only( right: 30),
                child : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Container(
                          padding: EdgeInsets.only( right: 20),
                          child :Center(
                            child: Text('Check Out',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 28,)),
                          )
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
          image: AssetImage("images/6.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      padding: EdgeInsets.only(left: 20, top: 35, right: 20),
        child: Container(
            child:Consumer<CartProvider>(builder: (_, CartProvider , child){
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children:[
                        Material(
                          child: TextField(

                            controller: AddressController,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.green, width: 1.0),
                              ),
                              border: const OutlineInputBorder(),
                              labelText: 'Address',
                              labelStyle: new TextStyle(color: Colors.brown),
                              // border: OutlineInputBorder(),
                              // labelText: 'Address',
                            ),
                          ),
                        ),
                        SizedBox(
                          height:20,
                        ),
                        // Material(
                        //   child: TextField(
                        //
                        //     controller: feedBackController,
                        //     decoration: InputDecoration(
                        //       enabledBorder: const OutlineInputBorder(
                        //         borderSide: const BorderSide(color: Colors.green, width: 1.0),
                        //       ),
                        //       border: const OutlineInputBorder(),
                        //       labelText: 'feedback',
                        //       labelStyle: new TextStyle(color: Colors.brown),
                        //       // border: OutlineInputBorder(),
                        //       // labelText: 'Address',
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height:20,
                        // ),
                        Material(
                          child: TextField(

                            controller: additionalCommentController,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.green, width: 1.0),
                              ),
                              border: const OutlineInputBorder(),
                              labelText: 'additional comment',
                              labelStyle: new TextStyle(color: Colors.brown),
                            ),
                          ),
                        ),
                        SizedBox(
                          height:20,
                        ),

                        Material(
                          child: TextField(

                            controller: PromoCodeController,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.green, width: 1.0),
                              ),
                              border: const OutlineInputBorder(),
                              labelText: 'PromoCode',
                              labelStyle: new TextStyle(color: Colors.brown),
                              // border: OutlineInputBorder(),
                              // labelText: 'Address',
                            ),
                          ),
                        ),
                        SizedBox(
                          height:20,
                        ),
                        ButtonTheme(
                          minWidth: double.infinity,
                          child: MaterialButton(
                            onPressed: () async{
                              CartProvider.TestPromo(GlobalTotalPrice, PromoCodeController.text);
                            },
                            child: Text('Price Now: ${CartProvider.PromoResponse}',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                            color: Colors.brown,
                          ),
                        )
                      ],
                    ),
                    ElevatedButton(
                      child:Text("Check out",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)) ,
                      onPressed: () async {
                       
                        if(CartProvider.PromoResponse != "Invalid coupon code. Please try again."){
                          UpdateOrder(additionalCommentController.text, OrderId ,double.parse(CartProvider.PromoResponse));
                          Map<String, dynamic> payload = Jwt.parseJwt(aToken.AccessToken);

                          addAddress(AddressController.text, payload['sub'].toString());
                          for(int i = 0 ; i < CartProvider.Items.length ; i ++)
                          {
                            addorder(CartProvider.Items[i].quantity, CartProvider.Items[i].Item_id, OrderId);
                          }
                          CartProvider.Items = [];
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => ratingOrder(
                                // OrderId: OrderId
                              )));
                        }
                        else{
                          double Price = GlobalTotalPrice;
                          UpdateOrder(additionalCommentController.text, OrderId , Price);
                          Map<String, dynamic> payload = Jwt.parseJwt(aToken.AccessToken);

                          addAddress(AddressController.text, payload['sub'].toString());
                          for(int i = 0 ; i < CartProvider.Items.length ; i ++)
                          {
                            await addorder(CartProvider.Items[i].quantity, CartProvider.Items[i].Item_id, OrderId);
                          }
                          CartProvider.Items = [];

                          CartProvider.PromoResponse = "Test PromoCode";

                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => ratingOrder()));
                        CartProvider.PromoResponse = "Try Promocode";
                        setState(() {
                          CartProvider.PromoResponse;
                        });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.brown,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          textStyle: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              );
            }
            )
        )
    )
    // onWillPop: _onWillPop,

    );
      
    
  
}
}
