import 'package:cat_control/controller/Maincontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class direction extends StatefulWidget {
  const direction({super.key});

  @override
  State<direction> createState() => _DirectionState();

  
}

class _DirectionState extends State<direction> {

  Maincontroller controller = Get.put(Maincontroller());

  @override

  Widget build(BuildContext context) {
    return Container(
      height: 235,
      width: 235,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.lightBlue[100],
      ),

      child: GetBuilder<Maincontroller>(builder: (controller){
        return AnimatedRotation(
          turns: controller.turns,
          curve: Curves.ease,
          duration: Duration(seconds: 5),
          child: Image.asset("assets/arrow.png")
          ,
        );
      })
        );
      }

}