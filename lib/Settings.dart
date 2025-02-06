import 'dart:ffi';

import 'package:cat_control/controller/Maincontroller.dart';
import 'package:cat_control/controller/NetworkController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController IP_controller = TextEditingController();


  Maincontroller controller = Get.put(Maincontroller());
  NetworkController networkController = Get.put(NetworkController());

  List<bool> isSelected = [false, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      
    height: 650,
    padding: EdgeInsets.only(top: 15),
    decoration: BoxDecoration(
      color:Color(0xFFfffafa),
      borderRadius: BorderRadius.circular(30),
    ),
      
      child: Column(
        children: [

          
          Row(
            children: [
              SizedBox(width: 10,),
              Text("Settings ⚙️",style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold

              ),)
            ],
          ), // Tittle

          SizedBox(height: 10,),
          Row(
            children: [
              SizedBox(width: 10,),

              Expanded(
                child: Container(
                  // height: 10,
                  width: 10,
                  child: TextField(
                    controller: IP_controller,
 
                    keyboardType: TextInputType.number,
                    // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    // onChanged: controller.updateNumber,
                    decoration: InputDecoration(
                      labelText: "IP Address",
                      border: OutlineInputBorder(),
                  
                ),
              ),
            ),
          ),
          TextButton(onPressed: (){
            print(IP_controller.text);
            networkController.address = IP_controller.text;

            print(controller.address.toString());
            controller.update();
            networkController.connectToWebSocket(networkController.address.toString());
            networkController.reconnectWebSocket(networkController.address.toString());
            networkController.update();
          },
          child: Icon(Icons.arrow_forward_sharp)),
          SizedBox(height: 20),

            ],
          ),
          SizedBox(height: 10,),
          // Map_type
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                child:  Text("Map Type 🗾",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              )                 
            ),
              ),
            Switch(value: controller.map, 
            onChanged: (Value){
              setState(() {
                controller.map =! controller.map;
                controller.update();
              });
            })

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
               Container(
                padding: EdgeInsets.all(15),
                child:  Text("test",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              )                 
            ),
          ),
          Switch(value: controller.map, 
            onChanged: (Value){
              setState(() {
                controller.map =! controller.map;
                controller.update();
              });
            })

            ],
          ),

          SizedBox(height: 50,),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
               Container(
                padding: EdgeInsets.all(15),
                child:  Text("Location",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              )                 
            ),
          ),

          GetBuilder<Maincontroller>(
            builder: (controller) {
              return Container(
              padding: EdgeInsets.all(15),
                child:  Text("${controller.location_accuracy }",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              )                 
            ),
          );
            },
          ),
          
          
          
          
          


            ],
          ),
          
          

        ],

      ),
    );
  }
}

