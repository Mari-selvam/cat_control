import 'dart:convert';
import 'package:cat_control/controller/Maincontroller.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class NetworkController extends GetxController {
  final Maincontroller controller = Get.put(Maincontroller());

  WebSocketChannel? _channel;
  WebSocketChannel? sensor_channel;
  WebSocketChannel ? joy_stick;

  String address = "";



  @override
  void onInit() {
    super.onInit();
    connectToWebSocket(controller.address.toString());
    print(controller.address.toString());

    // Listen for changes in the address and reconnect the WebSocket
    ever(controller.address, (String newIp) {
      reconnectWebSocket(newIp);
    });
  }

  void reconnectWebSocket(String newIp) async {
    if (_channel != null || sensor_channel != null) {
      await disconnectWebSocket();
    }
    connectToWebSocket(newIp);
  }

  Future<void> disconnectWebSocket() async {
    try {
      await _channel?.sink.close();
      await sensor_channel?.sink.close();
      _channel = null;
      sensor_channel = null;
    } catch (e) {
      print('Error closing WebSocket: $e');
    }
  }

  void connectToWebSocket(String ip) {
    if (ip.isEmpty) return;

    print('Connecting to WebSocket at: ws://$ip:8000');

    _channel = WebSocketChannel.connect(
      Uri.parse('ws://$ip:8000/audio/read_audio'),
    );

    sensor_channel = WebSocketChannel.connect(
      Uri.parse('ws://$ip:8000/sensor/status'),
    );

    joy_stick = WebSocketChannel.connect(
      Uri.parse('ws://$ip:8000/joy_stick'),
    );


    joy_stick?.stream.listen(

       (message) {
        print('Received from audio stream: $message');
      },
      onError: (error) {
        print('Audio WebSocket error: $error');
      },
      onDone: () {
        print('Audio WebSocket closed.');
      },

    );

    _channel?.stream.listen(
      (message) {
        print('Received from audio stream: $message');
      },
      onError: (error) {
        print('Audio WebSocket error: $error');
      },
      onDone: () {
        print('Audio WebSocket closed.');
      },
    );

    sensor_channel?.stream.listen(
      (message) {
        print('Received from sensor stream: $message');
      },
      onError: (error) {
        print('Sensor WebSocket error: $error');
      },
      onDone: () {
        print('Sensor WebSocket closed.');
      },
    );
  }

  void updateIp(String newIp) {
    if (controller.address.value != newIp) {
      controller.address.value = newIp;
    }
  }

  void sendMessage(String data) {
    try {
      _channel?.sink.add(data);
    } catch (e) {
      print('Error sending data: $e');
    }
  }

  void sendJson(Map<String, dynamic> jsonData) {
    try {
      String jsonString = jsonEncode(jsonData);
      sensor_channel?.sink.add(jsonString);
    } catch (e) {
      print('Error sending JSON data: $e');
    }
  }



  void Joystick_data(Map<String, dynamic> jsonData) {
    try {
      String jsonString = jsonEncode(jsonData);
      sensor_channel?.sink.add(jsonString);
    } catch (e) {
      print('Error sending JSON data: $e');
    }
  }

  @override
  void dispose() {
    disconnectWebSocket();
    super.dispose();
  }
}
