import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_fe_mobile/AdminScreens/AdminProf.dart';
import 'package:restaurant_fe_mobile/AdminScreens/adminLogin.dart';

import 'package:restaurant_fe_mobile/Models/Categories.dart';
import 'package:restaurant_fe_mobile/Models/Order.dart';
import 'package:restaurant_fe_mobile/Services/AdminServices.dart';
import "package:restaurant_fe_mobile/menuscreans/menu.dart";

String Response = "Add item";
String datee = " ";

class CreatePromoCode extends StatefulWidget {
  
  const CreatePromoCode({ Key? key }) : super(key: key);

  @override
  _CreatePromoCodeState createState() => _CreatePromoCodeState();
}

class _CreatePromoCodeState extends State<CreatePromoCode> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  TextEditingController CodeController = TextEditingController();
  TextEditingController users = TextEditingController();
  TextEditingController percent_off = TextEditingController();
 
  TextEditingController end_date = TextEditingController();
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
                          
                            controller: CodeController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'PromoCode',
                            ),
                          ),
                ),
                SizedBox(
                  height:20,
                ),
                    Material(
                      child: TextField(
                            keyboardType: TextInputType.number, 
                            controller:percent_off,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Percent off',
                            ),
                          ),
                    ),
                      SizedBox(
                  height:20,
                ),
                    

                        Material(
                          child: TextField(
                               keyboardType: TextInputType.number, 
                                controller: users,
                                decoration: InputDecoration(
                                  
                                  border: OutlineInputBorder(),
                                  labelText: 'users',
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
                          labelText: 'End Date',
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

       
          ElevatedButton(child:Text("Add PromoCode") ,

                        onPressed: _isButtonDisabled?null: () async {
                          setState(() {
                            _isButtonDisabled = true;
                          });
                          if(datee.isEmpty || CodeController.text.isEmpty || percent_off.text.isEmpty || users.text.isEmpty){
                            setState(() {
                            _isButtonDisabled = false;
                          });
                          }
                          else{
                            await AddPromoCode(CodeController.text ,int.parse(percent_off.text) , datee , int.parse(users.text));
                          
                          
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => AdminProfile(aToken: atoken)));
                          setState(() {
                            _isButtonDisabled = false;
                          });
                        
                          
                          }
                          
                        }
                        )
    
                        
          ],
        ), 
      
    );

    
  }
}