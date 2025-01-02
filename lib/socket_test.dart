import 'dart:io';

import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


@override

class Networkcontroller extends GetxController{

  



  final channel = WebSocketChannel.connect(
  Uri.parse('ws://192.168.68.229:8080/audio/read_audio'),
  );



  void send_message(data){

    channel.sink.add(data.toString());

  }


  Future<void> _sendFile(String filePath) async {
    try {
      File file = File(filePath);
      List<int> fileBytes = await file.readAsBytes();
      _webSocket.add(fileBytes);
    } catch (e) {
      print("Error sending file: $e");
    }
  }




  



}