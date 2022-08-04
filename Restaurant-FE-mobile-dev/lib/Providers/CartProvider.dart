import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:restaurant_fe_mobile/Models/OrderItem.dart';
import 'package:restaurant_fe_mobile/Services/OrderSevices.dart';

import 'package:restaurant_fe_mobile/menuscreans/itemGit.dart' hide fetchItem;



class CartProvider with ChangeNotifier{

  List <OrderItem> Items = [];
  String PromoResponse = "Try Promocode";
  List <OrderItem> ItemsInMenu=[];
  int NumberOfOrders = 0;
  int index = 0;
  void TestPromo(double totalprice , String code) async{
   await Promocode(totalprice, code).then((value) => 
        PromoResponse = value
    );
    notifyListeners();
  }
  void Remove(){
    Items = [];
    notifyListeners();
  }
    
   void Decrement(OrderItem orderItem){
     
       for(int i = 0 ; i < Items.length ; i ++){
          if(Items[i].Item_id == orderItem.Item_id){
            index = i;
          }
        }
        Items[index].quantity = Items[index].quantity - 1;
        Items[index].totalprice = Items[index].totalprice-Items[index].price;
        if(Items[index].quantity == 0){
          Items.remove(Items[index]);
        }
        notifyListeners();
    }

    
   void AddToOrder(OrderItem orderItem){
      if((Items.map((e) => e.Item_id).contains(orderItem.Item_id)) == false)
      {
        orderItem.quantity = 1;
        Items.add(orderItem);
        

        NumberOfOrders = NumberOfOrders + 1;

        
        
      }
      else{
        
        for(int i = 0 ; i < Items.length ; i ++){
          if(Items[i].Item_id == orderItem.Item_id){
            index = i;
          }
        }
        
        Items[index].quantity = Items[index].quantity + 1;
        Items[index].totalprice = Items[index].price + Items[index].totalprice;
        
        
        
      }
      notifyListeners();
    }
      
}

      



  
