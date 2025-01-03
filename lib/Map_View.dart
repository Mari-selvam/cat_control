import 'package:cat_control/buttom.dart';
import 'package:cat_control/controller/Maincontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Map_View extends StatefulWidget {
  const Map_View({super.key});

  @override
  State<Map_View> createState() => _Map_ViewState();
}

class _Map_ViewState extends State<Map_View> {

  late GoogleMapController mapController;
  LocationData? currentLocation;
  final Location location = Location();
  BitmapDescriptor? customIcon;  
  
  Maincontroller controler = Get.put(Maincontroller());
  bool _isSatelliteView = false;




  




  
  @override
  void initState() {
    super.initState();
    _getLocation();
    _loadCustomMarker();

  }

  Future<void> _loadCustomMarker() async {
    customIcon = await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(10, 10)),
      'assets/chair-icon.png',
      height: 80,
      width: 80
    );
  }



  Future<void> _getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

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

  
    location.onLocationChanged.listen((LocationData currentLocation) {
      print(currentLocation.latitude.toString());
      setState(() {
        this.currentLocation = currentLocation;
      });
    });
  }
  
  
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }











  Widget build(BuildContext context) {

    final List<LatLng> polygonCoords = [
      LatLng(8.736291333280269, 77.72686885009662),
      LatLng(8.736264429894662, 77.72716881814067),
      LatLng(8.735475116068018, 77.72723096404046),
    ];

    // Create the polygon
    final Polyline polygon = Polyline(
      
        polylineId: PolylineId('polygon'),
        points: polygonCoords,
        color: Colors.black,
        width: 15,
      

    );

    return Column(
      children: [

        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Container(
            width: 870,
            height: 400,

              
            decoration: BoxDecoration(
        
              color: Colors.black,

              borderRadius: BorderRadius.circular(30)

            ),
            child:ClipRRect(
                  borderRadius: BorderRadius.circular(30), // Adjust the radius as needed
                  child: currentLocation == null ? Center(child: CircularProgressIndicator())
                  : 
                  GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: 25,
              ),
              mapType: controler.mapType,
              mapToolbarEnabled: false,
              // polylines: {polygon},
              indoorViewEnabled: true,
              fortyFiveDegreeImageryEnabled: bool.fromEnvironment("false"),





              markers: {
                if(currentLocation != null)
                  Marker(
                    markerId: MarkerId('currentLocation'),
                    position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                    icon: customIcon ?? BitmapDescriptor.defaultMarker,
                    
                    
                    )
                
                
              },
              
            ),
                ),
          ),
          

        ),
        SizedBox(height: 10,),
        
        Container(

        
          padding: EdgeInsets.only(top: 10.0),
        
          width:870 ,
          height: 235,
          decoration: BoxDecoration(
              // color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(30)
              

            ),
            


            

            child: bottom()
            
          
            
            
            
        ),
        
      
      ],
      
      
    );
  }
}