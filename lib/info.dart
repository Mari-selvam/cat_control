import 'dart:convert';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cat_control/controller/Maincontroller.dart';
import 'package:cat_control/controller/NetworkController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:get/get.dart';
import 'package:ripple_wave/ripple_wave.dart';
import 'package:wave_blob/wave_blob.dart';

class info extends StatefulWidget {
  info({super.key});



  @override
  State<info> createState() => _infoState();

}

class _infoState extends State<info> {

  double _x = 0;
  double _y = 0;
  var step = 10.0;


  Maincontroller contrller = Get.put(Maincontroller());

  NetworkController networkController = Get.put(NetworkController());

  final player = AudioPlayer();
  var audio_encode;


  @override
  Widget build(BuildContext context) {
  return Center(
    child: Container(
    height: 650,
    padding: EdgeInsets.only(top: 15),
    decoration: BoxDecoration(
      color:Color(0xFFfffafa),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Align children horizontally
      children: <Widget>[
    
        Column( 
        
          crossAxisAlignment: CrossAxisAlignment.start, // Adjust alignment
          children: <Widget>[
    
            RippleWave(
              child: Container(
                        width: 380,
                        height: 300,
                        padding: EdgeInsets.only(left: 0,top: 50),
                        // color: Colors.blue,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/chair-top.png")),
                        ),
                      ),
            color: const Color.fromARGB(255, 39, 255, 226),
    
            waveCount: 5,

            duration: Duration(seconds: 5),

            childTween: ConstantTween(0.8),
    
    
            
    
            ),

            SizedBox(height: 30,),
            
            
            Row(
              children: [
                SizedBox(width: 250/3.5,)
                ,
                Container( 
                
                  height: 230,
                  width: 250,
                  // padding: EdgeInsets.only(top: 10,left: 60),
                  
                  // child: TextButton(onPressed: (){}, child:Image.asset("assets/mic.png",height: 140,width: 150,))
                    
                  child: GetBuilder<Maincontroller>(
                    init: Maincontroller(),
                    builder: (controller) =>
                      controller.mic?
                      Container(
                        

                        // height: 230,
                        // width: 250,
                        child:WaveBlob(
                          scale: 0.3,
                          child:TextButton(onPressed: () async{


                            if(controller.audio_recording == false){

                              controller.audio_recording = true;
                              controller.update();

                              if ( controller.recorderController.hasPermission){
                                  
                                    controller.recorderController.record(
                                      
                                    );
                                  controller.update();
                                }

                            }
                            else if(controller.audio_recording == true){

                              controller.audio_recording = false;

                              if (controller.recorderController.isRecording) {
                                  controller.recordedFilePath = await controller.recorderController.stop();
                                  print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
                                  print(controller.recordedFilePath);
                                  print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");


                                player.play(UrlSource(controller.recordedFilePath.toString()));

                                var path = controller.recordedFilePath.toString();

                                File file = File(path);
                                file.openRead();
                                var contents = await file.readAsBytes();
                                var base64File = base64.encode(contents);

                                print(base64File);

                                networkController.sendMessage(base64File.toString());
                                networkController.update();



                                controller.update();



                            }
                        }

                            

                            
                      }, 
                          child:Image.asset("assets/mic.png",height: 140/2,width: 150/2,)),
                          amplitude: controller.audio_recording ? 5000:100,

                          ),
                    
                        
                        
                    
                      )
                      
                    
                      :
                      Joystick(  
                        base: JoystickBase(  
                          decoration: JoystickBaseDecoration(    
                            color: Colors.black,    
                            drawOuterCircle: false,  
                            ),  
                          arrowsDecoration: JoystickArrowsDecoration(      
                            color: Colors.blue,    
                            ),  ),  
                            listener: (details) {
                                setState(() {
                                    _x = (details.x * 100).roundToDouble();
                                    _y = (details.y * 100).roundToDouble();

                                    print("($_x, $_y)");

                                    Map <dynamic,double> joy_stick = {
                                      "x":_x,
                                      "y":_y

                                    };

                                    



                                  networkController.sendJson(joy_stick.cast<String, double>());


                              });

                            },
                            
                            
                            
                            
                        )
                    
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),

            Row(

            children: [
              SizedBox(width: 20,),
            Container(
              
              height: 35,
              width: 350,
              // color: Colors.amber,
    
              
              
              child: 
              
              AudioWaveforms(
                size: Size(350, 35), 
                recorderController: contrller.recorderController,
                waveStyle: WaveStyle(
                  extendWaveform:true,
                  waveThickness: 4.0,
                  scaleFactor:40.0,
                  durationLinesHeight: 0.0,
                  showMiddleLine:false,
                  waveColor : Colors.lightBlue





                ),
                shouldCalculateScrolledPosition : true




              ),

    
    
            )
            ]
            )
            
            
    
          ],
          
        ),
        
      ],
    ),
    ),
  );

  }
}