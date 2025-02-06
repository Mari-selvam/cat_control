import 'dart:async';
import 'dart:ffi';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:location/location.dart';

class Maincontroller extends GetxController {

  bool map = false;

  var address = "".obs ;

  double location_accuracy = 0;

  dynamic pi = 3.14;
  

  void Calculate_angle(A){

    // print("Angle");
    // print((angle * ( pi/ 180) * -1),);
    //  print("Direction ");
    // print(angle);


  }
  


  var x;
  var y;


  bool mic = true;
  bool isSelected = false;

  bool audio_recording = false;

  var audio_icon = Icons.volume_up;

  double angle = 0;



  double turns = 0.00;

  bool view = true;

  void rotateArrow() {
    turns += 0.25; 
    update();
  }


  // 


    LocationData? currentLocation;

    String? recordedFilePath;
    final RecorderController recorderController = RecorderController(
      

    ); 



    


    @override
    void onInit() {
      super.onInit();

      _getLocation();
      recorderController.checkPermission();

      Timer.periodic(Duration(seconds: 1), Calculate_angle);

    }

    @override
    void dispose() {
      recorderController.dispose();
      super.dispose();
    }


    



  Future<void> _getLocation() async {
    Location location = Location();


    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    // print("----------------------------vvvvvvvvvvvvvvvvvvvvvvvvvvvv");

    // print(_serviceEnabled);
    // print("----------------------------vvvvvvvvvvvvvvvvvvvvvvvvvvvv");

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    location.changeSettings(
    accuracy: LocationAccuracy.high,
    interval: 100, // Update interval in milliseconds
    distanceFilter: 0.5, // Minimum distance change in meters to trigger an update
  );

    // print("mmmmmmmmmmmmmmvvvvvvvvvvvvvvvvvvvvvvvvvvvv");


  
    location.onLocationChanged.listen((LocationData currentLocation) {
      // this.currentLocation = currentLocation;
    // print("----------------------------vvvvvvvvvvvvvvvvvvvvvvvvvvvv");
      print(currentLocation.latitude);

    // print("----------------------------vvvvvvvvvvvvvvvvvvvvvvvvvvvv");


    });
  }
  





  
  




}