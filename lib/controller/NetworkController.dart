import 'dart:convert';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class NetworkController extends GetxController{

  @override
  void onInit() {
    super.onInit();

  }


  bool safe = true;
  


  final _channel = WebSocketChannel.connect(
    Uri.parse('ws://192.168.210.229:8000/audio/read_audio'),
  );


  final sensor_channel = WebSocketChannel.connect(
    Uri.parse('ws://192.168.210.229:8000/sensor/status'),
  );




  // ignore: unused_element
  void sendMessage(String data) {
  
  try {
    _channel.sink.add(data);
  } catch (e) {
    print('Error sending data: $e');
  }
  
  }

  void sendJson(Map<String, dynamic> jsonData) {
  try {
    String jsonString = jsonEncode(jsonData);
    sensor_channel.sink.add(jsonString);
  } catch (e) {
    print('Error sending JSON data: $e');
  }
}



  @override
  void dispose() {
    // _channel.sink.close();
    super.dispose();
  }










}