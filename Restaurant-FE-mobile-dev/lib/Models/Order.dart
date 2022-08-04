 class Order {
  String id;
  String price;
  String type_of_delivery;
  // String rating;
  // String Feedback;
  // String additional_comment;

   Order({required this.price,required this.type_of_delivery , this.id = "1"});

   factory Order.fromJson(Map<String, dynamic> jsonData) {
    return Order(
      id:jsonData['id'].toString(),
      price: jsonData['price'].toString(),
      type_of_delivery: jsonData['type_of_delivery']
    );
    
  }
}
class PromoCode {
 
  String totalprice;
  String code;
  // String rating;
  // String Feedback;
  // String additional_comment;

   PromoCode({required this.totalprice,required this.code});

   factory PromoCode.fromJson(Map<String, dynamic> jsonData) {
    return PromoCode(
    
      totalprice: jsonData['total'].toString(),
      code: jsonData['code']
    );
    
  }
}