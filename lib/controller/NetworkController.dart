

import 'dart:io';

import 'package:get/get.dart';

class Networkcontroller extends GetxController{
    late WebSocket _webSocket;
    String _serverMessage = "";








  @override
  void onInit() {
    super.onInit();
    _connectToWebSocket();


  }


  Future<void> _connectToWebSocket() async {
    try {
        _webSocket = await WebSocket.connect('ws://192.168.68.229:8080/ws/client133'); // You can use your WebSocket server URL here

      // Listen for messages from the server
      _webSocket.listen((data) {
        setState(() {
          _serverMessage = data;
        });
      });
    } catch (e) {
      print("Error connecting to WebSocket: $e");
    }
  }

  // Send a message to the WebSocket server
  void _sendMessage() {
    _webSocket.add(_controller.text);
  }

  // Send a file to the WebSocket server
  


  







}