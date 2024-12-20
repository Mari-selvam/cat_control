
import 'package:cat_control/Map_View.dart';
import 'package:cat_control/info.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      // appBar: AppBar(
      //   title: Text("Hello"),
      //   toolbarHeight: 30,
      // ),

      drawer: Drawer(

      ),
  


      bottomNavigationBar: Container(
        height: 100,
        child: BottomNavigationBar(
          
          backgroundColor: Colors.orange[300],
          items: [BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.blue,),
            label: "home"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on,size: 40.0,),
              label: 'location'
              ),
              BottomNavigationBarItem(icon: Icon(Icons.games_rounded,size: 40.0,),
              

              label: "Control"
              )
            
            ]
        
            
            
          ),
      ),



      body: Row(
        children: [
          Expanded(child: info(),flex: 3,),
          Expanded(child: Map_View(),flex: 7)
        ],
      ),
    );
  }
}