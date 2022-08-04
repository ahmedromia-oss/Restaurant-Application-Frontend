class Categories {
  String id;
  String name;
  Categories({required this.name , this.id = "1"});

   factory Categories.fromJson(Map<String, dynamic> jsonData) {
    return Categories(
      id:jsonData['id'].toString(),
      name: jsonData['category_name'].toString(),
      
    );
    
  }
}