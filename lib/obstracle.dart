import 'package:cat_control/controller/Maincontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class Obstracle extends StatefulWidget {
  const Obstracle({super.key});

  @override
  State<Obstracle> createState() => _ObstracleState();
}

class _ObstracleState extends State<Obstracle> {

  Maincontroller controler = Get.put(Maincontroller());

  @override
  Widget build(BuildContext context) {
    return Container(
                    height: 235,
                    width: 235,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.lightBlue[100],

                    ),

                    child: Center(
                      
                    ),
                  );
  }
}