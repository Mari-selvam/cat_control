import 'package:flutter/material.dart';

class Map_View extends StatefulWidget {
  const Map_View({super.key});

  @override
  State<Map_View> createState() => _Map_ViewState();
}

class _Map_ViewState extends State<Map_View> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Container(
            width: 850,
            height: 630,
            decoration: BoxDecoration(
        
              color: Colors.lightGreenAccent,

              borderRadius: BorderRadius.circular(30)

            ),
          ),
        )
      
      ],
      
      
    );
  }
}