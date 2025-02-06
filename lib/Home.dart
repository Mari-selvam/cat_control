
import 'package:cat_control/Map_View.dart';
import 'package:cat_control/Settings.dart';
// import 'package:cat_control/Settings.dart';
import 'package:cat_control/controller/Maincontroller.dart';
import 'package:cat_control/controller/NetworkController.dart';
import 'package:cat_control/info.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}



class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Maincontroller controller = Get.put(Maincontroller());
  
  NetworkController networkController = Get.put(NetworkController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(preferredSize: Size.fromHeight(0.1), child: AppBar(
        backgroundColor: Color(0XFF17171d),

      )),
      key: _scaffoldKey,
      backgroundColor: const Color.fromARGB(26, 96, 91, 91),
      
      endDrawer: Drawer(

        
        width: 600,
        child: ListView(

          children:[
            const DrawerHeader(

              decoration: BoxDecoration(
                color: Colors.black54,
                image: DecorationImage(
                  image: AssetImage("assets/fxec.jpg"),
                  fit: BoxFit.cover
                )
              ),
              child:Text("Location ",style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),)
                          
            ),
            
            ListTile(
              title: const Text("APJ Block"),
              leading:const Icon(Icons.account_balance),
              // hoverColor: Colors.lightBlue,
              contentPadding: const EdgeInsets.fromLTRB(50.0,10.0,0.0,0.0),
              // onTap: _onTileTap
              
              

            ),
            ListTile(
              title: const Text("Main Block"),
              leading:const Icon(Icons.school),

              contentPadding: const EdgeInsets.fromLTRB(50.0,10.0,0.0,0.0),
              onTap: (){
                
              },



            ),
            ListTile(
              title: Text("Mechanical Block"),
              leading: Icon(Icons.precision_manufacturing),
              contentPadding: const EdgeInsets.fromLTRB(50.0,10.0,0.0,0.0),

            ),
            ListTile(
              title: Text("COE Block"),
              leading: Icon(Icons.assignment_ind,),
              contentPadding: const EdgeInsets.fromLTRB(50.0,10.0,0.0,0.0),

            ),
            ListTile(
              title: Text("Library"),
              leading: Icon(Icons.local_library),
              contentPadding: const EdgeInsets.fromLTRB(50.0,10.0,0.0,0.0),

              
            ),
            ListTile(
              title: Text("Canteen"),
              leading: Icon(Icons.fastfood),
              contentPadding: const EdgeInsets.fromLTRB(50.0,10.0,0.0,0.0),
              onTap: (){
                print("hello");
              },
            ),
            ListTile(
              title: Text("Play Ground"),
              leading: Icon(Icons.directions_run),
              contentPadding: const EdgeInsets.fromLTRB(50.0,10.0,0.0,0.0),
            ),
            ListTile(
              title: Text("Basket-ball Ground"),
              leading: Icon(Icons.sports_basketball),
              contentPadding: const EdgeInsets.fromLTRB(50.0,10.0,0.0,0.0),
            ),
            ListTile(
            title: Text("Gym"),
              leading: Icon(Icons.fitness_center),
              contentPadding: const EdgeInsets.fromLTRB(50.0,10.0,0.0,0.0),
            ),
            
            
          ],


        ),

      ),
  


      bottomNavigationBar: Container(
        height: 100,
        child: BottomNavigationBar(
          fixedColor: Colors.black,
          
          backgroundColor: Colors.black,
          items: [


            BottomNavigationBarItem(icon: Icon(Icons.games_rounded,color: Color(0xffA7A7AC),size: 40.0,),
            backgroundColor: Colors.black,
              

            label: "Control"
              ),
            BottomNavigationBarItem(

            icon: Icon(Icons.settings,color: Color(0xffA7A7AC),size: 40.0,),
            label: "",
            tooltip: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(controller.audio_icon,color: Color(0xffA7A7AC),size: 40.0,),
              label: 'Emerangency ',
              
              
              
              
              ),


            BottomNavigationBarItem(
              icon: Icon(Icons.location_on,color: Color(0xffA7A7AC),size: 40.0,),
              label: 'location',
              
              
              
              ),
              BottomNavigationBarItem(
              icon: Icon(Icons.bug_report,color: Color(0xffA7A7AC),size: 40.0,),
              label: 'Terminal',
              
              
              
              ),

              
              
            
            ],

            onTap: (index) => {

              if (index == 1){
                
                controller.view =! controller.view,
                print(controller.view),
                controller.update()
               
                

              }

              else if (index == 3){
                
                _scaffoldKey.currentState?.openEndDrawer(),
                


              }
              else if (index == 0){
                if(controller.recorderController.isRecording != true){

                
                controller.mic = !(controller.mic),
                controller.update()
                
                }

                
                

                
              }

              else if( index == 2){
                controller.audio_icon = Icons.volume_mute,
                controller.update()
              }

              

            },
        
            
            
          ),
      ),



      body:  Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    GetBuilder<Maincontroller>(builder: 
                    (controller) =>
                      controller.view ?
                      Expanded(child: info(), flex: 3):

                      Expanded(child: Settings(), flex: 3)
                    ),

                    Expanded(child: Map_View(), flex: 7)

                  
                    
                        


                   

                  ],
                ),
              ),
            ],
          ),
        ],
      ),


    floatingActionButton: FloatingActionButton(
      onPressed: () {
        controller.rotateArrow();
        controller.update();

        networkController.sendMessage("hi");
        networkController.update();
      },
  child: Icon(Icons.rotate_right),
),

  );
  }

}


void _showSettingsDialog(BuildContext context) {
    var IP_address;
    TextEditingController textController = TextEditingController(text: IP_address);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(

          title: Text("App Settings"),
          content: Container(
            height: 200,
            width: 300,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Dark Mode"),
                    
                  ],
                  
                ),
                SizedBox(height: 10,),
                Row(children: [
                  Text("IP : "),
                   
                    
                  ],

                ),
              ],
              
            
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
