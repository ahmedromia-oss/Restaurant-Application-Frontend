class OrderItem{
  String item_name = " ";
  final int Item_id;
  double price;
  int quantity;
  double totalprice  = 0;
  OrderItem({required this.Item_id,required this.price , required this.quantity , this.item_name = " "});

  factory OrderItem.fromJson(Map<String, dynamic> jsonData) {
    return OrderItem(
        Item_id: jsonData['item_id'],
        price: jsonData['price'],
        quantity: jsonData['quantity']
    );
  }


}