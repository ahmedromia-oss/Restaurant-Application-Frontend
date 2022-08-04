import 'package:flutter/material.dart';
import 'package:restaurant_fe_mobile/Models/OrderItem.dart';
import 'package:restaurant_fe_mobile/Providers/CartProvider.dart';
import 'package:provider/provider.dart';


class ItemInCart extends StatefulWidget {
  final OrderItem item;
  

  ItemInCart({ Key? key , required this.item}) : super(key: key);

  
  

  @override
  _ItemInCartState createState() => _ItemInCartState();
}

class _ItemInCartState extends State<ItemInCart> {
  
  @override
  
  Widget build(BuildContext context) {

   
    return Consumer<CartProvider>(builder:(context , Home , child){

    
    return Padding(
      padding: const EdgeInsets.only(left: 10 , right: 10 , top: 20 , bottom: 20),
      child: Column(
        children: [
          Container(
            
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${widget.item.item_name}" , 
                      style: TextStyle(fontSize: 15 , color: Colors.white),),
                      Text("Price ${widget.item.price}" , 
                      style: TextStyle(fontSize: 10 , color: Colors.white),),
                      
                    ],

                  ),
                ),
               
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text("Quantity: ${widget.item.quantity}" , 
                      style: TextStyle(fontSize: 10 , color: Colors.white),),
                    
                    ],
                  ),
                ),
              ],
            ),
            width:double.infinity,
            
            height: 100,
            
            decoration: BoxDecoration(
              color: Colors.transparent,
              
              
          ),
          ),
          Divider(height: 10,
          color: Colors.white,
          )
        ],
      )
      
    );

    }
    
    );
  }
}