import 'package:flutter/material.dart';

class info extends StatefulWidget {
  const info({super.key});

  @override
  State<info> createState() => _infoState();
}

class _infoState extends State<info> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 50,left: 5),
          // color: Colors.white70,
          child: Container(
            padding: EdgeInsets.only(left: 100),
            height: 630,
            decoration: BoxDecoration(
              color: Colors.amber,
        
              borderRadius: BorderRadius.circular(30)

            ),
        
            child: Container(
              
            ),
          ),
        ),
      ],
    );
  }
}