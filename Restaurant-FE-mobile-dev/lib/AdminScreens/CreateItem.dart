import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_fe_mobile/AdminScreens/AdminProf.dart';
import 'package:restaurant_fe_mobile/AdminScreens/adminLogin.dart';
import 'package:restaurant_fe_mobile/Models/Categories.dart';
import 'package:restaurant_fe_mobile/Services/AdminServices.dart';
import "package:restaurant_fe_mobile/menuscreans/menu.dart";

String Response = "Add item";
String datee = " ";

class CreateItem extends StatefulWidget {
  
  const CreateItem({ Key? key }) : super(key: key);

  @override
  _CreateItemState createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  TextEditingController ItemNameController = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController Offer = TextEditingController();
 
  TextEditingController Offer_end_date = TextEditingController();
  bool _isButtonDisabled = false;
 
  @override
  void initState(){
    super.initState();
    _isButtonDisabled = false;
  }  
  

  @override
  Widget build(BuildContext context) {
    String category_name =" ";
    int category_id = 1;
    return Scaffold(
      body: Column(
          mainAxisAlignment:MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children:[ 
                Material(
                  child: TextField(
                          
                            controller: ItemNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Item Name',
                            ),
                          ),
                ),
                SizedBox(
                  height:20,
                ),
                    Material(
                      child: TextField(
                            keyboardType: TextInputType.number, 
                            controller:Offer,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'offer',
                            ),
                          ),
                    ),
                      SizedBox(
                  height:20,
                ),
                    

                        Material(
                          child: TextField(
                               keyboardType: TextInputType.number, 
                                controller: price,
                                decoration: InputDecoration(
                                  
                                  border: OutlineInputBorder(),
                                  labelText: 'Price',
                                ),
                              ),
                        ),
                        SizedBox(
                        height:20,
                        ),
                        Material(
                      child: DateTimeField(
                        decoration: InputDecoration(
                                  
                          border: OutlineInputBorder(),
                          labelText: 'Date',
                        ),
                        format: format,
                        onShowPicker: (context, currentValue) async {
                          final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                          if (date != null) {
                            final time = await showTimePicker(
                              context: context,
                              initialTime:
                                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                            );
                            datee =  DateTimeField.combine(date, time).toString();
                            
                            return DateTimeField.combine(date, time);
                          } else {
                            return currentValue;
                          }
                        },
                    ),
                            
                        
                            ),
              ]
                          ),

        FutureBuilder<List<Categories>>(
          future:fetchCategory() ,
          builder:  (context, snapshot){
            if (snapshot.hasData) {
              for(int i = 0; i < result.length; i ++){
                print (result[i].name);
              }
            category_name = result[0].name;
            category_id = int.parse(result[0].id);
            return StatefulBuilder(builder: (context , setState){
               
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
                        Text("Category name: " , style: TextStyle(color: Colors.white , fontSize: 10),),
                        DropdownButton(
                        style: TextStyle(color: Colors.grey[600]),
                        value:category_id.toString(),
                        onChanged: (String? newvalue){
                            setState(() {
                            category_id = int.parse(newvalue!);
                            
                            });
                        } ,
                         items: 
                        snapshot.data!.map<DropdownMenuItem<String>>((e) {
                          print(e.name);
                            return DropdownMenuItem(
                              child:Text(e.name),
                              value:e.id
                            );
                        }).toList(),
                        
                        ),
                      ],
                    ),
                  ),
                );
            },
            );
                            
            
            
                               
    
                    
                        
              
                      

                            }
                            
                            
            return CircularProgressIndicator();
          }
       
        ),
          ElevatedButton(child:Text("Add Item") ,

                        onPressed: _isButtonDisabled?null: () async {
                          setState(() {
                            _isButtonDisabled = true;
                          });
                          print(category_id);
                         
                          if(datee == " "){
                          (await  AddItem(ItemNameController.text, double.parse(price.text), category_id).then((value) => 
                          Response =  value.toString()
                          ));
                          setState(() {
                            Response;
                          });
                          }
                          else{
                            await AddItem(ItemNameController.text, double.parse(price.text) ,category_id, dateTime: datee , offer: double.parse(Offer.text)).then((value) =>  Response =  value.toString());
                            setState(() {
                            Response;
                          });
                          }
                          if(Response != "item is created successfully"){
                            setState(() {
                            _isButtonDisabled = false;
                          });
                        }
                          
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => AdminProfile(aToken: atoken)));
                          setState(() {
                            _isButtonDisabled = false;
                          });
                          
                          
                          
                        }
                        )
    
                        
          ],
        ), 
      
    );

    
  }
}