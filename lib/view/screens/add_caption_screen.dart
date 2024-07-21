import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_x_tutorial/constants.dart';
import 'package:get_x_tutorial/controller/upload_video_controller.dart';
import 'package:get_x_tutorial/view/widgets/text_input.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';

class AddCaptionScreen extends StatefulWidget {

  File videoFile;
  String videoPath;
  AddCaptionScreen({super.key, required this.videoFile, required this.videoPath});

  @override
  State<AddCaptionScreen> createState() => _AddCaptionScreenState();
}

class _AddCaptionScreenState extends State<AddCaptionScreen> {

  UploadVideoController uploadVideoController = Get.put(UploadVideoController());
  late VideoPlayerController videoPlayerController;
  TextEditingController songNameController = TextEditingController();
  TextEditingController captionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    setState(() {
      videoPlayerController = VideoPlayerController.file(widget.videoFile);
    });
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.6,
                width: MediaQuery.of(context).size.width,

                child: VideoPlayer(videoPlayerController),
              ),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextInputField(controller: songNameController, myIcon: Icons.music_note_rounded, myLabelText: 'Song name',),
                    const SizedBox(height: 10,),
                    TextInputField(controller: captionController, myIcon: Icons.closed_caption, myLabelText: 'Caption',),
                    const SizedBox(height: 10,),
                    ElevatedButton(onPressed: (){
                      uploadVideoController.uploadVideo(songNameController.text, captionController.text, widget.videoFile);
                    },  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(buttonColor)), child: const Text("Upload"))

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
