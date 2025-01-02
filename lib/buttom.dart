import 'package:cat_control/Controler.dart';
import 'package:cat_control/direction.dart';
import 'package:cat_control/obstracle.dart';
import 'package:flutter/material.dart';

class bottom extends StatefulWidget {
  const bottom({super.key});

  @override
  State<bottom> createState() => _bottomState();
}

class _bottomState extends State<bottom> {
  @override
  Widget build(BuildContext context) {
    return Row(
              
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              
            
                children:[ 
                
                  // SizedBox(width: 10,height: 10,),
                  direction(),
                  SizedBox( width:20,),
                  Obstracle(),
                  SizedBox( width:20,),
                  Controler(),

                  ]
    );
  }
}